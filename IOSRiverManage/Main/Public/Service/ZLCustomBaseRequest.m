//
//  ZLCustomBaseRequest.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/12.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@implementation ZLCustomBaseRequest

- (NSString *)baseUrl{
    return Base_URL;
}

- (NSTimeInterval)requestTimeoutInterval{
    return 10;
}

-(void)getTime{
    // 得到当前时间戳
    NSString *time = [self getCurrenttTimer];
    
    self.timer = time;
    
    // 通过时间戳得到当前时间,格式是yyyyMMddHH
    NSString *xidTime = [self getTimeFromTimer:time];
    
    self.baseTime = xidTime;
}


- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    
    [self getTime];
    
    //    "singon|33900|" + xdate.format("yyyyMMdd") + "/" + url
    
    // 拼接 singon|33900| 与当前时间 与 接口
    NSString *xid = [NSString stringWithFormat:@"%@%@",@"singon|33900|",self.baseTime];
    
    // 将xid转成md5
    NSString *md5 = [self md5StringFromString:xid];
    
    // 拼接 singon| 加上 md5
    NSString *xidMd5 = [NSString stringWithFormat:@"%@%@",@"singon|",md5];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:DBUserToken];
    
    if (token == nil) {
        token = @"";
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[token,@"phone",self.timer,xidMd5] forKeys:@[@"TOKEN",@"loginType",@"xdate",@"xid"]];
    
    return dic;
    
    //TOKEN:
    //loginType:phone
    
    
}


//- (NSString *)getURL{
//    return @"/soa/user/login";
//}

- (NSString *)md5StringFromString:(NSString *)string {
    NSParameterAssert(string != nil && [string length] > 0);
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}

/**
 得到当前的时间戳
 */
- (NSString *)getCurrenttTimer{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    // 乘以1000是为了和java对其,Java是13位,IOS是10位
    NSTimeInterval timer = [date timeIntervalSince1970] * 1000;
    NSString *currentTime = [NSString stringWithFormat:@"%.0f",timer];
    return currentTime;
    
}


/**
 通过时间戳得到时间
 
 @param timer 时间戳
 @return 返回时间戳
 */
- (NSString *)getTimeFromTimer:(NSString *)timer{
    
    // timeStampString 是服务器返回的13位时间戳
    NSString *timeStampString  = timer;
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHH"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}



@end
