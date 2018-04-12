//
//  VwtIMMessage.h
//  testIMSDK
//
//  Created by whf100 on 16/7/19.
//  Copyright © 2016年 royasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





typedef NS_ENUM(NSInteger, VwtResponeCode ) {
    VWT_ERRORCODE_UNKNOWN = -100,
    VWT_RESPONE_FWQ_ERROR = -1,                //服务器报错错误码
    VWT_RESPONE_SUCCESS = 0,                   //成功
    VWT_APPID_ERROR = 1001,                    //appid校验不通过
    VWT_USER_CHECK_FAILED = 1002,              //用户校验失败
    VWT_FWQ_RECEIVE_FAILED = 1003,             //服务器接收数据失败
    VWT_FWQ_ADD_GROUP_FAILED = 1004,           //邀请群成员失败，邀请人已经不在群组中
    VWT_HTTP_NETWORK_INVALID = 1005,           //HTTP 接口不通
    VWT_NET_TIME_OUT = 1006,                   //超时
    
    VWT_FILE_NOT_EXIST = 100001 ,              //文件不存在
    VWT_PARAM_IS_EMPTY =  100002 ,              //参数为空
    VWT_REQUST_TIMEOUT = 100003 ,              //请求超时
    VWT_RESPONE_DATA_FORMAT_ERROR = 100004,    //服务器数据格式错误，无法解析
    VWT_NET_CHANNEL_INVALID = 100005,          //网络不可用
    VWT_KICKED_OUT = 100006,                   //账号在别处登录 被踢下线
    VWT_NOT_LOGIN = 100007,                    //你尚未登录,请先登录
    VWT_PARAM_STYLE_INVALID = 100008,          //参数类型不匹配
    VWT_SECRET_FAILED = 100009,                //秘钥错误
    VWT_FILE_TIME_TOO_LONG = 100010,            //文件时间过长
    VWT_FILE_TIME_TOO_LARGE = 100011,            //文件过大
    VWT_FILE_BACK_PATH_NULL = 100012,                      //上传文件成功，但是未返回文件地址
    VWT_LOGIN_SUCCESS = 2000,                   //用户登录成功
};

@interface VwtError  : NSObject

@property(nonatomic , assign) VwtResponeCode  code ;  //错误码
@property(nonatomic , copy)     NSString*  content ;  //错误码
@property (nonatomic,strong) NSString *serverContent; //服务器错误码
+(id)instanceWithCode:(VwtResponeCode)code ;

+(id)instanceWithTimeoutTime:(int) time ;

@end



@class VwtIMMessage ;
@class VwtTaskGroup ;
@class VwtServicePush ;

typedef void (^receivedMessageBlock)(VwtIMMessage* message );
typedef void (^receivedGroupOperateBlock)(VwtTaskGroup *  message );
typedef void (^receivedServicePushBlock)(VwtServicePush *  message );
typedef void (^receivedErrorBlock)(VwtError *  error );
typedef void (^didloginSuccessCallback)(id value);


typedef NS_ENUM(NSInteger, VwtNetworkStatus) {
    VwtNotReachable = 0,
    VwtReachableViaWiFi,
    VwtkReachableVia2G,
    VwtkReachableVia3G,
    VwtkReachableVia4G
} ;



//1-文本 2-图片  5-视频 6 -文件 3-语音 4-位置
typedef NS_ENUM(SInt32, VwtMessageType) {
    VwtMessageTypeText = 1,
    VwtMessageTypeImage = 2,
    VwtMessageTypeVideo = 5,
    VwtMessageTypeFile = 6,
    VwtMessageTypeVoice = 3,
    VwtMessageTypePosition = 4
};


typedef NS_ENUM(SInt32, VwtTargetType) {
    VwtTargetTyleSingle = 1,  //单聊
    VwtTargetTyleGroup = 2,  //群聊
    VwtTargetTyleBatch = 3, //群发
};





@interface VwtIMMessage : NSObject

