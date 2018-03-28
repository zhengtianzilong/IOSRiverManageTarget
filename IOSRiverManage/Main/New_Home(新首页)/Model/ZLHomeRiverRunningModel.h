//
//  ZLHomeRiverRunningModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/21.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLNewUserRiversDataModel.h"
@interface ZLHomeRiverRunningModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *riverTitle;

@property (nonatomic, strong) NSString<Optional> *time;

@property (nonatomic, strong) NSString<Optional> *userName;

@property (nonatomic, strong) NSString *riverData;

@end
