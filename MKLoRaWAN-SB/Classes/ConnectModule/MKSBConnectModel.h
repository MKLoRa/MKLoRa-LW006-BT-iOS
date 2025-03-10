//
//  MKSBConnectModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKSBConnectModel : NSObject

+ (MKSBConnectModel *)shared;

/// 设备连接的时候是否需要密码
@property (nonatomic, assign, readonly)BOOL hasPassword;

/// 设备类型,   @"00":L76  @"01":LR1110    
@property (nonatomic, copy, readonly)NSString *deviceType;

@property (nonatomic, copy, readonly)NSString *macAddress;

/// 连接设备
/// @param peripheral 设备
/// @param password 密码
/// @param deviceType 00:LR1110    10:L76
/// @param macAddress macAddress
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)connectDevice:(CBPeripheral *)peripheral
             password:(NSString *)password
           deviceType:(NSString *)deviceType
           macAddress:(NSString *)macAddress
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
