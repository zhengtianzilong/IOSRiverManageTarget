//
//  ZLTaskIncidentListModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLTaskIncidentListModel

@end
@interface ZLTaskIncidentListModel : JSONModel
@property (nonatomic , copy) NSString<Optional>              * ID;
@property (nonatomic , copy) NSString<Optional>              * incidentType;
@property (nonatomic , copy) NSString<Optional>              * incidentCode;
@property (nonatomic , copy) NSString<Optional>              * oprateCode;
@property (nonatomic , copy) NSString<Optional>              * oprateName;

@property (nonatomic , copy) NSString<Optional>              * descri;

@property (nonatomic , copy) NSString<Optional>              * opreaterCode;

@property (nonatomic , copy) NSString<Optional>              * oprateTime;

@end
