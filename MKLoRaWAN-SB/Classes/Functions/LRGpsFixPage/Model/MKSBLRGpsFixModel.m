//
//  MKSBLRGpsFixModel.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBLRGpsFixModel.h"

#import "MKMacroDefines.h"

#import "MKSBInterface.h"
#import "MKSBInterface+MKSBConfig.h"

@interface MKSBLRGpsFixModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSBLRGpsFixModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Positioning Timeout Error" block:failedBlock];
            return;
        }
        if (![self readStatelliteThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Statellite Threshold Error" block:failedBlock];
            return;
        }
        if (![self readGPSDataType]) {
            [self operationFailedBlockWithMsg:@"Read GPS Data Type Error" block:failedBlock];
            return;
        }
        if (![self readPositioningSystem]) {
            [self operationFailedBlockWithMsg:@"Read Positioning System Error" block:failedBlock];
            return;
        }
        if (![self readAiding]) {
            [self operationFailedBlockWithMsg:@"Read Autonomous Aiding Error" block:failedBlock];
            return;
        }
        if (![self readLatitudeLongitude]) {
            [self operationFailedBlockWithMsg:@"Read Latitude Longitude Error" block:failedBlock];
            return;
        }
        if (![self readEphemeris]) {
            [self operationFailedBlockWithMsg:@"Read Notify On Ephemeris Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configPositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Positioning Timeout Error" block:failedBlock];
            return;
        }
        if (![self configStatelliteThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Statellite Threshold Error" block:failedBlock];
            return;
        }
        if (![self configGPSDataType]) {
            [self operationFailedBlockWithMsg:@"Config GPS Data Type Error" block:failedBlock];
            return;
        }
        if (![self configPositioningSystem]) {
            [self operationFailedBlockWithMsg:@"Config Positioning System Error" block:failedBlock];
            return;
        }
        if (![self configAiding]) {
            [self operationFailedBlockWithMsg:@"Config Autonomous Aiding Error" block:failedBlock];
            return;
        }
        if (self.aiding) {
            if (![self configLatitudeLongitude]) {
                [self operationFailedBlockWithMsg:@"Config Latitude Longitude Error" block:failedBlock];
                return;
            }
            if (![self configEphemeris]) {
                [self operationFailedBlockWithMsg:@"Config Notify On Ephemeris Error" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interfae
- (BOOL)readPositioningTimeout {
    __block BOOL success = NO;
    [MKSBInterface sb_readLRPositioningTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPositioningTimeout {
    __block BOOL success = NO;
    [MKSBInterface sb_configLRPositioningTimeout:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readStatelliteThreshold {
    __block BOOL success = NO;
    [MKSBInterface sb_readLRStatelliteThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.threshold = returnData[@"result"][@"number"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configStatelliteThreshold {
    __block BOOL success = NO;
    [MKSBInterface sb_configLRStatelliteThreshold:[self.threshold integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readGPSDataType {
    __block BOOL success = NO;
    [MKSBInterface sb_readLRGPSDataTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.dataType = [returnData[@"result"][@"dataType"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configGPSDataType {
    __block BOOL success = NO;
    [MKSBInterface sb_configLRGPSDataType:self.dataType sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPositioningSystem {
    __block BOOL success = NO;
    [MKSBInterface sb_readLRPositioningSystemWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.postionSystem = [returnData[@"result"][@"type"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPositioningSystem {
    __block BOOL success = NO;
    [MKSBInterface sb_configLRPositioningSystem:self.postionSystem sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAiding {
    __block BOOL success = NO;
    [MKSBInterface sb_readLRAutonomousAidingWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.aiding = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAiding {
    __block BOOL success = NO;
    [MKSBInterface sb_configLRAutonomousAiding:self.aiding sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLatitudeLongitude {
    __block BOOL success = NO;
    [MKSBInterface sb_readLRLatitudeLongitudeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.longitude = returnData[@"result"][@"longitude"];
        self.latitude = returnData[@"result"][@"latitude"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLatitudeLongitude {
    __block BOOL success = NO;
    [MKSBInterface sb_configLRLatitude:[self.latitude integerValue] longitude:[self.longitude integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEphemeris {
    __block BOOL success = NO;
    [MKSBInterface sb_readLRNotifyOnEphemerisStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.start = [returnData[@"result"][@"start"] boolValue];
        self.end = [returnData[@"result"][@"end"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configEphemeris {
    __block BOOL success = NO;
    [MKSBInterface sb_configLRNotifyOnEphemerisStartStatus:self.start endStatus:self.end sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"LRGpsFixParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 5 || [self.timeout integerValue] > 50) {
        return NO;
    }
    if (!ValidStr(self.threshold) || [self.threshold integerValue] < 4 || [self.threshold integerValue] > 10) {
        return NO;
    }
    if (self.aiding) {
        if (!ValidStr(self.latitude) || [self.latitude integerValue] < -9000000 || [self.latitude integerValue] > 9000000) {
            return NO;
        }
        if (!ValidStr(self.longitude) || [self.longitude integerValue] < -18000000 || [self.longitude integerValue] > 18000000) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("LRGpsFixQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
