//
//  ZLUploadImagesModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLTaskInfoImageListModel.h"

@interface ZLUploadImagesModel : ZLBaseModel

@property (nonatomic, strong) NSArray<Optional, ZLTaskInfoImageListModel> *data;

@end
