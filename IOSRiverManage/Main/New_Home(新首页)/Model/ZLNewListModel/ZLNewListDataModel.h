//
//  ZLNewListDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLNewListDataModel

@end
@interface ZLNewListDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *img;

@property (nonatomic, strong) NSString<Optional> *TITLE_PLUS;
@property (nonatomic, strong) NSString<Optional> *TITLE;
@property (nonatomic, strong) NSString<Optional> *ID;

@property (nonatomic, strong) NSString<Optional> *CONTENT;

@property (nonatomic, strong) NSString<Optional> *CREATE_TIME;

@property (nonatomic, strong) NSString<Optional> *AREA_CODE;

@property (nonatomic, strong) NSString<Optional> *TYPE;

@property (nonatomic, strong) NSString<Optional> *url;
@end
