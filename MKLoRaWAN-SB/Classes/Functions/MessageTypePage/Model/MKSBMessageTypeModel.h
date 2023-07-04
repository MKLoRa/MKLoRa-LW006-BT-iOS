//
//  MKSBMessageTypeModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/28.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBMessageTypeModel : NSObject

@property (nonatomic, assign)NSInteger deviceType;

@property (nonatomic, assign)NSInteger deviceMaxTimes;

@property (nonatomic, assign)NSInteger heartbeatType;

@property (nonatomic, assign)NSInteger heartbeatMaxTimes;

@property (nonatomic, assign)NSInteger lowpowerType;

@property (nonatomic, assign)NSInteger lowpowerMaxTimes;

@property (nonatomic, assign)NSInteger eventType;

@property (nonatomic, assign)NSInteger eventMaxTimes;

@property (nonatomic, assign)NSInteger gpsType;

@property (nonatomic, assign)NSInteger gpsMaxTimes;

@property (nonatomic, assign)NSInteger positioningType;

@property (nonatomic, assign)NSInteger positioningMaxTimes;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
