//
//  MKSBInterface.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKSBCentralManager.h"
#import "MKSBOperationID.h"
#import "MKSBOperation.h"
#import "CBPeripheral+MKSBAdd.h"
#import "MKSBSDKDataAdopter.h"

#define centralManager [MKSBCentralManager shared]
#define peripheral ([MKSBCentralManager shared].peripheral)

@implementation MKSBInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)sb_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_sb_taskReadDeviceModelOperation
                           characteristic:peripheral.sb_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)sb_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_sb_taskReadFirmwareOperation
                           characteristic:peripheral.sb_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)sb_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_sb_taskReadHardwareOperation
                           characteristic:peripheral.sb_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)sb_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_sb_taskReadSoftwareOperation
                           characteristic:peripheral.sb_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)sb_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_sb_taskReadManufacturerOperation
                           characteristic:peripheral.sb_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark ****************************************System************************************************

+ (void)sb_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadWorkModeOperation
                     cmdFlag:@"1b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadHeartbeatIntervalOperation
                     cmdFlag:@"20"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readThreeAxisWakeupConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadThreeAxisWakeupConditionsOperation
                     cmdFlag:@"21"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readThreeAxisMotionParametersWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadThreeAxisMotionParametersOperation
                     cmdFlag:@"22"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}








+ (void)sb_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadTimeZoneOperation
                     cmdFlag:@"14"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}



+ (void)sb_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadIndicatorSettingsOperation
                     cmdFlag:@"16"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadShutdownPayloadStatusOperation
                     cmdFlag:@"19"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLowPowerPayloadStatusOperation
                     cmdFlag:@"1b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLowPowerPromptOperation
                     cmdFlag:@"1c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBatteryVoltageOperation
                     cmdFlag:@"20"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMacAddressOperation
                     cmdFlag:@"21"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadPCBAStatusOperation
                     cmdFlag:@"22"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadSelftestStatusOperation
                     cmdFlag:@"23"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBatteryInformationOperation
                     cmdFlag:@"25"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙相关参数************************************************

+ (void)sb_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"30"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadPasswordOperation
                     cmdFlag:@"31"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBroadcastTimeoutOperation
                     cmdFlag:@"32"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadTxPowerOperation
                     cmdFlag:@"33"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadDeviceNameOperation
                     cmdFlag:@"34"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadAdvIntervalOperation
                     cmdFlag:@"35"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************模式相关参数************************************************

+ (void)sb_readStandbyModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadStandbyModePositioningStrategyOperation
                     cmdFlag:@"3f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readPeriodicModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadPeriodicModePositioningStrategyOperation
                     cmdFlag:@"40"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readPeriodicModeReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadPeriodicModeReportIntervalOperation
                     cmdFlag:@"41"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readTimingModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadTimingModePositioningStrategyOperation
                     cmdFlag:@"42"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readTimingModeReportingTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadTimingModeReportingTimePointOperation
                     cmdFlag:@"43"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModeEventsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModeEventsOperation
                     cmdFlag:@"44"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModeNumberOfFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModeNumberOfFixOnStartOperation
                     cmdFlag:@"45"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModePosStrategyOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModePosStrategyOnStartOperation
                     cmdFlag:@"46"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModeReportIntervalInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModeReportIntervalInTripOperation
                     cmdFlag:@"47"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModePosStrategyInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModePosStrategyInTripOperation
                     cmdFlag:@"48"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModeTripEndTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModeTripEndTimeoutOperation
                     cmdFlag:@"49"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModeNumberOfFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModeNumberOfFixOnEndOperation
                     cmdFlag:@"4a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModeReportIntervalOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModeReportIntervalOnEndOperation
                     cmdFlag:@"4b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModePosStrategyOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModePosStrategyOnEndOperation
                     cmdFlag:@"4c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModePosStrategyOnStationaryWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModePosStrategyOnStationaryOperation
                     cmdFlag:@"4d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readMotionModeReportIntervalOnStationaryWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadMotionModeReportIntervalOnStationaryOperation
                     cmdFlag:@"4e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙扫描过滤参数************************************************

