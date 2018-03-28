//
//  ZLRiverDemandModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/21.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//"data":[
//                {
//                        "id":"402880005e3b529d015e3c7c453d0025",
//                        "org_type":"2",
//                        "rivers_name":"骆马湖段",
//                        "start_point_desc":"宿迁起",
//                        "end_point_desc":"宿迁终"
//                    },
//                {
//                        "id":"402880005e3b529d015e3c891ad60027",
//                        "org_type":"2",
//                        "rivers_name":"六塘河段",
//                        "start_point_desc":"宿迁起",
//                        "end_point_desc":"宿迁终"
//                    },
//                {
//                        "id":"402880005e3b529d015e3c8f05cc002b",
//                        "org_type":"2",
//                        "rivers_name":"沂河段",
//                        "start_point_desc":"宿迁起",
//                        "end_point_desc":"宿迁终"
//                    }

@interface ZLRiverDemandModel : JSONModel

@property (nonatomic ,strong) NSString<Optional> *riverId;

@property (nonatomic ,strong) NSString<Optional> *org_type;

@property (nonatomic ,strong) NSString<Optional> *rivers_name;

@property (nonatomic ,strong) NSString<Optional> *start_point_desc;

@property (nonatomic ,strong) NSString<Optional> *end_point_desc;


@end
