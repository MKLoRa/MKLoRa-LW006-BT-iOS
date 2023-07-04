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

@property (nonatomic, assign)BOOL shutdownPayload;

@property (nonatomic, assign)BOOL lowPowerPayload;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END
