//
//  ZLRiverDownTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverDownTaskService.h"
@interface ZLRiverDownTaskService (){
    NSString *_taskName;
    NSString *_taskContent;
    NSString *_positionDesc;
    NSString *_uuid;
    NSString *_type;
    NSString *_lgt;
    NSString *_lat;
    NSString *_liable_id;
    NSString *_uid;
    NSString *_dataImgBase;
}

@end
@implementation ZLRiverDownTaskService
- (instancetype)initWithtaskName:(NSString *)taskName
                     taskContent:(NSString *)taskContent
                    positionDesc:(NSString *)positionDesc
                            uuid:(NSString *)uuid
                            type:(NSString *)type
                             lgt:(NSString *)lgt
                             lat:(NSString *)lat
                       liable_id:(NSString *)liable_id
                             uid:(NSString *)uid
                     dataImgBase:(NSString *)dataImgBase{
    
    self = [super init];
    if (self) {
        _taskName = taskName;
        _taskContent = taskContent;
        _positionDesc = positionDesc;
        _uuid = uuid;
        _type = type;
        _lgt = lgt;
        _lat = lat;
        _liable_id = liable_id;
        if (_liable_id == nil) {
            _liable_id = @"";
        }
        _uid = uid;
        _dataImgBase = dataImgBase;
        
    }
    return self;
    
}

- (NSString *)requestUrl {
    return River_DownRiverTaskUrl;
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
                         _positionDesc,@"positionDesc",
                         _uuid,@"uuid",
                         _type,@"type",
                         _lgt,@"lgt",
                         _lat,@"lat",
                         _liable_id,@"liable_id",
                         _uid,@"uid",
                         _dataImgBase,@"dataImgBase",
                         nil];
    return dic;
//    return @{@"taskName":_taskName,
//             @"taskContent":_taskContent,
//             @"positionDesc":_positionDesc,
//             @"uuid":_uuid,
//             @"type":_type,
//             @"lgt":_lgt,
//             @"lat":_lat,
//             @"liable_id":_liable_id,
//             @"uid":_uid,
//             @"dataImgBase":_dataImgBase
//             };
    
}


@end

