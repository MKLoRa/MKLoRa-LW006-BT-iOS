//
//  MKSBSelftestModel.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBSelftestModel.h"

#import "MKMacroDefines.h"

#import "MKSBInterface.h"

@interface MKSBSelftestModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKSBSelftestModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPCBAStatus]) {
            [self operationFailedBlockWithMsg:@"Read PCBA Status Error" block:failedBlock];
            return;
        }
        if (![self readSelftestStatus]) {
            [self operationFailedBlockWithMsg:@"Read Self Test Status Error" block:failedBlock];
            return;
        }
        if (![self readGPSPositioning]) {
            [self operationFailedBlockWithMsg:@"Read GPS Positioning Error" block:failedBlock];
            return;
        }
        if (![self readBatteryDatas]) {
            [self operationFailedBlockWithMsg:@"Read Battery Datas Error" block:failedBlock];
            return;
        }
        if (![self readMotorState]) {
            [self operationFailedBlockWithMsg:@"Read Motor State Error" block:failedBlock];
            return;
        }
        if (![self readHardVersion]) {
            [self operationFailedBlockWithMsg:@"Read Hardware Version Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readPCBAStatus {
    __block BOOL success = NO;
    [MKSBInterface sb_readPCBAStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pcbaStatus = returnData[@"result"][@"status"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSelftestStatus {
    __block BOOL success = NO;
    [MKSBInterface sb_readSelftestStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSString *binary = [self binaryByhex:returnData[@"result"][@"status"]];
        self.l76c = [binary substringWithRange:NSMakeRange(7, 1)];
        self.acceData = [binary substringWithRange:NSMakeRange(6, 1)];
        self.flash = [binary substringWithRange:NSMakeRange(5, 1)];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readGPSPositioning {
    __block BOOL success = NO;
    [MKSBInterface sb_readGPSPositioningWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.gpsPositioning = [returnData[@"result"][@"type"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBatteryDatas {
    __block BOOL success = NO;
    [MKSBInterface sb_readBatteryInformationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.workTimes = returnData[@"result"][@"workTimes"];
        self.advCount = returnData[@"result"][@"advCount"];
        self.flashOperationCount = returnData[@"result"][@"flashOperationCount"];
        self.axisWakeupTimes = returnData[@"result"][@"axisWakeupTimes"];
        self.blePostionTimes = returnData[@"result"][@"blePostionTimes"];
        self.wifiPostionTimes = returnData[@"result"][@"wifiPostionTimes"];
        self.gpsPostionTimes = returnData[@"result"][@"gpsPostionTimes"];
        self.loraPowerConsumption = returnData[@"result"][@"loraPowerConsumption"];
        self.loraSendCount = returnData[@"result"][@"loraSendCount"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMotorState {
    __block BOOL success = NO;
    [MKSBInterface sb_readMotorStateWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.motorState = [returnData[@"result"][@"state"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHardVersion {
    __block BOOL success = NO;
    [MKSBInterface sb_readHardwareTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.hwVersion = [returnData[@"result"][@"type"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}


#pragma mark - private method
- (NSString *)binaryByhex:(NSString *)hex {
    NSDictionary *hexDic = @{
                             @"0":@"0000",@"1":@"0001",@"2":@"0010",
                             @"3":@"0011",@"4":@"0100",@"5":@"0101",
                             @"6":@"0110",@"7":@"0111",@"8":@"1000",
                             @"9":@"1001",@"A":@"1010",@"a":@"1010",
                             @"B":@"1011",@"b":@"1011",@"C":@"1100",
                             @"c":@"1100",@"D":@"1101",@"d":@"1101",
                             @"E":@"1110",@"e":@"1110",@"F":@"1111",
                             @"f":@"1111",
                             };
    NSString *binaryString = @"";
    for (int i=0; i<[hex length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hex substringWithRange:rage];
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,
                        [NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    return binaryString;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"selftest"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
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
        _readQueue = dispatch_queue_create("selftestQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
