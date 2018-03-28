//
//  ZLRiverRecordAllPointDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLRiverIncidentDetailModel.h"
#import "ZLRiverTaskModel.h"
#import "ZLPatrolCoordinateModel.h"
@interface ZLRiverRecordAllPointDataModel : JSONModel

@property (nonatomic, strong) NSArray<Optional, ZLRiverIncidentDetailModel> *RiverIncident;

@property (nonatomic, strong) NSArray<Optional, ZLRiverTaskModel> *PatrolCoordinate;


@property (nonatomic, strong) NSArray<Optional, ZLPatrolCoordinateModel> *RiverTask;


@end
