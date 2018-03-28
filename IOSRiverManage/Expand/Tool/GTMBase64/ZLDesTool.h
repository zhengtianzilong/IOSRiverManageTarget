//
//  ZLDesTool.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
@interface ZLDesTool : NSObject
+ (NSString *)decryptWithText:(NSString *)sText;
@end
