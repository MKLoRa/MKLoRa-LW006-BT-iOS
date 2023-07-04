//
//  MKSBScanPageModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKSBScanPageModel : NSObject

/**
 当前model所在的row
 */
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)NSInteger rssi;

@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, copy)NSString *deviceName;

/// 设备类型 @"00":LR1110    @"01":L76
@property (nonatomic, copy)NSString *deviceType;

@property (nonatomic, copy)NSString *macAddress;

/// 电池电量百分比
@property (nonatomic, copy)NSString *battery;

/// 电压，0.001v
@property (nonatomic, copy)NSString *voltage;

/// 是否需要密码连接
@property (nonatomic, assign)BOOL needPassword;

/// 是否可连接
@property (nonatomic, assign)BOOL connectable;

/// 硬件是否有L76K模块
@property (nonatomic, assign)BOOL hardModule;

@property (nonatomic, strong)NSNumber *txPower;

/// cell上面显示的时间
@property (nonatomic, copy)NSString *scanTime;

/**
 上一次扫描到的时间
 */
@property (nonatomic, copy)NSString *lastScanDate;

@end

NS_ASSUME_NONNULL_END
