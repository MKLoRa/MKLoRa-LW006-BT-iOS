//
//  MKSBDeviceSettingModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBDeviceSettingModel : NSObject

@property (nonatomic, assign)NSInteger timeZone;

/// 0:10% 1:20% 2:30% 3:40%  4:50%  5:60%
@property (nonatomic, assign)NSInteger prompt;

@property (nonatomic, assign)BOOL lowPowerPayload;

/// 0:No  1:Alarm  2:Normal
@property (nonatomic, assign)NSInteger buzzer;

/// 0:No   1:Low  2:Medium 3:High
@property (nonatomic, assign)NSInteger vibration;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
