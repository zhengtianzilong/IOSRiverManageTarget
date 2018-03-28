//
//  ZLEvent_SendDownView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/25.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEvent_SendDownView.h"
#import "ZLEventReportSubView.h"
#import "BRStringPickerView.h"
#import "ZLEventObjectModel.h"
#import "YJSelectionView.h"
@interface ZLEvent_SendDownView ()
@property (nonatomic, strong) NSMutableArray *sourceArray;
@end

@implementation ZLEvent_SendDownView

- (instancetype)initWithFrame:(CGRect)frame andHasEventNameObject:(BOOL)hasName hasLeader:(BOOL)hasLeader{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUIwithHasName:hasName hasLeader:hasLeader ];
        [self loadData];
    }
    return self;
}

- (void)setUpUIwithHasName:(BOOL)hasName hasLeader:(BOOL)hasLeader{
    
    if (hasName) {
        
        _firstView = [[ZLEventReportSubView alloc]initWithName:@"任务名称:" placeHolder:@"请输入任务名称" haveButton:NO];
        [self addSubview:_firstView];
        [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.width.mas_equalTo(App_Frame_Width);
            make.top.equalTo(self);
            make.height.mas_equalTo(AdaptedHeight(80));
        }];
    }
    
    if (hasLeader) {
        _secondView = [[ZLEventReportSubView alloc]initWithName:@"任务对象:" placeHolder:@"请选择任务对象"haveButton:YES];
        [self addSubview:_secondView];
        [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.width.mas_equalTo(App_Frame_Width);
//            make.top.equalTo(_firstView.mas_bottom).offset(1);
            make.height.mas_equalTo(AdaptedHeight(80));
        }];
        _secondView.eventTextfiled.enabled = NO;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event_objectClick)];
        [_secondView addGestureRecognizer:tapGes];
    }
    

    _thirdView = [[ZLEventReportSubView alloc]initWithName:@"任务描述:" placeHolder:@""haveButton:NO];
    [self addSubview:_thirdView];
    [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
        make.top.equalTo(_thirdView.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom);
//        make.height.mas_equalTo(AdaptedHeight(255));
    }];
    
    
    if (hasName) {
        [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_firstView.mas_bottom).offset(1);
        }];
        [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_secondView.mas_bottom).offset(1);
        }];

    }else if(hasLeader){
        [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
        }];
        [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_secondView.mas_bottom).offset(1);
        }];


    }else{
        [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
            
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
        make.top.equalTo(_thirdView.mas_bottom).offset(0);
//        make.height.mas_equalTo(AdaptedHeight(200));
        make.bottom.mas_equalTo(bgTextView.mas_bottom);
    }];
}

- (void)loadData{
    
    NSArray *array = (NSArray *)[[[ZLDBStoreManager shareDbStoreManager]createDB] getObjectById:DBDownEventObject fromTable:DBUserTable];
    
//    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:UDownEventObject];
    _sourceArray = [NSMutableArray array];
    _modelArray = [NSMutableArray array];
    _idArray = [NSMutableArray array];
    _nameArray = [NSMutableArray array];
    if (array.count > 0) {
        for (NSString *data in array) {
            
//            ZLEventObjectModel *eventModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            ZLEventObjectModel *eventModel = [[ZLEventObjectModel alloc]initWithString:data error:nil];

            [_modelArray addObject:eventModel.idObject];
            if (eventModel.departname == nil) {
                eventModel.departname = @"";
            }
            NSString *nameAnddepartMent = [NSString stringWithFormat:@"%@ %@",eventModel.realname, eventModel.departname];
            [_sourceArray addObject:nameAnddepartMent];
        }
    }}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_noteTextView resignFirstResponder];
    
}
- (void)event_objectClick{
     [self endEditing:YES];
    
    if (_sourceArray.count > 0) {
        [YJSelectionView showWithTitle:@"事件对象" options:_sourceArray singleSelection:NO delegate:self completionHandler:^(NSInteger index, NSArray * _Nullable options) {
            
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
            self.secondView.eventTextfiled.text = [_nameArray componentsJoinedByString:@" "];
            
        }];
    }else{
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无下发对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        
    }
    
    
//    [BRStringPickerView showStringPickerWithTitle:@"事件对象" dataSource:_sourceArray defaultSelValue:_sourceArray.firstObject isAutoSelect:NO resultBlock:^(id selectValue) {
//        NSInteger index = [_sourceArray indexOfObject:selectValue];
//        
//        _liable_id = _modelArray[index];
//        self.secondView.eventTextfiled.text = selectValue;
//        
//    }];
    
}


@end
