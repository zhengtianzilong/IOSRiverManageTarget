//
//  ZLTaskWaitDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLTaskWaitDataModel

@end
@interface ZLTaskWaitDataModel : JSONModel
@property (nonatomic , copy) NSString<Optional>              * taskId;
@property (nonatomic , copy) NSString<Optional>             * createName;
@property (nonatomic , copy) NSString<Optional>              * userName;
@property (nonatomic , copy) NSString<Optional>              * taskDetailId;
@property (nonatomic , copy) NSString<Optional>              * taskChildCode;
@property (nonatomic , copy) NSString<Optional>              * taskName;
@property (nonatomic , copy) NSString<Optional>              * taskDetailStatus;
@property (nonatomic , copy) NSString<Optional>              * approvalOpinion;
@property (nonatomic , copy) NSString<Optional>              * fileAddr;
@property (nonatomic , copy) NSString<Optional>              * taskHaveRiver;
@property (nonatomic , copy) NSString<Optional>              * createTime;
@property (nonatomic , copy) NSString<Optional>              * taskContent;
@end
