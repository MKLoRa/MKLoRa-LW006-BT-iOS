//
//  MKSBWifiFixModel.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBWifiFixModel.h"

#import "MKMacroDefines.h"

#import "MKSBInterface.h"
#import "MKSBInterface+MKSBConfig.h"

@interface MKSBWifiFixModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSBWifiFixModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Read positioning timeout error" block:failedBlock];
            return;
        }
        if (![self readNumberOfBSSID]) {
            [self operationFailedBlockWithMsg:@"Read number of BSSID error" block:failedBlock];
            return;
        }
        if (![self readDataType]) {
            [self operationFailedBlockWithMsg:@"Read Data Type error" block:failedBlock];
            return;
        }
        if (![self readMechanism]) {
            [self operationFailedBlockWithMsg:@"Read Mechanism error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self checkParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configPositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Config positioning timeout error" block:failedBlock];
            return;
        }
        if (![self configNumberOfBSSID]) {
            [self operationFailedBlockWithMsg:@"Config number of BSSID error" block:failedBlock];
            return;
        }
        if (![self configDataType]) {
            [self operationFailedBlockWithMsg:@"Config Data Type error" block:failedBlock];
            return;
        }
        if (![self configMechanism]) {
            [self operationFailedBlockWithMsg:@"Config Mechanism error" block:failedBlock];
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
- (BOOL)readPositioningTimeout {
    __block BOOL success = NO;
    [MKSBInterface sb_readWifiPositioningTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPositioningTimeout {
    __block BOOL success = NO;
    [MKSBInterface sb_configWifiPositioningTimeout:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNumberOfBSSID {
    __block BOOL success = NO;
    [MKSBInterface sb_readWifiNumberOfBSSIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.number = returnData[@"result"][@"number"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNumberOfBSSID {
    __block BOOL success = NO;
    [MKSBInterface sb_configWifiNumberOfBSSID:[self.number integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDataType {
    __block BOOL success = NO;
    [MKSBInterface sb_readWifiDataTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.dataType = [returnData[@"result"][@"dataType"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDataType {
    __block BOOL success = NO;
    [MKSBInterface sb_configWifiDataType:self.dataType sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMechanism {
    __block BOOL success = NO;
    [MKSBInterface sb_readWifiFixMechanismWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger value = [returnData[@"result"][@"mechanism"] integerValue];
        self.mechanism = (value == 0 ? 1 : 0);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMechanism {
    __block BOOL success = NO;
    mk_sb_bluetoothFixMechanism value = (self.mechanism == 0 ? mk_sb_wifiFixMechanism_rssiPriority : mk_sb_wifiFixMechanism_timePriority);
    [MKSBInterface sb_configWifiFixMechanism:value sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"wifiPositionParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 1 || [self.timeout integerValue] > 10) {
        return NO;
    }
    if (!ValidStr(self.number) || [self.number integerValue] < 1 || [self.number integerValue] > 15) {
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
        _readQueue = dispatch_queue_create("wifiPositionQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
