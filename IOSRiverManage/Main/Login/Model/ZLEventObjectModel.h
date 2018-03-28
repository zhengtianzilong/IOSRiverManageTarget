//
//  ZLEventObjectModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZLEventObjectModel : JSONModel<NSCoding>

@property (nonatomic ,strong) NSString<Optional> *idObject;

@property (nonatomic ,strong) NSString<Optional> *realname;

@property (nonatomic ,strong) NSString<Optional> *departname;

@end
