//
//  ZLLoginModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>


//{
//    "timeStamp":1505709467,
//    "realName":"管理员",
//    "signature":"DYisdxlc1WpmdAcW9REel/95daA=",
//    "levelName":"宿迁河长",
//    "ret_code":"0000",
//    "userId":"8a8ab0b246dc81120146dc8181950052",
//    "ret_data":"http://192.168.0.250:18081/hzz/phoneController.do?home&token=HZZUSER-920fa937722640beaa634774d3dbf8e4-cas"
//}

@interface ZLLoginModel : JSONModel<NSCoding>

@property (nonatomic ,strong) NSString<Optional> *timeStamp;

@property (nonatomic ,strong) NSString<Optional> *realName;

@property (nonatomic ,strong) NSString<Optional> *signature;

@property (nonatomic ,strong) NSString<Optional> *levelName;

@property (nonatomic ,strong) NSString<Optional> *ret_code;

@property (nonatomic ,strong) NSString<Optional> *userId;

@property (nonatomic ,strong) NSString<Optional> *ret_data;

@property (nonatomic ,strong) NSString<Optional> *type;
@property (nonatomic ,strong) NSString<Optional> *version;

@end
