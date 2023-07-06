//
//  MKSBOnOffSettingsModel.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBOnOffSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKSBInterface.h"

@interface MKSBOnOffSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSBOnOffSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readShutDownPayload]) {
            [self operationFailedBlockWithMsg:@"Read Shut-Down Payload Error" block:failedBlock];
            return;
        }
        if (![self readOffByButton]) {
            [self operationFailedBlockWithMsg:@"Read Off By Button Error" block:failedBlock];
            return;
        }
        if (![self readAutoPowerOn]) {
            [self operationFailedBlockWithMsg:@"Read Auto Power On Error" block:failedBlock];
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

- (BOOL)readShutDownPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_readShutdownPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.payload = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOffByButton {
    __block BOOL success = NO;
    [MKSBInterface sb_readOffByButtonWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.button = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAutoPowerOn {
    __block BOOL success = NO;
    [MKSBInterface sb_readAutoPowerOnWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.powerOn = [returnData[@"result"][@"isOn"] boolValue];
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
        NSError *error = [[NSError alloc] initWithDomain:@"OnOffSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("OnOffSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
