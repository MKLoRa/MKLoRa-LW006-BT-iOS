//
//  MKSBIndicatorSettingsModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKSBSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSBIndicatorSettingsModel : NSObject<mk_sb_indicatorSettingsProtocol>

@property (nonatomic, assign)BOOL deviceState;
@property (nonatomic, assign)BOOL lowPower;
@property (nonatomic, assign)BOOL charging;
@property (nonatomic, assign)BOOL fullCharge;
@property (nonatomic, assign)BOOL bluetoothConnection;
@property (nonatomic, assign)BOOL networkCheck;
@property (nonatomic, assign)BOOL inFix;
@property (nonatomic, assign)BOOL fixSuccessful;
@property (nonatomic, assign)BOOL failToFix;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
