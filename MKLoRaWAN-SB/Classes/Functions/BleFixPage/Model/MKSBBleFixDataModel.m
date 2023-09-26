//
//  MKSBBleFixDataModel.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBBleFixDataModel.h"

#import "MKMacroDefines.h"

#import "MKSBInterface.h"
#import "MKSBInterface+MKSBConfig.h"

@interface MKSBBleFixDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSBBleFixDataModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBlePositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Timeout Error" block:failedBlock];
            return;
        }
        if (![self readBlePositioningMac]) {
            [self operationFailedBlockWithMsg:@"Read Number Error" block:failedBlock];
            return;
        }
        if (![self readBlePriority]) {
            [self operationFailedBlockWithMsg:@"Read Ble Priority Error" block:failedBlock];
            return;
        }
        if (![self readFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Read Filter Rssi Error" block:failedBlock];
            return;
        }
        if (![self readPHYMode]) {
            [self operationFailedBlockWithMsg:@"Read PHY Mode Error" block:failedBlock];
            return;
        }
        if (![self readFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Read Filter Relationship Error" block:failedBlock];
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
        if (![self configBlePositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Timeout Error" block:failedBlock];
            return;
        }
        if (![self configBlePositioningMac]) {
            [self operationFailedBlockWithMsg:@"Config Number Error" block:failedBlock];
            return;
        }
        if (![self configBlePriority]) {
            [self operationFailedBlockWithMsg:@"Config Ble Priority Error" block:failedBlock];
            return;
        }
        if (![self configFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Config Filter Rssi Error" block:failedBlock];
            return;
        }
        if (![self configPHYMode]) {
            [self operationFailedBlockWithMsg:@"Config PHY Mode Error" block:failedBlock];
            return;
        }
        if (![self configFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Config Filter Relationship Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readBlePositioningTimeout {
    __block BOOL success = NO;
    [MKSBInterface sb_readBlePositioningTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBlePositioningTimeout {
    __block BOOL success = NO;
    [MKSBInterface sb_configBlePositioningTimeout:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBlePositioningMac {
    __block BOOL success = NO;
    [MKSBInterface sb_readBlePositioningNumberOfMacWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.number = returnData[@"result"][@"number"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBlePositioningMac {
    __block BOOL success = NO;
    [MKSBInterface sb_configBlePositioningNumberOfMac:[self.number integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBlePriority {
    __block BOOL success = NO;
    [MKSBInterface sb_readBluetoothFixMechanismWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger value = [returnData[@"result"][@"priority"] integerValue];
        self.priority = (value == 0 ? 1 : 0);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBlePriority {
    __block BOOL success = NO;
    mk_sb_bluetoothFixMechanism mechanism = (self.priority == 1 ? mk_sb_bluetoothFixMechanism_timePriority : mk_sb_bluetoothFixMechanism_rssiPriority);
    [MKSBInterface sb_configBluetoothFixMechanism:mechanism sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterRssi {
    __block BOOL success = NO;
    [MKSBInterface sb_readRssiFilterValueWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rssi = [returnData[@"result"][@"rssi"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRssi {
    __block BOOL success = NO;
    [MKSBInterface sb_configRssiFilterValue:self.rssi sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPHYMode {
    __block BOOL success = NO;
    [MKSBInterface sb_readScanningPHYTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.phy = [returnData[@"result"][@"phyType"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPHYMode {
    __block BOOL success = NO;
    [MKSBInterface sb_configScanningPHYType:self.phy sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterRelationship {
    __block BOOL success = NO;
    [MKSBInterface sb_readFilterRelationshipWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.relationship = [returnData[@"result"][@"relationship"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRelationship {
    __block BOOL success = NO;
    [MKSBInterface sb_configFilterRelationship:self.relationship sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"BleFixParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 1 || [self.timeout integerValue] > 10) {
        return NO;
    }
    if (!ValidStr(self.number) || [self.number integerValue] < 1 || [self.number integerValue] > 15) {
        return NO;
    }
    if (self.rssi < -127 || self.rssi > 0) {
        return NO;
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
        _readQueue = dispatch_queue_create("BleFixQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
