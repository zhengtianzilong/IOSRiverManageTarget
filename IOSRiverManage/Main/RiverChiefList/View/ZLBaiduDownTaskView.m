//
//  ZLBaiduDownTaskView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaiduDownTaskView.h"
#import "BRPickerView.h"
#import "ZLEventObjectModel.h"
#import "UITextView+PlaceHolder.h"
#import "ZLEvent_DownObjectService.h"
#import "YJSelectionView.h"
#import "ZLLoginModel.h"
@interface ZLBaiduDownTaskView ()<UITextViewDelegate>
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) CGRect kbRect;
@end

@implementation ZLBaiduDownTaskView

- (instancetype)initWithFrame:(CGRect)frame riverId:(NSString *)riverId{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        
        [self loadDataWithRiverId:riverId];
        
    }
    return self;
}

- (void)setUpUI{
    
    _titleView = [[ZLEventReportSubView alloc]initWithName:@"标题：" placeHolder:@"请输入标题" haveButton:NO];
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(self);
        make.height.mas_equalTo(AdaptedHeight(80));
    }];
    
    _riverPeopleView = [[ZLEventReportSubView alloc]initWithName:@"巡河人：" placeHolder:@"请输入巡河人"haveButton:NO];
    _riverPeopleView.eventTextfiled.enabled = NO;
    [self addSubview:_riverPeopleView];
    [_riverPeopleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(_titleView.mas_bottom).offset(1);
        make.height.mas_equalTo(AdaptedHeight(80));
    }];
    
    
    _reportObjectView = [[ZLEventReportSubView alloc]initWithName:@"下发对象：" placeHolder:@"请选择下发对象"haveButton:YES];
    [self addSubview:_reportObjectView];
    [_reportObjectView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(_riverPeopleView.mas_bottom).offset(1);
        make.height.mas_equalTo(AdaptedHeight(80));
    }];
    _reportObjectView.eventTextfiled.enabled = NO;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event_objectClick)];
    [_reportObjectView addGestureRecognizer:tapGes];
    
    _addressView = [[ZLEventReportSubView alloc]initWithName:@"位  置：" placeHolder:@"请输入位置"haveButton:NO];
    [self addSubview:_addressView];
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(_reportObjectView.mas_bottom).offset(1);
        make.height.mas_equalTo(AdaptedHeight(80));
    }];
    
    
    
    ZLEventReportSubView *feedBack = [[ZLEventReportSubView alloc]initWithName:@"任务描述：" placeHolder:@""haveButton:NO];
    [self addSubview:feedBack];
    [feedBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(_addressView.mas_bottom).offset(1);
        make.height.mas_equalTo(AdaptedHeight(80));
    }];
    
    UIView *bgTextView = [[UIView alloc]init];
    bgTextView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgTextView];
    [bgTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(feedBack.mas_bottom).offset(0);
        make.height.mas_equalTo(AdaptedHeight(150));
    }];
    
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.font = [UIFont systemFontOfSize:17];
    _noteTextView.backgroundColor = [UIColor whiteColor];
    [_noteTextView addPlaceHolder:@"请输入描述内容(140字以内)"];
    
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    [bgTextView addSubview:_noteTextView];
    [_noteTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bgTextView).offset(AdaptedWidth(30));
        make.right.equalTo(bgTextView.mas_right).offset(-AdaptedWidth(30));
        make.top.equalTo(feedBack.mas_bottom).offset(0);
        make.height.mas_equalTo(AdaptedHeight(120));
    }];
}

-(void)dismissKeyBoard
{
    [_noteTextView resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)textViewEditChanged:(NSNotification*)obj {
    UITextView *textView = _noteTextView;
    NSString *textStr = textView.text;
    NSInteger fontNum = 140 - textStr.length;
    fontNum = fontNum < 0 ? 0 : fontNum;
    //    self.wordLabel.text = [NSString stringWithFormat:@"%@",@(fontNum)];
    if (textStr.length > 140) {
        textView.text = [textStr substringToIndex:140];
    }
}

- (void)loadDataWithRiverId:(NSString *)riverId{
    
    NSString *tempRiverId = @"";
    if ([kAPPAREA isEqualToString:@"suqian"]) {
        tempRiverId = riverId;
    }else{
        tempRiverId = @"";
    }
    
    _sourceArray = [NSMutableArray array];
    _modelArray = [NSMutableArray array];
    _idArray = [NSMutableArray array];
    _nameArray = [NSMutableArray array];
//    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:ULoginModel];
//    ZLLoginModel *loginModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    YTKKeyValueStore *store = [[ZLDBStoreManager shareDbStoreManager] createDB];
    
    NSString *json = [store getStringById:DBLoginModel fromTable:DBUserTable];
    ZLLoginModel *loginModel = [[ZLLoginModel alloc]initWithString:json error:nil];
    
    ZLEvent_DownObjectService *eventObjectService = [[ZLEvent_DownObjectService alloc]initWithuid:loginModel.userId riverId:tempRiverId];
    NSMutableArray *tempArray = [NSMutableArray array];
    [eventObjectService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.response);
        NSDictionary *dic = request.responseObject;
        if ([dic[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary *dics in dic[@"data"]) {
                ZLEventObjectModel *objectModel = [[ZLEventObjectModel alloc]initWithDictionary:dics error:nil];
                [tempArray addObject:objectModel];
                [_modelArray addObject:objectModel.idObject];
                if (objectModel.departname == nil) {
                    objectModel.departname = @"";
                }
                NSString *nameAnddepartMent = [NSString stringWithFormat:@"%@ %@",objectModel.realname, objectModel.departname];
                [_sourceArray addObject:nameAnddepartMent];
                
//                [_sourceArray addObject:objectModel.realname];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZLLog(@"%@",request.response);
    }];
    
    //    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:UEventObject];
}

//- (void)loadData{
//    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:UDownEventObject];
//    _sourceArray = [NSMutableArray array];
//    _modelArray = [NSMutableArray array];
//    _idArray = [NSMutableArray array];
//    _nameArray = [NSMutableArray array];
//    if (array.count > 0) {
//        for (NSData *data in array) {
//            
//            ZLEventObjectModel *eventModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            [_modelArray addObject:eventModel.idObject];
//            [_sourceArray addObject:eventModel.realname];
//        }
//    }
//}

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
            self.reportObjectView.eventTextfiled.text = [_nameArray componentsJoinedByString:@" "];
            
        }];
    }else{
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无下发对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
    }
}


@end
