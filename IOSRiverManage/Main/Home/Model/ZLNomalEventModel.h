//
//  ZLNomalEventModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@interface ZLNomalEventModel : JSONModel
@property (nonatomic ,strong) NSString<Optional> *createTime;

@property (nonatomic ,strong) NSString<Optional> *enclosure;

@property (nonatomic ,strong) NSString<Optional> *eventiId;

@property (nonatomic ,strong) NSString<Optional> *operatorID;

@property (nonatomic ,strong) NSString<Optional> *reportContent;

@property (nonatomic ,strong) NSString<Optional> *reportId;
@property (nonatomic ,strong) NSString<Optional> *status;
@property (nonatomic ,strong) NSString<Optional> *userId;
@property (nonatomic ,strong) NSString<Optional> *userIds;

@end
