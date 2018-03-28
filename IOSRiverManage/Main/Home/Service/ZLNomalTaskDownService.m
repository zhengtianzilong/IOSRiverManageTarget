//
//  ZLNomalTaskDownService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLNomalTaskDownService.h"

@interface ZLNomalTaskDownService (){
    NSString *_taskName;
    NSString *_taskContent;
    NSString *_liable_id;
    NSString *_userid;
    NSString *_dataImgBase;
}

@end
@implementation ZLNomalTaskDownService
- (instancetype)initWithtaskName:(NSString *)taskName
                     taskContent:(NSString *)taskContent
                       liable_id:(NSString *)liable_id
                          userid:(NSString *)userid
                     dataImgBase:(NSString *)dataImgBase{
    
    self = [super init];
    if (self) {
        _taskName = taskName;
        _taskContent = taskContent;
        
        _liable_id = liable_id;
        if (_liable_id == nil) {
            _liable_id = @"";
        }
        _userid= userid;
        _dataImgBase= dataImgBase;
        
    }
    return self;
    
}

- (NSString *)requestUrl {
    return River_NormalTaskDownUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}



- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

//- (YTKResponseSerializerType)responseSerializerType{
//    return YTKResponseSerializerTypeHTTP;
//}

- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _taskName,@"taskName",
                         _taskContent,@"taskContent",
                         _liable_id,@"liable_id",
                         _userid,@"id",
                         _dataImgBase,@"dataImgBase",
                         nil];
    return dic;
//    return @{@"taskName":_taskName,
//             @"taskContent":_taskContent,
//             @"liable_id":_liable_id,
//             @"id":_userid,
//             @"dataImgBase":_dataImgBase
//             };
    
    
}
@end
