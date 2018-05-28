//
//  ZLHaveExamineModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLHaveExamineModel

@end
@interface ZLHaveExamineModel : JSONModel
@property (nonatomic , copy) NSString<Optional>              *managerCode;
@property (nonatomic , copy) NSString<Optional>              *selfComment;
@property (nonatomic , copy) NSString<Optional>              *endTime;
@property (nonatomic , copy) NSString<Optional>              *startTime;
@property (nonatomic , copy) NSString<Optional>              *ID;
@property (nonatomic , copy) NSString<Optional>              *managerDetailCode;
@property (nonatomic , copy) NSString<Optional>              *checkComment;
@property (nonatomic , copy) NSString<Optional>              *score;
@property (nonatomic , copy) NSString<Optional>              *status;
@property (nonatomic , copy) NSString<Optional>              *modelName;
@property (nonatomic , copy) NSString<Optional>              *updateTime;
@end
