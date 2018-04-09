//
//  ZLEvent_ReportView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEventReportAndDownView.h"
#import "ZLEventReportSubView.h"
//#import "BRStringPickerView.h"
#import "YJSelectionView.h"
#import "ZLEventObjectModel.h"
@interface ZLEventReportAndDownView ()<YYTextViewDelegate>
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, strong) YTKKeyValueStore *store;

@end

@implementation ZLEventReportAndDownView


- (instancetype)initWithFrame:(CGRect)frame andHasEventNameObject:(BOOL)hasName hasLeader:(BOOL)hasLeader{
    if (self = [super initWithFrame:frame]) {
        self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
        [self setUpUIwithHasName:hasName hasLeader:hasLeader ];
        _typeArray = @[@"上报  ",@"下发  "];

//        [self loadData];
    }
    return self;
}

- (void)setUpUIwithHasName:(BOOL)hasName hasLeader:(BOOL)hasLeader{
    
    // 不能只有名称没对象
    if (hasName == YES && hasLeader == NO) {
        return;
    }
    
    
    if (hasName) {
        
        _firstView = [[ZLEventReportSubView alloc]initWithName:@"事件名称：" placeHolder:@"请输入事件名称" haveButton:NO];
        [self addSubview:_firstView];
        [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.width.mas_equalTo(App_Frame_Width);
            make.top.equalTo(self);
            make.height.mas_equalTo(AdaptedHeight(80));
        }];
    }
    
    
    _secondView = [[ZLEventReportSubView alloc]initWithName:@"发起类型：" placeHolder:@"请选择发起类型"haveButton:YES];
    _secondView.imageV.image = [UIImage imageNamed:@"selectType"];
    [self addSubview:_secondView];
    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.height.mas_equalTo(AdaptedHeight(80));
    }];
    _secondView.eventTextfiled.enabled = NO;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(typeSelectClick)];
    
    [_secondView addGestureRecognizer:tapGes];

    
    
    
    if (hasLeader) {
        _thirdView = [[ZLEventReportSubView alloc]initWithName:@"事件对象：" placeHolder:@"请选择事件对象"haveButton:YES];
        [self addSubview:_thirdView];
        [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.width.mas_equalTo(App_Frame_Width);
            make.height.mas_equalTo(AdaptedHeight(80));
        }];
        _thirdView.eventTextfiled.enabled = NO;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event_objectClick)];
        
        [_thirdView addGestureRecognizer:tapGes];
        
    }
    
    
    ZLEventReportSubView *forthView = [[ZLEventReportSubView alloc]initWithName:@"事件描述：" placeHolder:@""haveButton:NO];
    [self addSubview:forthView];
    [forthView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        //        make.top.equalTo(_secondView.mas_bottom).offset(1);
        make.height.mas_equalTo(AdaptedHeight(80));
    }];
    
    UIView *bgTextView = [[UIView alloc]init];
    bgTextView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgTextView];
    [bgTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(forthView.mas_bottom).offset(0);
        //        make.height.mas_equalTo(AdaptedHeight(255));
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    
    
    if (hasName) {
        [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_firstView.mas_bottom).offset(1);
        }];
        
        [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_secondView.mas_bottom).offset(1);
        }];
        
        
        [forthView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_thirdView.mas_bottom).offset(1);
        }];
        
    }else if(hasLeader){
        [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
        }];
        [forthView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_secondView.mas_bottom).offset(1);
        }];
    }else{
        [forthView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
        }];
    }
    
    _noteTextView = [[YYTextView alloc]init];
    _noteTextView.font = [UIFont systemFontOfSize:17];
    _noteTextView.backgroundColor = [UIColor whiteColor];
    _noteTextView.placeholderText = @"请输入描述信息(140字以内)";
    
    [bgTextView addSubview:_noteTextView];
    [_noteTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bgTextView).offset(AdaptedWidth(30));
        make.right.equalTo(bgTextView.mas_right).offset(-AdaptedWidth(30));
        make.top.equalTo(forthView.mas_bottom).offset(0);
        //        make.height.mas_equalTo(AdaptedHeight(200));
        make.bottom.equalTo(bgTextView.mas_bottom);
    }];
    
    
    
}

- (void)loadData:(NSString *)loadType {
    
    NSArray *array = (NSArray *)[self.store getObjectById:loadType fromTable:DBUserTable];
    
//    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:loadType];
    _sourceArray = [NSMutableArray array];
    _modelArray = [NSMutableArray array];
    _idArray = [NSMutableArray array];
    _nameArray = [NSMutableArray array];
    if (array.count > 0) {
//        for (NSData *data in array) {
//
//            ZLEventObjectModel *eventModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            [_modelArray addObject:eventModel.idObject];
//            if (eventModel.departname == nil) {
//                eventModel.departname = @"";
//            }
//            NSString *nameAnddepartMent = [NSString stringWithFormat:@"%@ %@",eventModel.realname, eventModel.departname];
//
//            [_sourceArray addObject:nameAnddepartMent];
//        }
        
        for (NSString *json in array) {
            
            ZLEventObjectModel *eventModel = [[ZLEventObjectModel alloc]initWithString:json error:nil];
            [_modelArray addObject:eventModel.idObject];
            if (eventModel.departname == nil) {
                eventModel.departname = @"";
            }
            NSString *nameAnddepartMent = [NSString stringWithFormat:@"%@ %@",eventModel.realname, eventModel.departname];
            
            [_sourceArray addObject:nameAnddepartMent];
        }
        
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_noteTextView resignFirstResponder];
    
}

- (void)typeSelectClick{
    [self endEditing:YES];
    
    [YJSelectionView showWithTitle:@"发起类型" memoryAddress:@"type" options:_typeArray singleSelection:YES delegate:self completionHandler:^(NSInteger index, NSArray * _Nullable options) {
        
        if (![self.secondView.eventTextfiled.text isEqualToString:_typeArray[index]]) {
            
            self.thirdView.eventTextfiled.text = @"";
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"event"];
            
        }
        self.secondView.eventTextfiled.text = [_typeArray[index] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([[_typeArray[index] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@"上报"]) {
            
//            [self loadData:UEventObject];
            [self loadData:DBEventObject];
            
        }else{
//            [self loadData:UDownEventObject];
            [self loadData:DBDownEventObject];
        }
    }];
}

- (void)event_objectClick{
    [self endEditing:YES];
    
    if (_secondView.eventTextfiled.text.length <=0) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请先选择发起类型" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return ;
    }else{
    
    if (_sourceArray.count > 0) {
         [YJSelectionView showWithTitle:@"事件对象" memoryAddress:@"event" options:_sourceArray singleSelection:NO delegate:self completionHandler:^(NSInteger index, NSArray * _Nullable options) {
            
            [_idArray removeAllObjects];
            [_nameArray removeAllObjects];
            for (NSNumber *i in options) {
                [_idArray addObject: _modelArray[[i intValue]]];
                
                NSString *nameAndDepartment = _sourceArray[[i intValue]];
                NSArray *tempArray = [nameAndDepartment componentsSeparatedByString:@" "];
                [_nameArray addObject:tempArray.firstObject];
                
                //                [_nameArray addObject:_sourceArray[[i intValue]]];
            }
            _liable_id = [_idArray componentsJoinedByString:@","];
            self.thirdView.eventTextfiled.text = [_nameArray componentsJoinedByString:@" "];
            
        }];
    }else{
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
    }

    }
}


@end
