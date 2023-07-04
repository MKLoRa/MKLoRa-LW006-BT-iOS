//
//  MKSBAlarmFunctionModel.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBAlarmFunctionModel.h"

#import "MKMacroDefines.h"

#import "MKSBInterface.h"
#import "MKSBInterface+MKSBConfig.h"

@interface MKSBAlarmFunctionModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSBAlarmFunctionModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAlarmType]) {
            [self operationFailedBlockWithMsg:@"Read Alarm Type Error" block:failedBlock];
            return;
        }
        if (![self readExitAlarmType]) {
            [self operationFailedBlockWithMsg:@"Read Exit Alarm Type Error" block:failedBlock];
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
        if (![self checkParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configAlarmType]) {
            [self operationFailedBlockWithMsg:@"Config Alarm Type Error" block:failedBlock];
            return;
        }
        if (![self configExitAlarmType]) {
            [self operationFailedBlockWithMsg:@"Config Exit Alarm Type Error" block:failedBlock];
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
- (BOOL)readAlarmType {
    __block BOOL success = NO;
    [MKSBInterface sb_readAlarmTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.alarmType = [returnData[@"result"][@"type"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAlarmType {
    __block BOOL success = NO;
    [MKSBInterface sb_configAlarmType:self.alarmType sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readExitAlarmType {
    __block BOOL success = NO;
    [MKSBInterface sb_readExitAlarmTypeTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.exitTime = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configExitAlarmType {
    __block BOOL success = NO;
    [MKSBInterface sb_configExitAlarmTypeTime:[self.exitTime integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"AlarmFunctionParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    if (!ValidStr(self.exitTime) || [self.exitTime integerValue] < 5 || [self.exitTime integerValue] > 15) {
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
        _readQueue = dispatch_queue_create("AlarmFunctionQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
