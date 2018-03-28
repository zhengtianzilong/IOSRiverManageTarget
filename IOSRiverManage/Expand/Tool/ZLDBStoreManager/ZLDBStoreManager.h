//
//  ZLDBStoreManager.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKKeyValueStore.h"
@interface ZLDBStoreManager : NSObject

+ (ZLDBStoreManager *)shareDbStoreManager;
- (YTKKeyValueStore *)createDB;
@end
