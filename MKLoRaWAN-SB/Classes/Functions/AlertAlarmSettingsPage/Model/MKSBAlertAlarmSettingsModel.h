//
//  MKSBAlertAlarmSettingsModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBAlertAlarmSettingsModel : NSObject

/// 0:Single Click  1:Double Click  2:Long Press 1s 3:Long Press 2s 4:Long Press 3s
@property (nonatomic, assign)NSInteger mode;

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

@property (nonatomic, assign)BOOL start;

@property (nonatomic, assign)BOOL end;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
