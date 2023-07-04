//
//  MKSBMessageTypeModel.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/28.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBMessageTypeModel.h"

#import "MKMacroDefines.h"

#import "MKSBInterface.h"
#import "MKSBInterface+MKSBConfig.h"

@interface MKSBMessageTypeModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSBMessageTypeModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readDevicePayload]) {
            [self operationFailedBlockWithMsg:@"Read Device Info Payload Error" block:failedBlock];
            return;
        }
        if (![self readHeartbeatPayload]) {
            [self operationFailedBlockWithMsg:@"Read Heartbeat Payload Error" block:failedBlock];
            return;
        }
        if (![self readLowPowerPayload]) {
            [self operationFailedBlockWithMsg:@"Read Low Power Payload Error" block:failedBlock];
            return;
        }
        if (![self readEventPayload]) {
            [self operationFailedBlockWithMsg:@"Read Event Payload Error" block:failedBlock];
            return;
        }
        if (![self readGpsPayload]) {
            [self operationFailedBlockWithMsg:@"Read Gps Payload Error" block:failedBlock];
            return;
        }
        if (![self readPositioningPayload]) {
            [self operationFailedBlockWithMsg:@"Read Positioning Payload Error" block:failedBlock];
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
        if (![self configDevicePayload]) {
            [self operationFailedBlockWithMsg:@"Config Device Info Payload Error" block:failedBlock];
            return;
        }
        if (![self configHeartbeatPayload]) {
            [self operationFailedBlockWithMsg:@"Config Heartbeat Payload Error" block:failedBlock];
            return;
        }
        if (![self configLowPowerPayload]) {
            [self operationFailedBlockWithMsg:@"Config Low Power Payload Error" block:failedBlock];
            return;
        }
        if (![self configEventPayload]) {
            [self operationFailedBlockWithMsg:@"Config Event Payload Error" block:failedBlock];
            return;
        }
        if (![self configGpsPayload]) {
            [self operationFailedBlockWithMsg:@"Config Gps Payload Error" block:failedBlock];
            return;
        }
        if (![self configPositioningPayload]) {
            [self operationFailedBlockWithMsg:@"Config Positioning Payload Error" block:failedBlock];
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
- (BOOL)readDevicePayload {
    __block BOOL success = NO;
    [MKSBInterface sb_readDeviceInfoPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.deviceType = [returnData[@"result"][@"type"] integerValue];
        self.deviceMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDevicePayload {
    __block BOOL success = NO;
    [MKSBInterface sb_configDeviceInfoPayloadWithMessageType:self.deviceType retransmissionTimes:(self.deviceMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHeartbeatPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_readHeartbeatPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.heartbeatType = [returnData[@"result"][@"type"] integerValue];
        self.heartbeatMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configHeartbeatPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_configHeartbeatPayloadWithMessageType:self.heartbeatType retransmissionTimes:(self.heartbeatMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_readLowPowerPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lowpowerType = [returnData[@"result"][@"type"] integerValue];
        self.lowpowerMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_configLowPowerPayloadWithMessageType:self.lowpowerType retransmissionTimes:(self.lowpowerMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEventPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_readEventPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.eventType = [returnData[@"result"][@"type"] integerValue];
        self.eventMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configEventPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_configEventPayloadWithMessageType:self.eventType retransmissionTimes:(self.eventMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readGpsPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_readGPSLimitPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.gpsType = [returnData[@"result"][@"type"] integerValue];
        self.gpsMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configGpsPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_configGPSLimitPayloadWithMessageType:self.gpsType retransmissionTimes:(self.gpsMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPositioningPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_readPositioningPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.positioningType = [returnData[@"result"][@"type"] integerValue];
        self.positioningMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPositioningPayload {
    __block BOOL success = NO;
    [MKSBInterface sb_configPositioningPayloadWithMessageType:self.positioningType retransmissionTimes:(self.positioningMaxTimes + 1) sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"MessageTypeParams"
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
        _readQueue = dispatch_queue_create("MessageTypeQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
