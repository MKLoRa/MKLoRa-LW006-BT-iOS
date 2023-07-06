//
//  MKSBSelftestModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBSelftestModel : NSObject

@property (nonatomic, copy)NSString *l76c;

@property (nonatomic, copy)NSString *acceData;

@property (nonatomic, copy)NSString *flash;

@property (nonatomic, copy)NSString *pcbaStatus;

/// 0:Traditional GPS module 1:LoRa Cloud
@property (nonatomic, assign)NSInteger gpsPositioning;



@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *flashOperationCount;

@property (nonatomic, copy)NSString *axisWakeupTimes;

@property (nonatomic, copy)NSString *blePostionTimes;

@property (nonatomic, copy)NSString *wifiPostionTimes;

@property (nonatomic, copy)NSString *gpsPostionTimes;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *loraPowerConsumption;

/// 0:Normal  1:Fault
@property (nonatomic, assign)NSInteger motorState;

/// 0:Traditional GPS module Supported  1:No
@property (nonatomic, assign)NSInteger hwVersion;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;;

@end

NS_ASSUME_NONNULL_END
