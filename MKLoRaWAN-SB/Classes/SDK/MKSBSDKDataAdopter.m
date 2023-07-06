//
//  MKSBSDKDataAdopter.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKSBSDKDataAdopter

+ (NSString *)lorawanRegionString:(mk_sb_loraWanRegion)region {
    switch (region) {
        case mk_sb_loraWanRegionAS923:
            return @"00";
        case mk_sb_loraWanRegionAU915:
            return @"01";
        case mk_sb_loraWanRegionCN470:
            return @"02";
        case mk_sb_loraWanRegionCN779:
            return @"03";
        case mk_sb_loraWanRegionEU433:
            return @"04";
        case mk_sb_loraWanRegionEU868:
            return @"05";
        case mk_sb_loraWanRegionKR920:
            return @"06";
        case mk_sb_loraWanRegionIN865:
            return @"07";
        case mk_sb_loraWanRegionUS915:
            return @"08";
        case mk_sb_loraWanRegionRU864:
            return @"09";
    }
}

+ (NSString *)fetchTxPower:(mk_sb_txPower)txPower {
    switch (txPower) {
        case mk_sb_txPower8dBm:
            return @"08";
        case mk_sb_txPower7dBm:
            return @"07";
        case mk_sb_txPower6dBm:
            return @"06";
        case mk_sb_txPower5dBm:
            return @"05";
        case mk_sb_txPower4dBm:
            return @"04";
        case mk_sb_txPower3dBm:
            return @"03";
        case mk_sb_txPower2dBm:
            return @"02";
        case mk_sb_txPower0dBm:
            return @"00";
        case mk_sb_txPowerNeg4dBm:
            return @"fc";
        case mk_sb_txPowerNeg8dBm:
            return @"f8";
        case mk_sb_txPowerNeg12dBm:
            return @"f4";
        case mk_sb_txPowerNeg16dBm:
            return @"f0";
        case mk_sb_txPowerNeg20dBm:
            return @"ec";
        case mk_sb_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (NSString *)fetchTxPowerValueString:(NSString *)content {
    if ([content isEqualToString:@"08"]) {
        return @"8dBm";
    }
    if ([content isEqualToString:@"07"]) {
        return @"7dBm";
    }
    if ([content isEqualToString:@"06"]) {
        return @"6dBm";
    }
    if ([content isEqualToString:@"05"]) {
        return @"5dBm";
    }
    if ([content isEqualToString:@"04"]) {
        return @"4dBm";
    }
    if ([content isEqualToString:@"03"]) {
        return @"3dBm";
    }
    if ([content isEqualToString:@"02"]) {
        return @"2dBm";
    }
    if ([content isEqualToString:@"00"]) {
        return @"0dBm";
    }
    if ([content isEqualToString:@"fc"]) {
        return @"-4dBm";
    }
    if ([content isEqualToString:@"f8"]) {
        return @"-8dBm";
    }
    if ([content isEqualToString:@"f4"]) {
        return @"-12dBm";
    }
    if ([content isEqualToString:@"f0"]) {
        return @"-16dBm";
    }
    if ([content isEqualToString:@"ec"]) {
        return @"-20dBm";
    }
    if ([content isEqualToString:@"d8"]) {
        return @"-40dBm";
    }
    return @"0dBm";
}

+ (NSString *)fetchDataFormatString:(mk_sb_dataFormat)dataType {
    switch (dataType) {
        case mk_sb_dataFormat_DAS:
            return @"00";
        case mk_sb_dataFormat_Customer:
            return @"01";
    }
}

+ (NSString *)fetchPHYTypeString:(mk_sb_PHYMode)mode {
    switch (mode) {
        case mk_sb_PHYMode_BLE4:
            return @"00";
        case mk_sb_PHYMode_BLE5:
            return @"01";
        case mk_sb_PHYMode_BLE4AndBLE5:
            return @"02";
        case mk_sb_PHYMode_CodedBLE5:
            return @"03";
    }
}

+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        index += subLen * 2;
        [dataList addObject:subContent];
    }
    return dataList;
}

+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList {
    if (!MKValidArray(contentList)) {
        return @[];
    }
    NSMutableData *contentData = [[NSMutableData alloc] init];
    for (NSInteger i = 0; i < contentList.count; i ++) {
        NSData *tempData = contentList[i];
        if (![tempData isKindOfClass:NSData.class]) {
            return @[];
        }
        [contentData appendData:tempData];
    }
    if (!MKValidData(contentData)) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *advNameList = [NSMutableArray array];
    for (NSInteger i = 0; i < contentData.length; i ++) {
        if (index >= contentData.length) {
            break;
        }
        NSData *lenData = [contentData subdataWithRange:NSMakeRange(index, 1)];
        NSString *lenString = [MKBLEBaseSDKAdopter hexStringFromData:lenData];
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:lenString range:NSMakeRange(0, lenString.length)];
        NSData *subData = [contentData subdataWithRange:NSMakeRange(index + 1, subLen)];
        NSString *advName = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];
        if (advName) {
            [advNameList addObject:advName];
        }
        index += (subLen + 1);
    }
    return advNameList;
}

