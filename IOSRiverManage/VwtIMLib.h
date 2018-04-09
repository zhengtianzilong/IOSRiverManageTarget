//
//  VwtIMLib.h
//  testIMSDK
//
//  Created by whf100 on 16/7/18.
//  Copyright © 2016年 royasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VwtIMMessage.h"

#define WVT_LOG_DEBUG
typedef void(^uploadLargeFileBlock)(NSString* jsonString, NSError* error);

@interface VwtIMLib : NSObject
@property(nonatomic, copy)uploadLargeFileBlock uploadLargeFileBlock;
/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 注册设备信息
 */
-(void) registerForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken ;

/**
 登录

 @param userinfo VwtUserInfo 类型
 @param success  成功
 @param errorfun 失败
 */
-(void) loginWithUserInfo:(VwtUserInfo*) userinfo success:(void( ^)(id value) )success  error:(void(^)(VwtError* error) )errorfun ;

/**
 注销
 */
-(void) logout ;

/**
 断开连接
 */
-(void)disConnectIm;



/**
 单聊消息
 
 @param text 上传接口返回的的字符串或者文本消息内容
 @param targetid     目标会话 ID
 @param requestid    UUID
 @param extendedField 扩展字段
 @param successBlock 成功
 @param errorBlock   失败
 */
-(NSString *)sendMessage:(NSString *) text TargetId:(NSString *) targetid RequestId:(NSString *) requestid    MessageType:(VwtMessageType)messageType andWithExtendedField:(NSString *)extendedField success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 群发消息

 @param msgContent   上传接口返回的的字符串或者文本消息内容
 @param targetidArr  目标会话 ID 数组
 @param requestid    UUID
 @param extendedField 扩展字段
 @param successBlock 成功
 @param errorBlock   失败
 @param messageType 消息类型
 */
-(NSString *) sendBatchMessage:(NSString *) msgContent TargetId:(NSArray *) targetidArr RequestId:(NSString *) requestid MessageType:(VwtMessageType)messageType andWithExtendedField:(NSString *)extendedField success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 群聊消息
 
 @param msgContent   上传接口返回的的字符串或者文本消息内容
 @param targetid     目标会话 ID
 @param requestid    UUID
 @param extendedField 扩展字段
 @param successBlock 成功
 @param errorBlock   失败
 */
-(NSString *) sendMessageToGroup:(NSString *) msgContent TargetId:(NSString *) targetid RequestId:(NSString *) requestid MessageType:(VwtMessageType)messageType andWithExtendedField:(NSString *)extendedField success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;





/**
 上传文件

 @param FilePath 文件路径
 @param uploadLargeFileBlock 成功或者失败的块
 @param progess 上传进度
 @param timeout 超时时间
 */

-(void)uploadAttachment:(NSString*)filePath andTimeout:(NSInteger)timeout uploadLargeFileBlock:(uploadLargeFileBlock)uploadLargeFileBlock
                progess:(void(^)(float progess))progess;
/**
 群操作-创建群组

 @param members      人员列表.
 @param requestid    UUID
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void) createGroupWithMemberIds:(NSArray *) members RequestId:(NSString *) requestid  success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 群操作-修改群名称

 @param groupName    新的群名称
 @param groupId      群 ID
 @param requestid    UUID
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void) changeGroupName :(NSString *) groupName  withGroupID:(NSString *) groupId RequestId:(NSString *) requestid  success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 群操作-新增群人员

 @param members      人员列表
 @param groupId      群 ID
 @param requestid    UUID
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void) addGroupMembers :(NSArray *) members  withGroupID:(NSString *) groupId RequestId:(NSString *) requestid  success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 群操作-删除群人员

 @param members      人员列表
 @param groupId      群 ID
 @param requestid    UUID
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void) deleteGroupMembers :(NSArray *) members  withGroupID:(NSString *) groupId RequestId:(NSString *) requestid  success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 解散群组
 
 @param groupId      群组 ID
 @param requestid    UUID
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void) deleteGroup :(NSString*) groupId RequestId:(NSString *) requestid  success:(void (^)(id value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 获取全部/单个群组信息
 
 @param groupId      空为全部,群 ID 为单个.
 @param successBlock 返回类型为数组,内部为VwtTaskGroup类型.
 @param errorBlock
 */
-(void) getGroupMembers:(NSString *)groupId success:(void (^)(NSArray *value))successBlock  error:(void (^)(VwtError* error))errorBlock;

/**
 请求开始获取离线消息
 
 @param successBlock 返回success表示请求成功
 @param errorBlock  返回错误信息
 */
-(void) getOfflineMessage:(void (^)(NSString *value))successBlock  error:(void (^)(VwtError* error))errorBlock;

#pragma mark - 查询历史纪录

/**
 查询单人历史纪录

 @param userId       待查询的用户 ID
 @param sTime        查询的开始时间 如果客户端不写 则默认查询10天内的数据
 @param eTime        查询的结束时间 如果客户端不写 则默认查询到今天为止
                     时间为 NSString.格式为 yyyyMMdd.
                     例:2017年1月1日 20170101
                     注意:函数内部已解决时差问题,外部不需要考虑.
 @param isGroup      是否查询群组.yes 为单人,no 为群组
 @param index        页数.第一次查询的时候不需要传入.后续查询需要传入该值
 @param successBlock 成功
 @param pageNum      分页条数.默认20.
 @param errorBlock   失败
 @param requestId    UUID
 */
-(void) qryHisMessage:(NSString*)userId andStartTime:(NSString*)sTime andEndTime:(NSString*)eTime andIndex:(NSString*)index andRequestId:(NSString*)requestid andPageNum:(NSString*)pageNum andIsGroup:(BOOL)isGroup success:(void (^)(VwtResponse *value))successBlock error:(void(^)(VwtError* error))errorBlock;

@end
