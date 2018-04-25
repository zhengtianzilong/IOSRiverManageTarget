//
//  DataBaseKey.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#ifndef DataBaseKey_h
#define DataBaseKey_h

// 下发事件人物对像
#define DBApp_Version @"app_version"

// 下发事件人物对像
#define DBDownEventObject @"user_downEventObject"
// 上报事件人物对象
#define DBEventObject @"user_eventObject"
// 登录模型
#define DBLoginModel @"loginModel"
#define DBLoginTokenCreateTime @"user_token_creatTime"
// 首页展示巡河模型
#define DBRunningModel @"runningModel"

#define DBUserName @"user_name"
#define DBUserAreaCode @"user_areaCode"
#define DBUserToken @"user_token"
#define DBPassword @"user_password"

#define DBUserRivers @"user_rivers"

// 上报事件人列表
#define DBEventPeopleListRivers @"user_eventPeopleList"
// 获取上一级机构
#define DBEventDepartListRivers @"user_eventDepartList"

// 下发事件人列表
#define DBTaskPeopleListRivers @"user_taskPeopleList"
// 获取下发机构
#define DBTaskDepartListRivers @"user_taskDepartList"

#define DBUserTable @"user_table"
#define DBMapTable @"map_table"
#define DBAddress @"map_address"
#endif /* DataBaseKey_h */
