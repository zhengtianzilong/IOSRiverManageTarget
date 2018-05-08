//
//  NetUrl.h
//  SmartCities
//
//  Created by caizilong on 16/8/26.
//  Copyright © 2016年 caizilong. All rights reserved.
//

#ifndef NetUrl_h
#define NetUrl_h

// 移动测试环境
// http://112.4.10.185:86/api/

// 移动正式环境
// http://183.207.103.139:86/api/

// 本地测试环境
// http://192.168.0.89:1011

// 图片查看地址
// http://112.4.10.185:86/file/

// 图片查看地址
// http://183.207.103.139:86/file/

// 新闻查看地址 综合统计 五单两表
// http://112.4.10.185:86

// 测试 新闻
// http://192.168.0.232:8086

#define Base_URL [[NSUserDefaults standardUserDefaults] objectForKey:@"Server"]

#define SERVER_NEWS_URL [[NSUserDefaults standardUserDefaults] objectForKey:@"ComStatistics"]

// 基础图片地址
#define BaseImage_URL [[NSUserDefaults standardUserDefaults] objectForKey:@"File"]
// 登录接口
#define River_LoginUrl @"soa/mobile/login"
// 登出接口
#define River_LoginOutUrl @"soa/mobile/logout"

// 综合统计 五单两表
#define River_ComStatisticsUrl [[NSUserDefaults standardUserDefaults] objectForKey:@"ComStatistics"]

//// 五单两表
//#define River_FiveAndTwoTableUrl @"http://183.207.103.139:86/"

// 查询首页待办数据
#define River_GetMyToDoTaskAndIncidentListUrl @"city/appRiverTask/getMyToDoTaskAndIncidentListForApp"

// 查询区域的数据
#define River_AreaListUrl @"base/appArea/getAreaList"

// 查询用户所管辖的河道
#define River_UserRiversUrl @"base/riverInfoController/getUserRivers"

// 事件上报获取上一级机构
#define River_GetDepartmentListByIncidentUrl @"base/bizCommon/getDepartmentListByIncidentForApp"

// 事件上报获取上级区域中的人
#define River_GetUserListByIncidentUrl @"base/bizCommon/getUserListByIncidentForApp"

// 获取普通下发人员列表
#define River_GetUserListByTaskNormalUrl @"base/bizCommon/getUserListByTaskApp"

// 获取下发河长办
#define River_GetDepartmentListByTaskAppUrl @"base/bizCommon/getDepartmentListByTaskApp"


// 通讯录通过用户ID查询所管辖的河道
#define River_GetRiverNamesByUserUrl @"base/riverInfoController/getRiverNamesByUser"

// 查询通讯录数据
#define River_UserContactsUrl @"base/riverInfoController/getUserContacts"

// 新闻公告与通知
#define River_NewsListUrl @"base/appNew/getNewsListByAreaCode"

//// 上传数据
//#define River_UploadUrl @"/base/system/upload"

// 多张图片上传
#define River_BatchUploadUrl @"base/system/batch/upload"

// 获取河道基础信息
#define River_GetRiverInfoByRiverCodeUrl @"base/riverInfoController/getRiverInfoByRiverCode"

// 删除取水口
#define River_PumpingPortDeleteUrl @"base/AppPumpingPort/delEntity"


// 删除公示牌
#define River_PublicBoardDeleteUrl @"base/appBrandController/deleteBrand"

// 删除排污口
#define River_OutletDeleteUrl @"base/appSewageController/deleteSewage"

// 取水口添加
#define River_AddIntakeUrl @"base/AppPumpingPort/addEntity"
// 排污口添加
#define River_AddSewageUrl @"base/appSewageController/addSewage"

// 公示牌添加
#define River_AddBrandUrl @"base/appBrandController/addBrand"

// 河道ID获取河道河长数据
#define River_GetRiverManageByRiverIdUrl @"base/riverInfoController/getRiverManageByRiverId"

// 巡河点位上报
#define River_SavepatrolpointUrl @"city/appRiver/savepatrolpoint"

// 获取个人巡河记录列表
#define River_GetRiverPatrolListByUserCodeUrl @"city/appRiver/getRiverPatrolListByUserCode"

// 根据巡河的code获取巡河的轨迹点信息，巡河关联的任务和事件的信息
#define River_GetPatrolCoordinateIncidentTaskUrl @"city/appRiver/getPatrolCoordinateIncidentTask"

// 交办任务列表
#define River_GetAssignTaskListUrl @"city/assign/getAssignTaskList"

// 我的交办任务列表
#define River_GetMyAssignTaskListUrl @"city/assign/getMyAssignTaskList"

// 督办任务列表
#define River_GetSuperviseTaskListUrl @"city/supervise/getSuperviseTaskList"
// 交办详情信息
#define River_GetAssignTaskDetailUrl @"city/assign/assignTaskDetail"
// 督办详情信息
#define River_SuperviseDetailUrl @"city/supervise/superviseDetail"
//appAiver/getRiverInfoByRiverCode

// 仅创建(保存)事件
#define River_OnlyAddIncidentUrl @"city/incident/onlyAddIncidentForApp"

// 转报事件
#define River_ContinueReportIncidentForAppUrl @"city/incident/continueReportIncidentForApp"



