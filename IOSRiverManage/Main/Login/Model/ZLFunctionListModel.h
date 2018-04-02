//
//  ZLFunctionListModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLFunctionListModel

@end
@interface ZLFunctionListModel : JSONModel
@property (nonatomic ,strong) NSString<Optional> *functionCode;

@property (nonatomic ,strong) NSString<Optional> *functionName;
@end
