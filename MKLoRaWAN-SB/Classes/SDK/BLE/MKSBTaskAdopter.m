//
//  MKSBTaskAdopter.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKSBOperationID.h"
#import "MKSBSDKDataAdopter.h"

NSString *const mk_sb_totalNumKey = @"mk_sb_totalNumKey";
NSString *const mk_sb_totalIndexKey = @"mk_sb_totalIndexKey";
NSString *const mk_sb_contentKey = @"mk_sb_contentKey";

@implementation MKSBTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if (!MKValidData(readData) || readData.length == 0) {
        return @{};
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_sb_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_sb_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_sb_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_sb_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_sb_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_sb_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *headerString = [readString substringWithRange:NSMakeRange(0, 2)];
    if ([headerString isEqualToString:@"ee"]) {
        //分包协议
        return [self parsePacketData:readData];
    }
    if (![headerString isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    //不分包协议
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parsePacketData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(6, 2)];
        NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
        NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(10, 2)];
        if ([index integerValue] >= [totalNum integerValue]) {
            return @{};
        }
        mk_sb_taskOperationID operationID = mk_sb_defaultTaskOperationID;
        
        NSData *subData = [readData subdataWithRange:NSMakeRange(6, len)];
        NSDictionary *resultDic= @{
            mk_sb_totalNumKey:totalNum,
            mk_sb_totalIndexKey:index,
            mk_sb_contentKey:(subData ? subData : [NSData data]),
        };
        if ([cmd isEqualToString:@"58"]) {
            //读取Adv Name过滤规则
            operationID = mk_sb_taskReadFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:resultDic operationID:operationID];
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_sb_taskOperationID operationID = mk_sb_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(8, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        if ([cmd isEqualToString:@"58"]) {
            //配置Adv Name过滤规则
            operationID = mk_sb_taskConfigFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_sb_taskOperationID operationID = mk_sb_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"01"]) {
        
    }else if ([cmd isEqualToString:@"14"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_sb_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"15"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_sb_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"16"]) {
        //读取自检故障原因
//        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":content,
        };
        operationID = mk_sb_taskReadSelftestStatusOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //读取产测状态
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_sb_taskReadPCBAStatusOperation;
    }else if ([cmd isEqualToString:@"19"]) {
        //读取电池电压
        resultDic = @{
            @"voltage":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"1b"]) {
        //读取工作模式
        NSInteger mode = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"mode":[NSString stringWithFormat:@"%ld",mode],
        };
        operationID = mk_sb_taskReadWorkModeOperation;
    }else if ([cmd isEqualToString:@"1c"]) {
        //读取关机信息上报
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_sb_taskReadShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1d"]) {
        //读取按键关机开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_sb_taskReadOffByButtonOperation;
    }else if ([cmd isEqualToString:@"1e"]) {
        //读取低电触发心跳开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_sb_taskReadLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1f"]) {
        //读取低电百分比
        resultDic = @{
            @"prompt":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //读取设备心跳间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //读取三轴唤醒条件
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration,
        };
        operationID = mk_sb_taskReadThreeAxisWakeupConditionsOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //读取运动检测判断
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration,
        };
        operationID = mk_sb_taskReadThreeAxisMotionParametersOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //读取蜂鸣器声效选择
        resultDic = @{
            @"buzzer":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadBuzzerSoundTypeOperation;
    }else if ([cmd isEqualToString:@"24"]) {
        //读取马达震动强度
        NSInteger value = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        NSString *intensity = @"0";
        if (value >= 10 && value < 50) {
            intensity = @"1";
        }else if (value >= 50 && value < 80) {
            intensity = @"2";
        }else if (value >= 80) {
            intensity = @"3";
        }
        resultDic = @{
            @"intensity":intensity,
        };
        operationID = mk_sb_taskReadVibrationIntensityOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //读取马达异常状态
        resultDic = @{
            @"state":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadMotorStateOperation;
    }else if ([cmd isEqualToString:@"27"]) {
        //读取指示灯功能
        NSDictionary *indicatorSettings = [MKSBSDKDataAdopter fetchIndicatorSettings:content];
        resultDic = @{
            @"indicatorSettings":indicatorSettings,
        };
        operationID = mk_sb_taskReadIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"28"]) {
        //读取电池信息
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
        NSString *flashOperationCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(16, 8)];
        NSString *axisWakeupTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(24, 8)];
        NSString *blePostionTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(32, 8)];
        NSString *wifiPostionTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(40, 8)];
        NSString *gpsPostionTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(48, 8)];
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(56, 8)];
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(64, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"flashOperationCount":flashOperationCount,
            @"axisWakeupTimes":axisWakeupTimes,
            @"blePostionTimes":blePostionTimes,
            @"wifiPostionTimes":wifiPostionTimes,
            @"gpsPostionTimes":gpsPostionTimes,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
        };
        operationID = mk_sb_taskReadBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"2b"]) {
        //充电自动开机开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadAutoPowerOnOperation;
    }else if ([cmd isEqualToString:@"2c"]) {
        //读取硬件版本
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadHardwareTypeOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_sb_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_sb_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //读取广播超时时长
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //读取设备Tx Power
        NSString *txPower = [MKSBSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_sb_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_sb_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"3f"]) {
        //读取待机模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadStandbyModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //读取定期模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadPeriodicModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //读取定期模式上报间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_sb_taskReadPeriodicModeReportIntervalOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //读取定时模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadTimingModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //读取定时模式时间点
        NSArray *list = [MKSBSDKDataAdopter parseTimingModeReportingTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_sb_taskReadTimingModeReportingTimePointOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //读取运动模式事件
        NSString *binaryHex = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, content.length)]];
        
        BOOL notifyEventOnStart = [[binaryHex substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL fixOnStart = [[binaryHex substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL notifyEventInTrip = [[binaryHex substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL fixInTrip = [[binaryHex substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL notifyEventOnEnd = [[binaryHex substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL fixOnEnd = [[binaryHex substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL fixOnStationaryState = [[binaryHex substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        resultDic = @{
            @"notifyEventOnStart":@(notifyEventOnStart),
            @"fixOnStart":@(fixOnStart),
            @"notifyEventInTrip":@(notifyEventInTrip),
            @"fixInTrip":@(fixInTrip),
            @"notifyEventOnEnd":@(notifyEventOnEnd),
            @"fixOnEnd":@(fixOnEnd),
            @"fixOnStationaryState":@(fixOnStationaryState),
        };
        operationID = mk_sb_taskReadMotionModeEventsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //读取运动开始定位上报次数
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"number":number,
        };
        operationID = mk_sb_taskReadMotionModeNumberOfFixOnStartOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //读取运动开始定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadMotionModePosStrategyOnStartOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //读取运动中定位间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_sb_taskReadMotionModeReportIntervalInTripOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //读取运动中定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadMotionModePosStrategyInTripOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //读取运动结束判断时间
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"time":time,
        };
        operationID = mk_sb_taskReadMotionModeTripEndTimeoutOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //读取运动结束判断时间
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"number":number,
        };
        operationID = mk_sb_taskReadMotionModeNumberOfFixOnEndOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //读取运动结束定位间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadMotionModeReportIntervalOnEndOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //读取运动结束定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadMotionModePosStrategyOnEndOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //读取静止状态下的定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadMotionModePosStrategyOnStationaryOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //读取静止状态下的定位间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadMotionModeReportIntervalOnStationaryOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //读取蓝牙扫描phy选择
        NSString *phyType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"phyType":phyType};
        operationID = mk_sb_taskReadScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //读取RSSI过滤规则
        resultDic = @{
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[[MKBLEBaseSDKAdopter signedHexTurnString:content] integerValue]],
        };
        operationID = mk_sb_taskReadRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //读取广播内容过滤逻辑
        resultDic = @{
            @"relationship":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //读取精准过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //读取反向过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //读取MAC过滤列表
        NSArray *macList = [MKSBSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"macList":(MKValidArray(macList) ? macList : @[]),
        };
        operationID = mk_sb_taskReadFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //读取精准过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //读取反向过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"59"]) {
        //读取过滤设备类型开关
        BOOL iBeacon = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL uid = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL url = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL tlm = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        BOOL bxp_beacon = ([[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"]);
        BOOL bxp_deviceInfo = ([[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"]);
        BOOL bxp_acc = ([[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"]);
        BOOL bxp_th = ([[content substringWithRange:NSMakeRange(14, 2)] isEqualToString:@"01"]);
        BOOL bxp_button = ([[content substringWithRange:NSMakeRange(16, 2)] isEqualToString:@"01"]);
        BOOL bxp_tag = ([[content substringWithRange:NSMakeRange(18, 2)] isEqualToString:@"01"]);
        BOOL pir = ([[content substringWithRange:NSMakeRange(20, 2)] isEqualToString:@"01"]);
        BOOL other = ([[content substringWithRange:NSMakeRange(22, 2)] isEqualToString:@"01"]);
        resultDic = @{
            @"iBeacon":@(iBeacon),
            @"uid":@(uid),
            @"url":@(url),
            @"tlm":@(tlm),
            @"bxp_beacon":@(bxp_beacon),
            @"bxp_deviceInfo":@(bxp_deviceInfo),
            @"bxp_acc":@(bxp_acc),
            @"bxp_th":@(bxp_th),
            @"bxp_button":@(bxp_button),
            @"bxp_tag":@(bxp_tag),
            @"pir":@(pir),
            @"other":@(other)
        };
        operationID = mk_sb_taskReadFilterTypeStatusOperation;
    }else if ([cmd isEqualToString:@"5a"]) {
        //读取iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //读取iBeacon类型过滤的Major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_sb_taskReadFilterByBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"5c"]) {
        //读取iBeacon类型过滤的Minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_sb_taskReadFilterByBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"5d"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_sb_taskReadFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"5e"]) {
        //读取UID类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"5f"]) {
        //读取UID类型过滤的Namespace ID
        resultDic = @{
            @"namespaceID":content,
        };
        operationID = mk_sb_taskReadFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //读取UID类型过滤的Instance ID
        resultDic = @{
            @"instanceID":content,
        };
        operationID = mk_sb_taskReadFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //读取URL类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //读取URL类型过滤内容
        NSString *url = @"";
        if (content.length > 0) {
            NSData *urlData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            url = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"url":(MKValidStr(url) ? url : @""),
        };
        operationID = mk_sb_taskReadFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //读取TLM类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //读取TLM过滤数据类型
        NSString *version = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"version":version
        };
        operationID = mk_sb_taskReadFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //读取BXP-iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //读取BXP-iBeacon类型过滤的Major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_sb_taskReadFilterByBXPBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"67"]) {
        //读取iBeacon类型过滤的Minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_sb_taskReadFilterByBXPBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_sb_taskReadFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //读取BXP-Button过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadBXPButtonFilterStatusOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //读取BXP-Button报警过滤开关
        BOOL singlePresse = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL doublePresse = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL longPresse = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL abnormal = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        resultDic = @{
            @"singlePresse":@(singlePresse),
            @"doublePresse":@(doublePresse),
            @"longPresse":@(longPresse),
            @"abnormal":@(abnormal),
        };
        operationID = mk_sb_taskReadBXPButtonAlarmFilterStatusOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //读取BXP-TagID类型开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6f"]) {
        //读取BXP-TagID类型精准过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //读取读取BXP-TagID类型反向过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //读取BXP-TagID过滤规则
        NSArray *tagIDList = [MKSBSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"tagIDList":(MKValidArray(tagIDList) ? tagIDList : @[]),
        };
        operationID = mk_sb_taskReadFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //读取PIR过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByPirStatusOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //读取PIR设备过滤sensor_detection_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_sb_taskReadFilterByPirDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //读取PIR设备过滤sensor_sensitivity
        NSString *sensitivity = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"sensitivity":sensitivity,
        };
        operationID = mk_sb_taskReadFilterByPirSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //读取PIR设备过滤door_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_sb_taskReadFilterByPirDoorStatusOperation;
    }else if ([cmd isEqualToString:@"76"]) {
        //读取PIR设备过滤delay_response_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_sb_taskReadFilterByPirDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"77"]) {
        //读取PIR设备Major过滤范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_sb_taskReadFilterByPirMajorRangeOperation;
    }else if ([cmd isEqualToString:@"78"]) {
        //读取PIR设备Minor过滤范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_sb_taskReadFilterByPirMinorRangeOperation;
    }else if ([cmd isEqualToString:@"79"]) {
        //读取Other过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //读取Other过滤条件的逻辑关系
        NSString *relationship = [MKSBSDKDataAdopter parseOtherRelationship:content];
        resultDic = @{
            @"relationship":relationship,
        };
        operationID = mk_sb_taskReadFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //读取Other的过滤条件列表
        NSArray *conditionList = [MKSBSDKDataAdopter parseOtherFilterConditionList:content];
        resultDic = @{
            @"conditionList":conditionList,
        };
        operationID = mk_sb_taskReadFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //读取WIFI定位数据格式
        resultDic = @{
            @"dataType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadWifiDataTypeOperation;
    }else if ([cmd isEqualToString:@"7e"]) {
        //读取WIFI定位机制
        resultDic = @{
            @"mechanism":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadWifiFixMechanismOperation;
    }else if ([cmd isEqualToString:@"7f"]) {
        //读取WIFI定位超时时间
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadWifiPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //读取WIFI定位成功BSSID数量
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadWifiNumberOfBSSIDOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //读取蓝牙定位机制选择
        resultDic = @{
            @"priority":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadBluetoothFixMechanismOperation;
    }else if ([cmd isEqualToString:@"82"]) {
        //读取蓝牙定位超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadBlePositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //读取蓝牙定位MAC数量
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadBlePositioningNumberOfMacOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //读取GPS选择
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadGPSPositioningOperation;
    }else if ([cmd isEqualToString:@"8f"]) {
        //读取离线定位功能开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_sb_taskReadOfflineFixStatusOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //读取GPS极限上传模式
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadLCGpsExtrmeModeStatusOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //读取GPS定位超时时间(L76C)
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLCPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //读取GPS定位超时时间(L76C)
        resultDic = @{
            @"pdop":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLCPDOPOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //读取GPS定位数据格式(LR1110)
        resultDic = @{
            @"dataType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLRGPSDataTypeOperation;
    }else if ([cmd isEqualToString:@"89"]) {
        //读取GPS定位超时时间(LR1110)
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLRPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"8a"]) {
        //读取GPS定位超时时间(LR1110)
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLRStatelliteThresholdOperation;
    }else if ([cmd isEqualToString:@"8b"]) {
        //读取定位系统(LR1110)
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLRPositioningSystemOperation;
    }else if ([cmd isEqualToString:@"8c"]) {
        //读取定位方式选择(LR1110)
        BOOL isOn = ([content isEqualToString:@"00"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadLRAutonomousAidingOperation;
    }else if ([cmd isEqualToString:@"8d"]) {
        //读取定位方式选择(LR1110)
        NSNumber *latitude = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(0, 8)]];
        NSNumber *longitude = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(8, 8)]];
        resultDic = @{
            @"latitude":[NSString stringWithFormat:@"%@",latitude],
            @"longitude":[NSString stringWithFormat:@"%@",longitude]
        };
        operationID = mk_sb_taskReadLRLatitudeLongitudeOperation;
    }else if ([cmd isEqualToString:@"8e"]) {
        //读取星历开始更新事件开关(LR1110)
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL start = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL end = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"start":@(start),
            @"end":@(end)
        };
        operationID = mk_sb_taskReadLRNotifyOnEphemerisStatusOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_sb_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_sb_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_sb_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_sb_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_sb_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_sb_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"99"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_sb_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"9a"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_sb_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_sb_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //读取ADR_ACK_LIMIT
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"9e"]) {
        //读取ADR_ACK_DELAY
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"9f"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //读取设备信息包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_sb_taskReadDeviceInfoPayloadDataOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //读取心跳数据包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_sb_taskReadHeartbeatPayloadDataOperation;
    }else if ([cmd isEqualToString:@"a3"]) {
        //读取低电状态数据包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_sb_taskReadLowPowerPayloadDataOperation;
    }else if ([cmd isEqualToString:@"a4"]) {
        //读取事件信息包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_sb_taskReadEventPayloadDataOperation;
    }else if ([cmd isEqualToString:@"a5"]) {
        //读取GPS极限定位数据包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_sb_taskReadGPSLimitPayloadDataOperation;
    }else if ([cmd isEqualToString:@"a6"]) {
        //读取定位数据包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_sb_taskReadPositioningPayloadDataOperation;
    }else if ([cmd isEqualToString:@"b0"]) {
        //读取下行请求定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadDownlinkPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"b1"]) {
        //读取闲置功能使能
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL detection = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL start = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL end = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"detection":@(detection),
            @"start":@(start),
            @"end":@(end)
        };
        operationID = mk_sb_taskReadManDownDetectionOperation;
    }else if ([cmd isEqualToString:@"b2"]) {
        //读取下行请求定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadManDownPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"b3"]) {
        //读取ManDown检测超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadManDownDetectionTimeoutOperation;
    }else if ([cmd isEqualToString:@"b4"]) {
        //读取ManDown定位数据上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadManDownReportIntervalOperation;
    }else if ([cmd isEqualToString:@"b5"]) {
        //读取报警类型选择
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadAlarmTypeOperation;
    }else if ([cmd isEqualToString:@"b6"]) {
        //读取退出报警按键时长
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadExitAlarmTypeTimeOperation;
    }else if ([cmd isEqualToString:@"b7"]) {
        //读取Alert报警触发按键模式
        resultDic = @{
            @"mode":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadAlertAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"b8"]) {
        //读取Alert报警定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadAlertAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"b9"]) {
        //读取Alert报警事件通知
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL start = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL end = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"start":@(start),
            @"end":@(end)
        };
        operationID = mk_sb_taskReadAlertAlarmNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"ba"]) {
        //读取SOS报警触发按键模式
        resultDic = @{
            @"mode":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadSosAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"bb"]) {
        //读取SOS报警定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_sb_taskReadSosAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"bc"]) {
        //读取SOS报警数据上报时间间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_sb_taskReadSosAlarmReportIntervalOperation;
    }else if ([cmd isEqualToString:@"bd"]) {
        //读取SOS报警事件通知
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL start = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL end = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"start":@(start),
            @"end":@(end)
        };
        operationID = mk_sb_taskReadSosAlarmNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"d0"]) {
        //读取室外蓝牙定位上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadOutdoorBLEReportIntervalOperation;
    }else if ([cmd isEqualToString:@"d1"]) {
        //读取室外GPS定位上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_sb_taskReadOutdoorGPSReportIntervalOperation;
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_sb_taskOperationID operationID = mk_sb_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //
    }else if ([cmd isEqualToString:@"10"]) {
        //关机
        operationID = mk_sb_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //配置LoRaWAN 入网
        operationID = mk_sb_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //恢复出厂设置
        operationID = mk_sb_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"13"]) {
        //配置时间戳
        operationID = mk_sb_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"14"]) {
        //配置时区
        operationID = mk_sb_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"1b"]) {
        //配置工作模式
        operationID = mk_sb_taskConfigWorkModeOperation;
    }else if ([cmd isEqualToString:@"1c"]) {
        //配置关机信息上报状态
        operationID = mk_sb_taskConfigShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1d"]) {
        //配置按键关机开关状态
        operationID = mk_sb_taskConfigOFFByButtonOperation;
    }else if ([cmd isEqualToString:@"1e"]) {
        //配置低电触发心跳开关状态
        operationID = mk_sb_taskConfigLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1f"]) {
        //配置低电百分比
        operationID = mk_sb_taskConfigLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //配置设备心跳间隔
        operationID = mk_sb_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //配置三轴唤醒条件
        operationID = mk_sb_taskConfigThreeAxisWakeupConditionsOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //配置运动检测判断
        operationID = mk_sb_taskConfigThreeAxisMotionParametersOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //配置蜂鸣器声效选择
        operationID = mk_sb_taskConfigBuzzerSoundTypeOperation;
    }else if ([cmd isEqualToString:@"24"]) {
        //配置马达震动强度
        operationID = mk_sb_taskConfigVibrationIntensityOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //清除马达异常状态
        operationID = mk_sb_taskResetMotorStateOperation;
    }else if ([cmd isEqualToString:@"27"]) {
        //配置指示灯开关状态
        operationID = mk_sb_taskConfigIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"29"]) {
        //清除电池电量数据
        operationID = mk_sb_taskBatteryResetOperation;
    }else if ([cmd isEqualToString:@"2b"]) {
        //配置充电自动开机开关
        operationID = mk_sb_taskConfigAutoPowerOnOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //配置是否需要连接密码
        operationID = mk_sb_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //配置连接密码
        operationID = mk_sb_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //配置蓝牙广播超时时间
        operationID = mk_sb_taskConfigBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //配置蓝牙TX Power
        operationID = mk_sb_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //配置蓝牙广播名称
        operationID = mk_sb_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //配置蓝牙广播间隔
        operationID = mk_sb_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"3f"]) {
        //配置待机模式定位策略
        operationID = mk_sb_taskConfigStandbyModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //设置定期模式定位策略
        operationID = mk_sb_taskConfigPeriodicModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //设置定期模式上报间隔
        operationID = mk_sb_taskConfigPeriodicModeReportIntervalOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //设置定时模式定位策略
        operationID = mk_sb_taskConfigTimingModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //设置定时模式时间点
        operationID = mk_sb_taskConfigTimingModeReportingTimePointOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //设置运动模式事件
        operationID = mk_sb_taskConfigMotionModeEventsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //设置运动开始定位上报次数
        operationID = mk_sb_taskConfigMotionModeNumberOfFixOnStartOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //设置运动开始定位策略
        operationID = mk_sb_taskConfigMotionModePosStrategyOnStartOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //设置运动中定位间隔
        operationID = mk_sb_taskConfigMotionModeReportIntervalInTripOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //设置运动中定位策略
        operationID = mk_sb_taskConfigMotionModePosStrategyInTripOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //设置运动结束判断时间
        operationID = mk_sb_taskConfigMotionModeTripEndTimeoutOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //设置运动结束定位次数
        operationID = mk_sb_taskConfigMotionModeNumberOfFixOnEndOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //设置运动结束定位间隔
        operationID = mk_sb_taskConfigMotionModeReportIntervalOnEndOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //设置运动结束定位策略
        operationID = mk_sb_taskConfigMotionModePosStrategyOnEndOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //配置静止状态下的定位策略
        operationID = mk_sb_taskConfigMotionModePosStrategyOnStationaryOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //配置静止状态下的定位间隔
        operationID = mk_sb_taskConfigMotionModeReportIntervalOnStationaryOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置蓝牙扫描PHY选择
        operationID = mk_sb_taskConfigScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //配置rssi过滤规则
        operationID = mk_sb_taskConfigRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //配置广播内容过滤逻辑
        operationID = mk_sb_taskConfigFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //配置精准过滤MAC开关
        operationID = mk_sb_taskConfigFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //配置反向过滤MAC开关
        operationID = mk_sb_taskConfigFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //配置MAC过滤规则
        operationID = mk_sb_taskConfigFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //配置精准过滤Adv Name开关
        operationID = mk_sb_taskConfigFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //配置反向过滤Adv Name开关
        operationID = mk_sb_taskConfigFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"5a"]) {
        //配置iBeacon类型过滤开关
        operationID = mk_sb_taskConfigFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //配置iBeacon类型过滤Major范围
        operationID = mk_sb_taskConfigFilterByBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"5c"]) {
        //配置iBeacon类型过滤Minor范围
        operationID = mk_sb_taskConfigFilterByBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"5d"]) {
        //配置iBeacon类型过滤UUID
        operationID = mk_sb_taskConfigFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"5e"]) {
        //配置UID类型过滤开关
        operationID = mk_sb_taskConfigFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"5f"]) {
        //配置UID类型过滤Namespace ID.
        operationID = mk_sb_taskConfigFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //配置UID类型过滤Instace ID.
        operationID = mk_sb_taskConfigFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //配置URL类型过滤开关
        operationID = mk_sb_taskConfigFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //配置URL类型过滤的内容
        operationID = mk_sb_taskConfigFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //配置TLM类型开关
        operationID = mk_sb_taskConfigFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //配置TLM过滤数据类型
        operationID = mk_sb_taskConfigFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //配置BXP-iBeacon类型过滤开关
        operationID = mk_sb_taskConfigFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //配置BXP-iBeacon类型过滤Major范围
        operationID = mk_sb_taskConfigFilterByBXPBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"67"]) {
        //配置BXP-iBeacon类型过滤Minor范围
        operationID = mk_sb_taskConfigFilterByBXPBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //配置BXP-iBeacon类型过滤UUID
        operationID = mk_sb_taskConfigFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"69"]) {
        //配置BXP-DeviceInfo过滤开关
        operationID = mk_sb_taskConfigFilterByBXPDeviceInfoStatusOperation;
    }else if ([cmd isEqualToString:@"6a"]) {
        //配置BeaconX Pro-ACC设备过滤开关
        operationID = mk_sb_taskConfigBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"6b"]) {
        //配置BeaconX Pro-TH设备过滤开关
        operationID = mk_sb_taskConfigBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //配置BXP-Button过滤开关
        operationID = mk_sb_taskConfigFilterByBXPButtonStatusOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //配置BXP-Button类型过滤内容
        operationID = mk_sb_taskConfigFilterByBXPButtonAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //配置BXP-TagID类型过滤开关
        operationID = mk_sb_taskConfigFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6f"]) {
        //配置BXP-TagID类型精准过滤Tag-ID开关
        operationID = mk_sb_taskConfigPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //配置BXP-TagID类型反向过滤Tag-ID开关
        operationID = mk_sb_taskConfigReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //配置BXP-TagID过滤规则
        operationID = mk_sb_taskConfigFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //配置PIR设备过滤开关
        operationID = mk_sb_taskConfigFilterByPirStatusOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //配置PIR设备过滤sensor_detection_status
        operationID = mk_sb_taskConfigFilterByPirDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //配置PIR设备过滤sensor_sensitivity
        operationID = mk_sb_taskConfigFilterByPirSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //配置PIR设备过滤door_status
        operationID = mk_sb_taskConfigFilterByPirDoorStatusOperation;
    }else if ([cmd isEqualToString:@"76"]) {
        //配置PIR设备过滤delay_response_status
        operationID = mk_sb_taskConfigFilterByPirDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"77"]) {
        //配置PIR设备Major过滤范围
        operationID = mk_sb_taskConfigFilterByPirMajorOperation;
    }else if ([cmd isEqualToString:@"78"]) {
        //配置PIR设备Minor过滤范围
        operationID = mk_sb_taskConfigFilterByPirMinorOperation;
    }else if ([cmd isEqualToString:@"79"]) {
        //配置Other过滤关系开关
        operationID = mk_sb_taskConfigFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //配置Other过滤条件逻辑关系
        operationID = mk_sb_taskConfigFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //配置Other过滤条件列表
        operationID = mk_sb_taskConfigFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //配置WIFI定位数据格式
        operationID = mk_sb_taskConfigWifiDataTypeOperation;
    }else if ([cmd isEqualToString:@"7e"]) {
        //配置wifi定位机制
        operationID = mk_sb_taskConfigWifiFixMechanismOperation;
    }else if ([cmd isEqualToString:@"7f"]) {
        //配置WIFI扫描超时时间
        operationID = mk_sb_taskConfigWifiPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //配置WIFI定位成功BSSID数量
        operationID = mk_sb_taskConfigWifiNumberOfBSSIDOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //配置蓝牙定位机制
        operationID = mk_sb_taskConfigBluetoothFixMechanismOperation;
    }else if ([cmd isEqualToString:@"82"]) {
        //配置蓝牙定位超时时间
        operationID = mk_sb_taskConfigBlePositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //配置蓝牙定位mac数量
        operationID = mk_sb_taskConfigBlePositioningNumberOfMacOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //配置GPS选择
        operationID = mk_sb_taskConfigGPSPositioningOperation;
    }else if ([cmd isEqualToString:@"8f"]) {
        //配置离线定位功能开关
        operationID = mk_sb_taskConfigOfflineFixOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //配置GPS极限上传模式(L76C)
        operationID = mk_sb_taskConfigLCGpsExtrmeModeStatusOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //配置GPS定位超时时间(L76C)
        operationID = mk_sb_taskConfigLCPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //配置PDOP(L76C)
        operationID = mk_sb_taskConfigLCPDOPOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //配置GPS定位数据格式(LR1110)
        operationID = mk_sb_taskConfigLRGPSDataTypeOperation;
    }else if ([cmd isEqualToString:@"89"]) {
        //配置GPS定位超时时间(LR1110)
        operationID = mk_sb_taskConfigLRPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"8a"]) {
        //配置GPS搜星数量(LR1110)
        operationID = mk_sb_taskConfigLRStatelliteThresholdOperation;
    }else if ([cmd isEqualToString:@"8b"]) {
        //配置GPS定位星座(LR1110)
        operationID = mk_sb_taskConfigLRPositioningSystemOperation;
    }else if ([cmd isEqualToString:@"8c"]) {
        //配置定位方式选择(LR1110)
        operationID = mk_sb_taskConfigLRAutonomousAidingOperation;
    }else if ([cmd isEqualToString:@"8d"]) {
        //配置辅助定位经纬度(LR1110)
        operationID = mk_sb_taskConfigLRLatitudeLongitudeOperation;
    }else if ([cmd isEqualToString:@"8e"]) {
        //配置星历开始更新事件开关(LR1110)
        operationID = mk_sb_taskConfigLRNotifyOnEphemerisStatusOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //配置LoRaWAN频段
        operationID = mk_sb_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //配置LoRaWAN入网类型
        operationID = mk_sb_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_sb_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_sb_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_sb_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_sb_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_sb_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_sb_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"99"]) {
        //配置LoRaWAN CH
        operationID = mk_sb_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"9a"]) {
        //配置LoRaWAN DR
        operationID = mk_sb_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_sb_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_sb_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //配置ADR_ACK_LIMIT
        operationID = mk_sb_taskConfigLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"9e"]) {
        //配置ADR_ACK_DELAY
        operationID = mk_sb_taskConfigLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"9f"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_sb_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_sb_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //配置设备信息包上行参数
        operationID = mk_sb_taskConfigDeviceInfoPayloadOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //配置心跳数据包上行参数
        operationID = mk_sb_taskConfigHeartbeatPayloadOperation;
    }else if ([cmd isEqualToString:@"a3"]) {
        //配置低电状态数据包上行参数
        operationID = mk_sb_taskConfigLowPowerPayloadOperation;
    }else if ([cmd isEqualToString:@"a4"]) {
        //配置事件信息包上行参数
        operationID = mk_sb_taskConfigEventPayloadOperation;
    }else if ([cmd isEqualToString:@"a5"]) {
        //配置GPS极限定位数据包上行参数
        operationID = mk_sb_taskConfigGPSLimitPayloadOperation;
    }else if ([cmd isEqualToString:@"a6"]) {
        //配置定位数据包上行参数
        operationID = mk_sb_taskConfigPositioningPayloadOperation;
    }else if ([cmd isEqualToString:@"b0"]) {
        //配置下行请求定位策略
        operationID = mk_sb_taskConfigDownlinkPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"b1"]) {
        //配置闲置功能使能
        operationID = mk_sb_taskConfigManDownDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"b2"]) {
        //配置ManDown定位策略
        operationID = mk_sb_taskConfigManDownPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"b3"]) {
        //配置ManDown检测超时时间
        operationID = mk_sb_taskConfigManDownDetectionTimeoutOperation;
    }else if ([cmd isEqualToString:@"b4"]) {
        //配置ManDown定位数据上报间隔
        operationID = mk_sb_taskConfigManDownReportIntervalOperation;
    }else if ([cmd isEqualToString:@"b5"]) {
        //配置报警类型选择
        operationID = mk_sb_taskConfigAlarmTypeOperation;
    }else if ([cmd isEqualToString:@"b6"]) {
        //配置退出报警按键
        operationID = mk_sb_taskConfigExitAlarmTypeTimeOperation;
    }else if ([cmd isEqualToString:@"b7"]) {
        //配置Alert报警触发按键模式
        operationID = mk_sb_taskConfigAlertAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"b8"]) {
        //配置Alert报警定位策略
        operationID = mk_sb_taskConfigAlertAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"b9"]) {
        //配置Alert报警事件通知
        operationID = mk_sb_taskConfigAlertAlarmNotifyEventOperation;
    }else if ([cmd isEqualToString:@"ba"]) {
        //配置SOS报警触发按键模式
        operationID = mk_sb_taskConfigSosAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"bb"]) {
        //配置SOS报警定位策略
        operationID = mk_sb_taskConfigSosAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"bc"]) {
        //配置SOS报警定位数据上报间隔
        operationID = mk_sb_taskConfigSosAlarmReportIntervalOperation;
    }else if ([cmd isEqualToString:@"bd"]) {
        //配置SOS报警事件通知
        operationID = mk_sb_taskConfigSosAlarmNotifyEventOperation;
    }else if ([cmd isEqualToString:@"c0"]) {
        //读取多少天本地存储的数据
        operationID = mk_sb_taskReadNumberOfDaysStoredDataOperation;
    }else if ([cmd isEqualToString:@"c1"]) {
        //清除存储的所有数据
        operationID = mk_sb_taskClearAllDatasOperation;
    }else if ([cmd isEqualToString:@"c2"]) {
        //暂停/恢复数据传输
        operationID = mk_sb_taskPauseSendLocalDataOperation;
    }else if ([cmd isEqualToString:@"d0"]) {
        //配置室外蓝牙定位上报间隔
        operationID = mk_sb_taskConfigOutdoorBLEReportIntervalOperation;
    }else if ([cmd isEqualToString:@"d1"]) {
        //配置室外GPS定位上报间隔
        operationID = mk_sb_taskConfigOutdoorGPSReportIntervalOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_sb_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
