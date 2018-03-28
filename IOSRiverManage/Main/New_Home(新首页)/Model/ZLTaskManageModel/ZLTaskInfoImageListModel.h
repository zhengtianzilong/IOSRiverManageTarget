//
//  ZLTaskInfoImageListModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLTaskInfoImageListModel

@end
@interface ZLTaskInfoImageListModel : JSONModel
@property (nonatomic , copy) NSString<Optional>              * code;
@property (nonatomic , copy) NSString<Optional>              * fileName;
@property (nonatomic , copy) NSString<Optional>              * orgName;
@property (nonatomic , copy) NSString<Optional>              * ext;
@property (nonatomic , copy) NSString<Optional>              * fileAddr;
@end
