//
//  ThirdMacros.h
//  MobileProject 第三方SDK的Key及配置
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#ifndef ThirdMacros_h

#define ThirdMacros_h

#if WanApp
//高德地图SDK的Key
#define  kGaodeMapKey @"77a351c23aea310eadceb210ee472e4f"
//个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId @"zI3qJYNmqs6uYbXfOTEIu7"
#define kGtAppKey @"QYfEFPMSyh9RF9KSjqPpU9"
#define kGtAppSecret @"dj9Xqn0lXQ8DuzUcoFkTr5"

#define kPgyKey @"c745e8009d441be4cf1641724cfec1bc"

#else
//高德地图SDK的Key
#define  kGaodeMapKey @"ace2f9b7b111c2ba8bec96781833cb85"
//个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId @"bk5J8xPKND7MPOhoHnxVb6"
#define kGtAppKey @"IzKilnoM8b6WYCirpvj172"
#define kGtAppSecret @"Jh9WK0xj7R7BRJItvP6mc8"
#define kPgyKey @"f06f925116be13fb5d740af0ff399b46"

#endif




//网络状态监控地址
static NSString* const kURL_Reachability__Address=@"www.baidu.com";


#endif /* ThirdMacros_h */
