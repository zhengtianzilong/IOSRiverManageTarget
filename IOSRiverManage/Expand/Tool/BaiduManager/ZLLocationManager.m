//
//  ZLLocationManager.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLocationManager.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import "NSTimer+Blocks.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@import AddressBookUI;
#define minDistance 5
static BMKLocationService *locationService;
@interface ZLLocationManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

@property (nonatomic, strong) CLGeocoder *geoder;


@end

@implementation ZLLocationManager
{
    NSInteger i;
}
- (NSMutableArray<CLLocation *> *)locations{
    if (!_locations) {
        _locations = [NSMutableArray new];
    }
    return _locations;
}

- (NSMutableArray *)locationsAndAddress{
    if (!_locationsAndAddress) {
        _locationsAndAddress = [NSMutableArray new];
    }
    return _locationsAndAddress;
}


+(ZLLocationManager *)shareLocationManager{
    //    //单例
    static ZLLocationManager *manager = nil;
    static dispatch_once_t oneToke;
    dispatch_once(&oneToke, ^{
        manager = [ZLLocationManager new];
    });
    return manager;
}

#pragma mark - BMKLocationServiceDelegate

- (void)didFailToLocateUserWithError:(NSError *)error{
    ZLLog(@" 定位失败 error %@",error);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation  {
    _userLocation = userLocation;
    
    CLLocation *location  = userLocation.location;
    // 如果此时位置更新的水平精准度大于10米，直接返回该方法
    // 可以用来简单判断GPS的信号强度
    //horizontalAccuracy:半径不确定性的中心点，以米为单位。 该地点的纬度和经度确定的圆的圆心，该值表示在该圆的半径。负值表示位置的经度和纬度是无效的。
    [self geoResult:userLocation];
    if (location.horizontalAccuracy<0||location.horizontalAccuracy>20.0) {
        
        _geoCodeSearch.delegate = nil;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:@"提示:定位误差较大" message:@"亲，请再室外使用，并尽量避免高大的建筑物。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //自动关闭 UIAlertView
            
            [alert show];
            
           [NSTimer scheduledTimerWithTimeInterval:3 block:^{
               
               [alert dismissWithClickedButtonIndex:0 animated:YES];
           } repeats:NO];
            
//            [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
//                
//            }];
        });
        
        
    }else{
        
//        ZLLog(@"dingwei:纬度：%lf,经度：%lf",location.coordinate.latitude,location.coordinate.longitude);
        
        if(self.locations.count>1){
            _geoCodeSearch.delegate = self;
            //计算本次定位数据与上一次定位之间的距离
            CGFloat distance = [location distanceFromLocation:[self.locations lastObject]];
            // (5.0米门限值，存储数组画线) 如果距离少于 5.0 米，则忽略本次数据直接返回方法
            if (distance > minDistance) {
                _totalDistanc += distance;
                //  _timestamp = location.timestamp;
                _speed = location.speed;
                
            }else{
                //不添加较近的两点
                if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
                    //程序处于前台
                    [self.delegate locationManage:self didUpdateLocations:self.locations];
                }
                return;
            }
        }
        [self.locations addObject:location];
    }
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        //程序处于前台
        [self.delegate locationManage:self didUpdateLocations:self.locations];
    }
}

- (void)startUpdatingLocation{
    ZLLog(@"startUpdatingLocation");
    [self.locations removeAllObjects ];
    [_locationsAndAddress removeAllObjects];
    if (_running) {
        return;//已经在定时
    }
    
    if (locationService == nil) {
        locationService = [BMKLocationService new];
        if ([UIDevice currentDevice].systemVersion.doubleValue >= 9.0) {
            locationService.allowsBackgroundLocationUpdates = YES;
            
            //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
            
        }
        
        locationService.desiredAccuracy = kCLLocationAccuracyBest;
        locationService.pausesLocationUpdatesAutomatically = NO;/// 指定定位是否会被系统自动暂停。默认为YES。只在iOS 6.0之后起作用。
        locationService.delegate = self;

    }
    
    // _timerNumber = 0;
    _totalDistanc = 0;
    _running = YES;
    if ([self.delegate respondsToSelector:@selector(locationManage: didChangeUpdateLocationState:)]){
        [self.delegate locationManage:self didChangeUpdateLocationState:_running];
    }
    

    [locationService startUserLocationService];
    
    _geoder = [[CLGeocoder alloc]init];
    _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    _geoCodeSearch.delegate = self;//设置代理为self
    _startLocationDate = [NSDate new];
    
}

// 4.00 85%电
- (void)geoResult:(BMKUserLocation *)loction{
    
    ZLLog(@"%f",loction.location.coordinate.longitude);
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};//初始化
    if (loction.location.coordinate.longitude!= 0
        && loction.location.coordinate.latitude!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        pt = (CLLocationCoordinate2D){loction.location.coordinate.latitude,
            loction.location.coordinate.longitude};
    }
    
    NSString *longitude = [NSString stringWithFormat:@"%f",loction.location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",loction.location.coordinate.latitude];
    
    [self.geoder reverseGeocodeLocation:loction.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error||placemarks.count==0) {
        
        }else//编码成功
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            
            NSString *address = ABCreateStringWithAddressDictionary(firstPlacemark.addressDictionary, YES);
            
            NSString *detailAddress = [[address stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            ZLLog(@"%@",detailAddress);
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
            longitude,@"longitude",latitude,@"latitude",detailAddress,@"address", nil];
            [self.locationsAndAddress addObject:dic];
            
        }
    }];
    
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
//
//    BOOL flag = [_geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
//    if(flag)
//    {
//        ZLLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        ZLLog(@"反geo检索发送失败");
//    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (result == nil) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:result.address forKey:@"address"];
    
    NSString *longitude = [NSString stringWithFormat:@"%f",result.location.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",result.location.latitude];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:longitude,@"longitude",latitude,@"latitude",result.address,@"address", nil];
    
//    NSDictionary *dic = @{@"longitude":longitude,
//                          @"latitude":latitude,
//                          @"address":
//                              };
    [self.locationsAndAddress addObject:dic];
//    ZLLog(@"%@  %@",result.address,result.addressDetail);
    
}

//- (void)suspendUpdatingLocation{
//
//}

- (void)stopUpdatingLocation{
    ZLLog(@"stopUpdatingLocation");
    
    [locationService stopUserLocationService];
    locationService = nil;
    _geoCodeSearch = nil;
    _running = false;
    
    if ([self.delegate respondsToSelector:@selector(locationManage: didChangeUpdateLocationState:)]){
        [self.delegate locationManage:self didChangeUpdateLocationState:_running];
    }
    
}
@end
