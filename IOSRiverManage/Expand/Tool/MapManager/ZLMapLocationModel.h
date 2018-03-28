//
//  ZLMapLocationModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLMapLocationModel : NSObject
/**
 经度
 */
@property (nonatomic, strong) NSString *longitude;

/**
 纬度
 */
@property (nonatomic, strong) NSString *latitude;


/**
 详细地址
 */
@property (nonatomic, strong) NSString *addressDetail;

//- (instancetype)initWithlongitude:(NSString)longitude
//                         latitude:(NSString)latitude
//                    addressDetail:(NSString)addressDetail;



@end
