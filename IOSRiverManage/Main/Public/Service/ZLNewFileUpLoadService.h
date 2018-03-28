//
//  ZLNewFileUpLoadService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"
#import "ACMediaModel.h"
@interface ZLNewFileUpLoadService : ZLCustomBaseRequest
- (instancetype)initWithImage:(ACMediaModel *)imageModel;
@end
