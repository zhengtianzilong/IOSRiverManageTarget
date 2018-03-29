//
//  ZLNewFilesUpLoadService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"
#import "ACMediaModel.h"
@interface ZLNewFilesUpLoadService : ZLCustomBaseRequest
- (instancetype)initWithImage:(NSArray<ACMediaModel *> *)imageArray;
@end