+ (void)sb_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadScanningPHYTypeOperation
                     cmdFlag:@"50"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadRssiFilterValueOperation
                     cmdFlag:@"51"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterRelationshipOperation
                     cmdFlag:@"52"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByMacPreciseMatchOperation
                     cmdFlag:@"53"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByMacReverseFilterOperation
                     cmdFlag:@"54"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterMACAddressListOperation
                     cmdFlag:@"55"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByAdvNamePreciseMatchOperation
                     cmdFlag:@"56"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByAdvNameReverseFilterOperation
                     cmdFlag:@"57"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee005800";
    [centralManager addTaskWithTaskID:mk_sb_taskReadFilterAdvNameListOperation
                       characteristic:peripheral.sb_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *advList = [MKSBSDKDataAdopter parseFilterAdvNameList:returnData[@"result"]];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"nameList":advList,
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
        
    } failureBlock:failedBlock];
}

+ (void)sb_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterTypeStatusOperation
                     cmdFlag:@"59"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBeaconStatusOperation
                     cmdFlag:@"5a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBeaconMajorRangeOperation
                     cmdFlag:@"5b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBeaconMinorRangeOperation
                     cmdFlag:@"5c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBeaconUUIDOperation
                     cmdFlag:@"5d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByUIDStatusOperation
                     cmdFlag:@"5e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByUIDNamespaceIDOperation
                     cmdFlag:@"5f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByUIDInstanceIDOperation
                     cmdFlag:@"60"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByURLStatusOperation
                     cmdFlag:@"61"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByURLContentOperation
                     cmdFlag:@"62"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByTLMStatusOperation
                     cmdFlag:@"63"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByTLMVersionOperation
                     cmdFlag:@"64"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBXPBeaconStatusOperation
                     cmdFlag:@"65"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBXPBeaconMajorRangeOperation
                     cmdFlag:@"66"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBXPBeaconMinorRangeOperation
                     cmdFlag:@"67"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBXPBeaconUUIDOperation
                     cmdFlag:@"68"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBXPButtonFilterStatusOperation
                     cmdFlag:@"6c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBXPButtonAlarmFilterStatusOperation
                     cmdFlag:@"6d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByBXPTagIDStatusOperation
                     cmdFlag:@"6e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadPreciseMatchTagIDStatusOperation
                     cmdFlag:@"6f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadReverseFilterTagIDStatusOperation
                     cmdFlag:@"70"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterBXPTagIDListOperation
                     cmdFlag:@"71"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByPirStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByPirStatusOperation
                     cmdFlag:@"72"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByPirDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByPirDetectionStatusOperation
                     cmdFlag:@"73"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByPirSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByPirSensorSensitivityOperation
                     cmdFlag:@"74"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByPirDoorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByPirDoorStatusOperation
                     cmdFlag:@"75"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByPirDelayResponseStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByPirDelayResponseStatusOperation
                     cmdFlag:@"76"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByPirMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByPirMajorRangeOperation
                     cmdFlag:@"77"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByPirMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByPirMinorRangeOperation
                     cmdFlag:@"78"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByOtherStatusOperation
                     cmdFlag:@"79"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByOtherRelationshipOperation
                     cmdFlag:@"7a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadFilterByOtherConditionsOperation
                     cmdFlag:@"7b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}


#pragma mark ****************************************定位参数************************************************
+ (void)sb_readLCGpsExtrmeModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLCGpsExtrmeModeStatusOperation
                     cmdFlag:@"85"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLCPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLCPositioningTimeoutOperation
                     cmdFlag:@"86"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLCPDOPWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLCPDOPOperation
                     cmdFlag:@"87"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLRGPSDataTypeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLRGPSDataTypeOperation
                     cmdFlag:@"88"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLRPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLRPositioningTimeoutOperation
                     cmdFlag:@"89"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLRStatelliteThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLRStatelliteThresholdOperation
                     cmdFlag:@"8a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLRPositioningSystemWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLRPositioningSystemOperation
                     cmdFlag:@"8b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLRAutonomousAidingWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLRAutonomousAidingOperation
                     cmdFlag:@"8c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLRLatitudeLongitudeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLRLatitudeLongitudeOperation
                     cmdFlag:@"8d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLRNotifyOnEphemerisStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLRNotifyOnEphemerisStatusOperation
                     cmdFlag:@"8e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}










