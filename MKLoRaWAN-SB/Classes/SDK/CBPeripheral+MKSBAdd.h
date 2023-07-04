//
//  CBPeripheral+MKSBAdd.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKSBAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *sb_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *sb_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *sb_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *sb_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *sb_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *sb_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *sb_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *sb_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *sb_storageData;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *sb_log;

- (void)sb_updateCharacterWithService:(CBService *)service;

- (void)sb_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)sb_connectSuccess;

- (void)sb_setNil;

@end

NS_ASSUME_NONNULL_END
