//
//  ZLGetScoreDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLGetScoreDetailModel

@end

@interface ZLGetScoreDetailModel : JSONModel
@property (nonatomic , copy) NSString<Optional>              *scoreId;
@property (nonatomic , copy) NSString<Optional>              *detailId;
@property (nonatomic , copy) NSString<Optional>              *quotaName;
@property (nonatomic , copy) NSString<Optional>              *type;
@property (nonatomic , copy) NSString<Optional>              *content;
@property (nonatomic , copy) NSString<Optional>              *score;
@property (nonatomic , copy) NSString<Optional>              *selfComment;
@property (nonatomic , copy) NSString<Optional>              *itemName;
@property (nonatomic , copy) NSString<Optional>              *modelCode;
@property (nonatomic , copy) NSString<Optional>              *quota;
@property (nonatomic , copy) NSString<Optional>              *modelDetailCode;
@property (nonatomic , copy) NSString<Optional>              *checkComment;
@property (nonatomic , copy) NSString<Optional>              *managerDetailCode;


//@property (nonatomic , copy) NSString<Optional>              *inputScore;



@end