+ (void)sb_readWifiDataTypeWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadWifiDataTypeOperation
                     cmdFlag:@"7d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readWifiFixMechanismWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadWifiFixMechanismOperation
                     cmdFlag:@"7e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readWifiPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadWifiPositioningTimeoutOperation
                     cmdFlag:@"7f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readWifiNumberOfBSSIDWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadWifiNumberOfBSSIDOperation
                     cmdFlag:@"80"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBluetoothFixMechanismWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBluetoothFixMechanismOperation
                     cmdFlag:@"81"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBlePositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBlePositioningTimeoutOperation
                     cmdFlag:@"82"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBlePositioningNumberOfMacWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBlePositioningNumberOfMacOperation
                     cmdFlag:@"83"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readOfflineFixStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadOfflineFixStatusOperation
                     cmdFlag:@"8f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}
















+ (void)sb_readBXPAccFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBXPAccFilterStatusOperation
                     cmdFlag:@"72"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readBXPTHFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBXPTHFilterStatusOperation
                     cmdFlag:@"73"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}













+ (void)sb_readBXPDeviceInfoFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadBXPDeviceInfoFilterStatusOperation
                     cmdFlag:@"82"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}





#pragma mark **************************************** LoRaWAN ************************************************

+ (void)sb_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanNetworkStatusOperation
                     cmdFlag:@"90"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanRegionOperation
                     cmdFlag:@"91"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanModemOperation
                     cmdFlag:@"92"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"93"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"94"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"95"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanDEVADDROperation
                     cmdFlag:@"96"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"97"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"98"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanCHOperation
                     cmdFlag:@"99"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanDROperation
                     cmdFlag:@"9a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"9b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"9c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanADRACKLimitOperation
                     cmdFlag:@"9d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanADRACKDelayOperation
                     cmdFlag:@"9e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"9f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"a0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readDeviceInfoPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadDeviceInfoPayloadDataOperation
                     cmdFlag:@"a1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readHeartbeatPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadHeartbeatPayloadDataOperation
                     cmdFlag:@"a2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readLowPowerPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadLowPowerPayloadDataOperation
                     cmdFlag:@"a3"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readEventPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadEventPayloadDataOperation
                     cmdFlag:@"a4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readGPSLimitPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadGPSLimitPayloadDataOperation
                     cmdFlag:@"a5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readPositioningPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadPositioningPayloadDataOperation
                     cmdFlag:@"a6"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************辅助功能************************************************

+ (void)sb_readDownlinkPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadDownlinkPositioningStrategyOperation
                     cmdFlag:@"b0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readManDownDetectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadManDownDetectionOperation
                     cmdFlag:@"b1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readManDownPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadManDownPositioningStrategyOperation
                     cmdFlag:@"b2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readManDownDetectionTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadManDownDetectionTimeoutOperation
                     cmdFlag:@"b3"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readManDownReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadManDownReportIntervalOperation
                     cmdFlag:@"b4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readAlarmTypeWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadAlarmTypeOperation
                     cmdFlag:@"b5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readExitAlarmTypeTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadExitAlarmTypeTimeOperation
                     cmdFlag:@"b6"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readAlertAlarmTriggerModeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadAlertAlarmTriggerModeOperation
                     cmdFlag:@"b7"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readAlertAlarmPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadAlertAlarmPositioningStrategyOperation
                     cmdFlag:@"b8"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readAlertAlarmNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadAlertAlarmNotifyStatusOperation
                     cmdFlag:@"b9"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readSosAlarmTriggerModeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadSosAlarmTriggerModeOperation
                     cmdFlag:@"ba"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readSosAlarmPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadSosAlarmPositioningStrategyOperation
                     cmdFlag:@"bb"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readSosAlarmReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadSosAlarmReportIntervalOperation
                     cmdFlag:@"bc"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readSosAlarmNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadSosAlarmNotifyStatusOperation
                     cmdFlag:@"bd"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}




















+ (void)sb_readShockThresholdsWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadShockThresholdsOperation
                     cmdFlag:@"b4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readShockDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadShockDetectionReportIntervalOperation
                     cmdFlag:@"b5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readShockTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadShockTimeoutOperation
                     cmdFlag:@"b6"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readActiveStateCountStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadActiveStateCountStatusOperation
                     cmdFlag:@"ba"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)sb_readActiveStateTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_sb_taskReadActiveStateTimeoutOperation
                     cmdFlag:@"bb"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_sb_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.sb_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
