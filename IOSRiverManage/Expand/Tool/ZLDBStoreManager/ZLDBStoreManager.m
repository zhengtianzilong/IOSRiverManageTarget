//
//  ZLDBStoreManager.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLDBStoreManager.h"

@implementation ZLDBStoreManager

+ (ZLDBStoreManager *)shareDbStoreManager{
    
    static ZLDBStoreManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ZLDBStoreManager alloc]init];
        [manager createDB];
    });
    return manager;
}

- (YTKKeyValueStore *)createDB{
    
    return [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
}

@end
