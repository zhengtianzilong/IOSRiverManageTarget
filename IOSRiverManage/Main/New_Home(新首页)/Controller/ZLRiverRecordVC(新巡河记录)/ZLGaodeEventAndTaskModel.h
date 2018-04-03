//
//  ZLGaodeEventAndTaskModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLGaodeEventAndTaskModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *riverPeople;

@property (nonatomic, strong) NSString *time;


/**
 用来区分是事件还是任务
 */
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *ID;

- (instancetype)initWithtitle:(NSString *)title
                        content:(NSString *)content
                        riverPeople:(NSString *)riverPeople
                        time:(NSString *)time
                        type:(NSString *)type
                        ID:(NSString *)ID;


@end
