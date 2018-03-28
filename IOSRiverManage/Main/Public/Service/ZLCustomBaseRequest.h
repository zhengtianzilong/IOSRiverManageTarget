//
//  ZLCustomBaseRequest.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/12.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import <CommonCrypto/CommonDigest.h>
@interface ZLCustomBaseRequest : YTKBaseRequest


/**
 全局的时间 yyyyMMDDHH
 */
@property (nonatomic, strong) NSString *baseTime;


/**
 全局时间戳
 */
@property (nonatomic, strong) NSString *timer;

- (NSString *)md5StringFromString:(NSString *)string;

-(void)getTime;

//- (NSString *)getURL;

@end