// 仅创建(保存)任务
#define River_SaveTaskUrl @"city/appRiverTask/saveTask"

// 修改并保存任务
#define River_UpdateTaskUrl @"city/appRiverTask/updateTask"

// 任务修改并下发
#define River_UpdateAndSentTaskUrl @"city/appRiverTask/updateAndSentTask"

// 普通下发任务
#define River_SaveAndSentTaskUrl @"city/appRiverTask/saveAndSentTask"

// 创建并上报事件
#define River_AddAndSentIncidentUrl @"city/incident/addAndSentIncidentForApp"

// 修改事件
#define River_OnlyUpdateIncidentForAppUrl @"city/incident/onlyUpdateIncidentForApp"

// 修改上报事件
#define River_UpdateAndSentIncidentForAppUrl @"city/incident/updateAndSentIncidentForApp"


// 获取我创建的任务
#define River_FindMyCreatedTaskListUrl @"city/appRiverTask/findMyCreatedTaskList"

// 获取我创建的事件
#define River_GetMyCreateIncidentListUrl @"city/incident/getMyCreateIncidentForApp"

// 获取我已办的任务
#define River_FindMyDoneTaskListUrl @"city/appRiverTask/findMyDoneTaskList"

// 获取我已办的事件
#define River_GetMyHaveDoIncidentListUrl @"city/incident/getMyHaveDoIncidentForApp"

// 获取我的待办任务列表
#define River_FindMyToDoTaskListUrl @"city/appRiverTask/findMyToDoTaskList"

// 获取我待办的事件
#define River_GetMyToDoIncidentListUrl @"city/incident/getMyToDoIncidentForApp"

// 任务查询列表
#define River_FindTaskListUrl @"city/appRiverTask/findTaskList"

// 事件查询列表
#define River_GetIncidentListUrl @"city/incident/getIncidentForApp"


// 获取任务详情
#define River_FindTaskByIdUrl @"city/appRiverTask/findTaskById"

// 获取事件详情
#define River_GetIncidentAllUrl @"city/incident/getIncidentAllForApp"

// 删除任务
#define River_DeleteTasksUrl @"city/appRiverTask/deleteTasks"

// 删除事件
#define River_DelIncidentForAppUrl @"city/incident/delIncidentForApp"


// 任务接收
#define River_ReceiveTaskUrl @"city/appRiverTask/receiveTask"

// 任务审核-驳回
#define River_CheckRejectTaskUrl @"city/appRiverTask/checkRejectTask"

// 任务审核-通过
#define River_CheckOkTaskUrl @"city/appRiverTask/checkOkTask"


// 任务转发
#define River_ReSentTaskUrl @"city/appRiverTask/reSentTask"

// 任务反馈--提交
#define River_FeedbackTaskUrl @"city/appRiverTask/feedbackTask"

// 反馈事件
#define River_FeedbackIncidentForAppUrl @"city/incident/feedbackIncidentForApp"

// 接收事件
#define River_ReceiveIncidentForAppUrl @"city/incident/receiveIncidentForApp"

// 获取任务反馈详情
#define River_FindTaskFeedbackByIdUrl @"city/appRiverTask/findTaskFeedbackById"

// 获取任务子任务的id
#define River_FindByTaskCodeUrl @"city/riverTask/findByTaskCode"

// 获取当前区域的河道列表
#define River_GetNowAreaRiverListForAppUrl @"base/riverInfoController/getNowAreaRiverListForApp"








//// 河长联系单巡河查询当前用户管辖河道接口
//#define River_DemandReachUrl @"/hzz/phoneController.do?demandReach"
//
////    河长联系单巡河上报事件接口
//#define River_AddRiverEventUrl @"/hzz/phoneController.do?goAddRiverEvent"
//
////河长联系单巡河查询当前用户上报对象接口
//#define River_UpTaskUrl @"/hzz/phoneController.do?upTask"
//
//// 普通事件上报接口
//#define River_NormalEventUrl @"/hzz/phoneController.do?goAddEvent"
//// 继续事件上报接口
//#define River_ContinueEventUrl @"/hzz/mobile.do?continueReport"
//
//// 办结事件上报接口
//#define River_CompleteEventUrl @"/hzz/mobile.do?finishReport"
//// 结束巡河接口
//#define River_EndRiverUrl @"/hzz/phoneController.do?doBatchCoordion"
//// 下发对象接口
//#define River_GoTaskObjectUrl @"/hzz/appController.do?goTask"
//// 普通事件下发接口
//#define River_NormalTaskDownUrl @"/hzz/appController.do?doAddTask"
//// 继续事件下发接口
//#define River_ContinueTaskDownUrl @"/hzz/mobile.do?continueIssued"
//// 任务反馈接口
//#define River_CompleteTaskDownUrl @"/hzz/mobile.do?taskFeedback"
////    河长联系单巡河下发事件接口
//#define River_DownRiverTaskUrl @"/hzz/phoneController.do?goAddRiverTask"
#define TuiSongBadgeUrl @"/hzz/mobile.do?delmsg"
//
//#define App_ChangeVersion @"/hzz/userController.do?updateVersionType"


#endif /* NetUrl_h */
