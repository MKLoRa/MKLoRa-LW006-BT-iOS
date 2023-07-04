//
//  MKSBTimingModeModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSBSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSBTimingModeTimePointModel : NSObject<mk_sb_timingModeReportingTimePointProtocol>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:15   2:30   3:45
@property (nonatomic, assign)NSInteger minuteGear;

@end

@interface MKSBTimingModeModel : NSObject

/*
 0:WIFI
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 */
@property (nonatomic, assign)NSInteger strategy;

@property (nonatomic, strong)NSArray <MKSBTimingModeTimePointModel *>*pointList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configData:(NSArray <MKSBTimingModeTimePointModel *>*)pointList
          sucBlock:(void (^)(void))sucBlock
       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
