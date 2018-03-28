//
//  ZLNewAddressBookModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLNewAddressBookDataModel.h"

@interface ZLNewAddressBookModel : ZLBaseModel

@property (nonatomic, strong) NSArray<ZLNewAddressBookDataModel, Optional> *data;

@end
