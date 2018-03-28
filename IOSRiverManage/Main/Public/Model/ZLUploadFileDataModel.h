//
//  ZLUploadFileDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZLUploadFileDataModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *ext;
@property (nonatomic, strong) NSString<Optional> *fileName;
@property (nonatomic, strong) NSString<Optional> *orgName;
@end
