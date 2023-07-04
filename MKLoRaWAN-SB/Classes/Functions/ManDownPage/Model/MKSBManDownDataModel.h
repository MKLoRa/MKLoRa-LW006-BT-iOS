//
//  MKSBManDownDataModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBManDownDataModel : NSObject

@property (nonatomic, assign)BOOL detection;

@property (nonatomic, copy)NSString *timeout;

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

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, assign)BOOL start;

@property (nonatomic, assign)BOOL end;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
