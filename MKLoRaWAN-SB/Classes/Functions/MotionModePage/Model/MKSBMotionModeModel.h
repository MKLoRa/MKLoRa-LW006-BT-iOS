//
//  MKSBMotionModeModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSBSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSBMotionModeEventsModel : NSObject<mk_sb_motionModeEventsProtocol>

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL fixOnEnd;

@property (nonatomic, assign)BOOL fixOnStationaryState;

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@end

@interface MKSBMotionModeModel : NSObject

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, copy)NSString *numberOfFixOnStart;

/*
 0:WIFI
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 */
@property (nonatomic, assign)NSInteger posStrategyOnStart;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, copy)NSString *reportIntervalInTrip;

/*
 0:WIFI
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 */
@property (nonatomic, assign)NSInteger posStrategyInTrip;

@property (nonatomic, assign)BOOL fixOnEnd;

@property (nonatomic, copy)NSString *tripEndTimeout;

@property (nonatomic, copy)NSString *numberOfFixOnEnd;

@property (nonatomic, copy)NSString *reportIntervalOnEnd;

/*
 0:WIFI
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 */
@property (nonatomic, assign)NSInteger posStrategyOnEnd;

@property (nonatomic, assign)BOOL fixOnStationaryState;

@property (nonatomic, copy)NSString *reportIntervalOnStationary;

/*
 0:WIFI
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 7:BLE&GPS
 */
@property (nonatomic, assign)NSInteger posStrategyOnStationary;

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