+ (NSString *)parseFilterUrlContent:(NSArray <NSData *>*)contentList {
    if (!MKValidArray(contentList)) {
        return @"";
    }
    NSMutableData *contentData = [[NSMutableData alloc] init];
    for (NSInteger i = 0; i < contentList.count; i ++) {
        NSData *tempData = contentList[i];
        if (![tempData isKindOfClass:NSData.class]) {
            return @[];
        }
        [contentData appendData:tempData];
    }
    if (!MKValidData(contentData)) {
        return @"";
    }
    NSString *url = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    return (MKValidStr(url) ? url : @"");
}

+ (NSString *)parseOtherRelationship:(NSString *)other {
    if (!MKValidStr(other)) {
        return @"0";
    }
    if ([other isEqualToString:@"00"]) {
        //A
        return @"0";
    }
    if ([other isEqualToString:@"01"]) {
        //A&B
        return @"1";
    }
    if ([other isEqualToString:@"02"]) {
        //A|B
        return @"2";
    }
    if ([other isEqualToString:@"03"]) {
        //A & B & C
        return @"3";
    }
    if ([other isEqualToString:@"04"]) {
        //(A & B) | C
        return @"4";
    }
    if ([other isEqualToString:@"05"]) {
        //A | B | C
        return @"5";
    }
    return @"0";
}

+ (NSArray *)parseOtherFilterConditionList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        
        NSString *type = [subContent substringWithRange:NSMakeRange(0, 2)];
        NSString *start = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(2, 2)];
        NSString *end = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(4, 2)];
        NSString *data = [subContent substringFromIndex:6];
        
        NSDictionary *dataDic = @{
            @"type":type,
            @"start":start,
            @"end":end,
            @"data":(data ? data : @""),
        };
        
        index += subLen * 2;
        [dataList addObject:dataDic];
    }
    return dataList;
}

+ (NSString *)parseOtherRelationshipToCmd:(mk_sb_filterByOther)relationship {
    switch (relationship) {
        case mk_sb_filterByOther_A:
            return @"00";
        case mk_sb_filterByOther_AB:
            return @"01";
        case mk_sb_filterByOther_AOrB:
            return @"02";
        case mk_sb_filterByOther_ABC:
            return @"03";
        case mk_sb_filterByOther_ABOrC:
            return @"04";
        case mk_sb_filterByOther_AOrBOrC:
            return @"05";
    }
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_sb_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_sb_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!MKValidStr(protocol.dataType)) {
        //新需求，DataType为空等同于00，
        protocol.dataType = @"00";
    }
    if ([protocol.dataType isEqualToString:@"00"]) {
        protocol.minIndex = 0;
        protocol.maxIndex = 0;
    }
    if (!MKValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.dataType]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 29 || protocol.maxIndex < 0 || protocol.maxIndex > 29) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex != 0) {
        return NO;
    }
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

+ (NSString *)fetchDeviceModeValue:(mk_sb_deviceMode)deviceMode {
    switch (deviceMode) {
        case mk_sb_deviceMode_standbyMode:
            return @"00";
        case mk_sb_deviceMode_timingMode:
            return @"01";
        case mk_sb_deviceMode_periodicMode:
            return @"02";
        case mk_sb_deviceMode_motionMode:
            return @"03";
    }
}

+ (NSString *)fetchPositioningStrategyCommand:(mk_sb_positioningStrategy)strategy {
    switch (strategy) {
        case mk_sb_positioningStrategy_wifi:
            return @"00";
        case mk_sb_positioningStrategy_ble:
            return @"01";
        case mk_sb_positioningStrategy_gps:
            return @"02";
        case mk_sb_positioningStrategy_wifiAndGps:
            return @"03";
        case mk_sb_positioningStrategy_bleAndGps:
            return @"04";
        case mk_sb_positioningStrategy_wifiAndBle:
            return @"05";
        case mk_sb_positioningStrategy_wifiAndBleAndGps:
            return @"06";
    }
}

