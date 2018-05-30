//
//  ZLCommitMyScoreService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCommitMyScoreService.h"
#import "ZLGetScoreDetailArrayModel.h"
@interface ZLCommitMyScoreService (){
    NSArray *_array;
    
    NSString *_managerDetailCode;
    NSString *_modelCode;
    NSString *_flag;
    
}

@end
@implementation ZLCommitMyScoreService

- (instancetype)initWithArray:(NSArray *)array
            managerDetailCode:(NSString *)managerDetailCode
                   modelCode :(NSString *)modelCode
                       flag  :(NSString *)flag{
    self = [super init];
    if (self) {
        _array = array;
        _managerDetailCode = managerDetailCode;
        _modelCode = modelCode;
        _flag = flag;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_SaveMyScoreUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    
//    {
//        "flag": "save",
//        "managerDetailCode": "100123",
//        "rows": [
//                 {
//                     "selfComment": "0",
//                     "type": "2",
//                     "detailId": "402880d363af9dca0163afb0765f0052",
//                     "scoreId": "402880d363af9dca0163afb1306b005d"
//                 }
//                 ],
//        "modelCode": "100043"
//    }
    
    NSMutableArray *rows = [NSMutableArray array];
    
    for (ZLGetScoreDetailArrayModel *arrayModel in _array) {
        
        for (ZLGetScoreDetailModel *detailModel in arrayModel.list) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 detailModel.selfComment,@"selfComment",
                                 detailModel.type,@"type",
                                 detailModel.detailId,@"detailId",
                                 detailModel.scoreId,@"scoreId",
                                 detailModel.score,@"score"
                                 ,nil];
            
            [rows addObject:dic];
            
            
        }
    }

    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         rows,@"rows",
                         _managerDetailCode,@"managerDetailCode",
                         _modelCode,@"modelCode",
                         _flag,@"flag",nil];
    return dic;
    
}
@end