@property(nonatomic , assign) VwtTargetType     target_type ;//回话类型 ， 单聊， 群组
@property(nonatomic , copy  ) NSString * requestId ;         //请求ID
@property(nonatomic , copy  ) NSString * fromUserId ;        //谁发的ID
@property(nonatomic , copy  ) NSString * toUserId ;          //发给谁的, 单聊是自己， 群聊是群组ID
@property(nonatomic , copy  ) NSString * messageUUID ;       //消息ID
@property(nonatomic , assign  ) VwtMessageType  messageType ;//消息类型
@property(nonatomic , strong  ) id          content ;          //消息内容对象
@property(nonatomic , copy  ) NSString * groupId      ;       //群组ID
@property(nonatomic , assign) SInt64     serverTime;         //服务器时间
@property(nonatomic, copy) NSString *lastIndex;     //分页使用,如果没有分页为空.
@property (nonatomic, copy) NSString *extendedField; //<扩展字段
+(id) instanceWithMessageType:(VwtMessageType) messagetype content:(NSString*) strContent TargetType:(VwtTargetType) targettype RequestId:(NSString *) requestid From:(NSString*) from To:(NSString *) to UUId:(NSString*) uuid groupId:(NSString *) groupId  ServerTime :(SInt64) servertime andWithExtendedField:(NSString *)extendedField;

-(void)setTargetType:(VwtTargetType) targettype RequestId:(NSString *) requestid From:(NSString*) from To:(NSString *) to UUId:(NSString*) uuid MessageType:(VwtMessageType) messagetype Content:(id) content groupId:(NSString *) groupId ServerTime :(SInt64) servertime extendedField:(NSString *)extendedField;

-(void)setTargetType:(VwtTargetType) targettype RequestId:(NSString *) requestid From:(NSString*) from To:(NSString *) to UUId:(NSString*) uuid MessageType:(VwtMessageType) messagetype Content:(id) content groupId:(NSString *) groupId extendedField:(NSString *)extendedField;

//历史纪录
+(id) instanceWithMessageType:(VwtMessageType) messagetype content:(NSString*) strContent TargetType:(VwtTargetType) targettype RequestId:(NSString *) requestid From:(NSString*) from To:(NSString *) to UUId:(NSString*) uuid groupId:(NSString *) groupId  ServerTime :(SInt64) servertime andLastIndex:(NSString*)index extendedField:(NSString *)extendedField;

@end





@interface VwtTextMessage  : NSObject

@property(nonatomic , copy) NSString * content ;  //文本内容

+(id)instanceWithData:(NSString*)data ;

@end


//图片类型消息
@interface VwtImageMessage  : NSObject

@property(nonatomic , strong) NSString * imageUrl ;   //图片完整路径
@property(nonatomic , copy)   NSString * imageName ;   //图片名
@property(nonatomic , strong)   UIImage * thumbnail ;   //缩略图

+(id)instanceWithData:(NSString *)strData ;

@end


//语音类型消息
@interface VwtVoiceMessage  : NSObject

@property(nonatomic , copy)     NSString * audioUrl ;     //音频URL
@property(nonatomic , assign)   UInt32  duration ;       //时长
@property(nonatomic , copy)     NSString * audioname ;   //文件名
@property(nonatomic , strong)   NSData * audiodata ;     //音频内容


+(id)instanceWithData:(NSString *)strData ;

@end

//位置类型消息
@interface VwtLocationMessage  : NSObject

@property(nonatomic , assign)  float longitude ;     //经度
@property(nonatomic , assign)  float latitude ;      //纬度
@property(nonatomic , strong)   UIImage * thumbnail ;    //缩略图
@property(nonatomic , copy)     NSString * address ;    //地址名

+(id)instanceWithDict:(NSString *) content ;

@end


//视频类型消息
@interface VwtVideoMessage  : NSObject

@property(nonatomic , copy)     NSString * url ;           //视频内容
@property(nonatomic , assign)   long long   fileSize ;         //视屏大小
@property(nonatomic , copy)     NSString * videoname ;     //文件名
@property(nonatomic , strong)   UIImage * thumbnail ;      //缩略图


+(id)instanceWithDict:(NSString *) content ;

@end


//文件类型消息
@interface VwtFileMessage  : NSObject

@property(nonatomic , strong)     NSData * fileData ;      //文件内容
@property(nonatomic , copy)     NSString * name ;        //文件名
@property(nonatomic , copy)     NSString * urlPath ;     //文件url

+(id)instanceWithDict:(NSString *) content ;

@end


//名片类型消息
@interface VwtCardMessage  : NSObject

@property(nonatomic , copy)     NSString * telepthone ;  //手机号
@property(nonatomic , copy)     NSString * name ;        //姓名


+(id)instanceWithDict:(NSString *) content  ;

@end


//分享链接类型消息
@interface VwtShareLinkMessage  : NSObject