+ (NSString *)fetchTimingModeReportingTimePoint:(NSArray <mk_sb_timingModeReportingTimePointProtocol>*)dataList {
    if (dataList.count > 10) {
        return @"";
    }
    if (!MKValidArray(dataList)) {
        return @"00";
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:dataList.count byteLen:1];
    NSString *resultString = len;
    for (NSInteger i = 0; i < dataList.count; i ++) {
        id <mk_sb_timingModeReportingTimePointProtocol>data = dataList[i];
        if (data.hour < 0 || data.hour > 23 || data.minuteGear < 0 || data.minuteGear > 3) {
            return @"";
        }
        NSInteger timeValue = 0;
        if (data.hour == 0 && data.minuteGear == 0) {
            timeValue = 96;
        }else {
            timeValue = 4 * data.hour + data.minuteGear;
        }
        NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:timeValue byteLen:1];
        resultString = [resultString stringByAppendingString:timeString];
    }
    return resultString;
}

+ (NSArray <NSDictionary *>*)parseTimingModeReportingTimePoint:(NSString *)content {
    if (!MKValidStr(content) || content.length < 2) {
        return @[];
    }
    if ([content isEqualToString:@"00"]) {
        return @[];
    }
    NSInteger totalByte = content.length / 2;
    NSMutableArray *tempList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalByte; i ++) {
        NSString *tempString = [content substringWithRange:NSMakeRange(i * 2, 2)];
        NSInteger tempValue = [MKBLEBaseSDKAdopter getDecimalWithHex:tempString range:NSMakeRange(0, tempString.length)];
        NSInteger hour = 0;
        NSInteger minuteGear = 0;
        if (tempValue < 96) {
            //如果是96，表示00:00
            hour = tempValue / 4;
            minuteGear = tempValue % 4;
        }
        [tempList addObject:@{
            @"hour":@(hour),
            @"minuteGear":@(minuteGear),
        }];
    }
    
    return tempList;
}

+ (NSDictionary *)fetchIndicatorSettings:(NSString *)content {
    NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
    NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
    BOOL deviceState = [[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    BOOL LowPower = [[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
    BOOL charging = [[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
    BOOL fullCharge = [[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
    BOOL bluetoothConnection = [[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
    BOOL networkCheck = [[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
    BOOL inFix = [[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
    BOOL fixSuccessful = [[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
    BOOL failToFix = [[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    return @{
        @"deviceState":@(deviceState),
        @"lowPower":@(LowPower),
        @"charging":@(charging),
        @"fullCharge":@(fullCharge),
        @"bluetoothConnection":@(bluetoothConnection),
        @"networkCheck":@(networkCheck),
        @"inFix":@(inFix),
        @"fixSuccessful":@(fixSuccessful),
        @"failToFix":@(failToFix),
    };
}

+ (NSString *)parseIndicatorSettingsCommand:(id <mk_sb_indicatorSettingsProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_sb_indicatorSettingsProtocol)]) {
        return @"";
    }
    NSString *deviceState = (protocol.deviceState ? @"1" : @"0");
    NSString *lowPower = (protocol.lowPower ? @"1" : @"0");
    NSString *charging = (protocol.charging ? @"1" : @"0");
    NSString *fullCharge = (protocol.fullCharge ? @"1" : @"0");
    NSString *bluetoothConnection = (protocol.bluetoothConnection ? @"1" : @"0");
    NSString *networkCheck = (protocol.networkCheck ? @"1" : @"0");
    NSString *inFix = (protocol.inFix ? @"1" : @"0");
    NSString *fixSuccessful = (protocol.fixSuccessful ? @"1" : @"0");
    NSString *failToFix = (protocol.failToFix ? @"1" : @"0");
    
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",fixSuccessful,inFix,networkCheck,bluetoothConnection,fullCharge,charging,lowPower,deviceState];
    NSString *lowHex = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hightString = [NSString stringWithFormat:@"%@%@",@"0000011",failToFix];
    NSString *highHex = [MKBLEBaseSDKAdopter getHexByBinary:hightString];
    
    
    return [highHex stringByAppendingString:lowHex];
}

+ (NSString *)fetchLRPositioningSystemString:(mk_sb_positioningSystem)system {
    switch (system) {
        case mk_sb_positioningSystem_GPS:
            return @"00";
        case mk_sb_positioningSystem_Beidou:
            return @"01";
        case mk_sb_positioningSystem_GPSAndBeidou:
            return @"02";
    }
}

+ (NSString *)fetchBluetoothFixMechanismString:(mk_sb_bluetoothFixMechanism)priority {
    switch (priority) {
        case mk_sb_bluetoothFixMechanism_timePriority:
            return @"00";
        case mk_sb_bluetoothFixMechanism_rssiPriority:
            return @"01";
    }
}

@end
