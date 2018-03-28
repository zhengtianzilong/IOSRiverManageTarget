//
//  ZLPatrolCoordinateModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLPatrolCoordinateModel

@end
@interface ZLPatrolCoordinateModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *ID;

@property (nonatomic, strong) NSString<Optional> *partolCode;
@property (nonatomic, strong) NSString<Optional> *longitude;
@property (nonatomic, strong) NSString<Optional> *latitude;
@property (nonatomic, strong) NSString<Optional> *createTime;
@end