@property(nonatomic , copy)     NSString * url ;       //链接url
@property(nonatomic , copy)     NSString * title ;     //标题
@property(nonatomic , strong)   UIImage * thumbnail ;  //缩略图

+(id)instanceWithDict:(NSString *) content  ;

@end


@interface VwtResponse  : NSObject

@property (nonatomic, copy) NSString* requestId;  //请求Id
@property (nonatomic, assign) SInt32 responseCode;   //错误吗
@property (nonatomic, copy) id responseContent;   //详细参数
@property (nonatomic, assign) SInt64 serverTime;    //服务器时间


-(instancetype)initWithRequestId:(NSString *) requestId code:(SInt32) retCode content:(id) retContent serverTime:(SInt64) time ;

@end

typedef NS_ENUM(SInt32, VwtGroupType) {
    VwtGroupTypeCreateGroup = 1,
    VwtGroupTypeUpdateGroupName = 2,
    VwtGroupTypeDeleteGroup = 3,   //删除群组
    VwtGroupTypeAddMember = 4,
    VwtGroupTypeDeleteMember = 5,  //离开群组
    VwtGroupTypePushCreate = 6,//后台推送新增
    VwtGroupTypePushUpdate = 7,//后台推送更新
    VwtGroupTypePushDelete = 8,//后台删除群组
};


@interface VwtTaskGroup  : NSObject

@property (nonatomic, copy) NSString* requestId;
@property (nonatomic, copy) NSString* groupId;
@property (nonatomic) VwtGroupType groupoptType;
@property (nonatomic, copy) NSArray* groupMembers;
@property (nonatomic, copy) NSString* from;
@property (nonatomic, copy) NSString* createMember;
@property (nonatomic, copy) NSString* groupName;
@property (nonatomic, assign) SInt64 serverTime;
@property (nonatomic, copy) NSArray* operationMembers;

-(instancetype)initWithRequestId:(NSString *) requestId groupId:(NSString*) groupId groupOptType:(VwtGroupType) type groupMembers:(NSArray *) arrMems fromUser:(NSString *) from createMember:(NSString *) createUser groupName:(NSString *) name serverTime:(SInt64) time operationMembers:(NSArray *)optMems ;

@end



@interface VwtServicePush : NSObject

@property (nonatomic, copy) NSString* content;
@property (nonatomic, assign) SInt64 serverTime;

+(instancetype)initWithContect:(NSString *) content Time:(SInt64 )time ;

@end



@interface VwtUserInfo : NSObject
@property (nonatomic, copy) NSString* appId;
@property (nonatomic, copy) NSString* appSecret;
@property (nonatomic, copy) NSString* userId;


@property (nonatomic, copy)  receivedMessageBlock  receivedMessageBlock ; //收到消息的回调函数

@property (nonatomic, copy)  receivedGroupOperateBlock  receivedGroupOperateBlock ; //群聊信息变更回调

@property (nonatomic, copy)  receivedServicePushBlock  receivedServerPushBlock ; //设置服务号推送回调

@property (nonatomic, copy)  receivedErrorBlock  receivedErrorBlock ; //设置回调报错

//登录成功
@property (nonatomic, copy) didloginSuccessCallback didloginSuccessBlock;

@end


/**
 聊天记录
 */
@interface VwtHistory : NSObject

/**
 类型 1-个人 2-群组
 */
@property (nonatomic,copy) NSString *targetType;

/**
 原请求ID编号
 */
@property (nonatomic,copy) NSString *requestId;

/**
 发送方
 */
@property (nonatomic,copy) NSString *fromId;

/**
 接收方
 */
@property (nonatomic,copy) NSString *toId;

/**
 文件视频图片的id
 */
@property (nonatomic,copy) NSString *msgUuid;

/**
 内容
 */
@property (nonatomic,copy) NSString *content;

/**
 是否提醒
 */
@property (nonatomic,copy) NSString *isRemind;

/**
 提醒哪些人
 */
@property (nonatomic,copy) NSString *remindUsers;

/**
 当targetType为2 时  保存taskId
 */
@property (nonatomic,copy) NSString *groupId;

/**
 群组信息
 */
@property (nonatomic,copy) NSString *taskGroup;

/**
 发送人姓名
 */
@property (nonatomic,copy) NSString *userName;

/**
 时间
 */
@property (nonatomic,copy) NSString *serverTime;

/**
 分页查询时保存下一次请求的 id
 */
@property (nonatomic,copy) NSString *lastIndex;
@end


