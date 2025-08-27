#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKSBCentralManager

typedef NS_ENUM(NSInteger, mk_sb_centralConnectStatus) {
    mk_sb_centralConnectStatusUnknow,                                           //未知状态
    mk_sb_centralConnectStatusConnecting,                                       //正在连接
    mk_sb_centralConnectStatusConnected,                                        //连接成功
    mk_sb_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_sb_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_sb_centralManagerStatus) {
    mk_sb_centralManagerStatusUnable,                           //不可用
    mk_sb_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_sb_deviceMode) {
    mk_sb_deviceMode_standbyMode,         //Standby mode
    mk_sb_deviceMode_timingMode,          //Timing mode
    mk_sb_deviceMode_periodicMode,        //Periodic mode
    mk_sb_deviceMode_motionMode,          //Motion Mode
};

typedef NS_ENUM(NSInteger, mk_sb_alarmType) {
    mk_sb_alarmType_no,
    mk_sb_alarmType_alert,
    mk_sb_alarmType_sos
};

typedef NS_ENUM(NSInteger, mk_sb_alertAlarmTriggerMode) {
    mk_sb_alertAlarmTriggerMode_singleClick,
    mk_sb_alertAlarmTriggerMode_doubleClick,
    mk_sb_alertAlarmTriggerMode_longPressOneSecond,
    mk_sb_alertAlarmTriggerMode_longPressTwoSeconds,
    mk_sb_alertAlarmTriggerMode_longPressThreeSeconds
};

typedef NS_ENUM(NSInteger, mk_sb_lowPowerPrompt) {
    mk_sb_lowPowerPrompt_tenPercent,
    mk_sb_lowPowerPrompt_twentyPercent,
    mk_sb_lowPowerPrompt_thirtyPercent,
    mk_sb_lowPowerPrompt_fortyPercent,
    mk_sb_lowPowerPrompt_fiftyPercent,
    mk_sb_lowPowerPrompt_sixtyPercent,
};

typedef NS_ENUM(NSInteger, mk_sb_buzzerSoundType) {
    mk_sb_buzzerSoundType_no,
    mk_sb_buzzerSoundType_alarm,
    mk_sb_buzzerSoundType_normal,
};

typedef NS_ENUM(NSInteger, mk_sb_vibrationIntensity) {
    mk_sb_vibrationIntensity_no,
    mk_sb_vibrationIntensity_low,
    mk_sb_vibrationIntensity_medium,
    mk_sb_vibrationIntensity_high,
};

typedef NS_ENUM(NSInteger, mk_sb_positioningStrategy) {
    mk_sb_positioningStrategy_wifi,
    mk_sb_positioningStrategy_ble,
    mk_sb_positioningStrategy_gps,
    mk_sb_positioningStrategy_wifiAndGps,
    mk_sb_positioningStrategy_bleAndGps,
    mk_sb_positioningStrategy_wifiAndBle,
    mk_sb_positioningStrategy_wifiAndBleAndGps,
    mk_sb_positioningStrategy_BleGps,
};

typedef NS_ENUM(NSInteger, mk_sb_filterRelationship) {
    mk_sb_filterRelationship_null,
    mk_sb_filterRelationship_mac,
    mk_sb_filterRelationship_advName,
    mk_sb_filterRelationship_rawData,
    mk_sb_filterRelationship_advNameAndRawData,
    mk_sb_filterRelationship_macAndadvNameAndRawData,
    mk_sb_filterRelationship_advNameOrRawData,
};

typedef NS_ENUM(NSInteger, mk_sb_filterByTLMVersion) {
    mk_sb_filterByTLMVersion_null,             //Do not filter data.
    mk_sb_filterByTLMVersion_0,                //Unencrypted TLM data.
    mk_sb_filterByTLMVersion_1,                //Encrypted TLM data.
};

typedef NS_ENUM(NSInteger, mk_sb_filterByOther) {
    mk_sb_filterByOther_A,                 //Filter by A condition.
    mk_sb_filterByOther_AB,                //Filter by A & B condition.
    mk_sb_filterByOther_AOrB,              //Filter by A | B condition.
    mk_sb_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_sb_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_sb_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};

typedef NS_ENUM(NSInteger, mk_sb_dataFormat) {
    mk_sb_dataFormat_DAS,
    mk_sb_dataFormat_Customer,
};

typedef NS_ENUM(NSInteger, mk_sb_wifiFixMechanism) {
    mk_sb_wifiFixMechanism_timePriority,
    mk_sb_wifiFixMechanism_rssiPriority,
};

typedef NS_ENUM(NSInteger, mk_sb_detectionStatus) {
    mk_sb_detectionStatus_noMotionDetected,
    mk_sb_detectionStatus_motionDetected,
    mk_sb_detectionStatus_all
};

typedef NS_ENUM(NSInteger, mk_sb_sensorSensitivity) {
    mk_sb_sensorSensitivity_low,
    mk_sb_sensorSensitivity_medium,
    mk_sb_sensorSensitivity_high,
    mk_sb_sensorSensitivity_all
};

typedef NS_ENUM(NSInteger, mk_sb_doorStatus) {
    mk_sb_doorStatus_close,
    mk_sb_doorStatus_open,
    mk_sb_doorStatus_all
};

typedef NS_ENUM(NSInteger, mk_sb_delayResponseStatus) {
    mk_sb_delayResponseStatus_low,
    mk_sb_delayResponseStatus_medium,
    mk_sb_delayResponseStatus_high,
    mk_sb_delayResponseStatus_all
};

typedef NS_ENUM(NSInteger, mk_sb_positioningSystem) {
    mk_sb_positioningSystem_GPS,
    mk_sb_positioningSystem_Beidou,
    mk_sb_positioningSystem_GPSAndBeidou
};

typedef NS_ENUM(NSInteger, mk_sb_PHYMode) {
    mk_sb_PHYMode_BLE4,                     //1M PHY (BLE 4.x)
    mk_sb_PHYMode_BLE5,                     //1M PHY (BLE 5)
    mk_sb_PHYMode_BLE4AndBLE5,              //1M PHY (BLE 4.x + BLE 5)
    mk_sb_PHYMode_CodedBLE5,                //Coded PHY(BLE 5)
};

typedef NS_ENUM(NSInteger, mk_sb_loraWanRegion) {
    mk_sb_loraWanRegionAS923,
    mk_sb_loraWanRegionAU915,
    mk_sb_loraWanRegionCN470,
    mk_sb_loraWanRegionCN779,
    mk_sb_loraWanRegionEU433,
    mk_sb_loraWanRegionEU868,
    mk_sb_loraWanRegionKR920,
    mk_sb_loraWanRegionIN865,
    mk_sb_loraWanRegionUS915,
    mk_sb_loraWanRegionRU864,
    mk_sb_loraWanRegionAS923_1,
    mk_sb_loraWanRegionAS923_2,
    mk_sb_loraWanRegionAS923_3,
    mk_sb_loraWanRegionAS923_4,
};

typedef NS_ENUM(NSInteger, mk_sb_loraWanModem) {
    mk_sb_loraWanModemABP,
    mk_sb_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_sb_loraWanMessageType) {
    mk_sb_loraWanUnconfirmMessage,          //Non-acknowledgement frame.
    mk_sb_loraWanConfirmMessage,            //Confirm the frame.
};

typedef NS_ENUM(NSInteger, mk_sb_txPower) {
    mk_sb_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_sb_txPowerNeg20dBm,   //-20dBm
    mk_sb_txPowerNeg16dBm,   //-16dBm
    mk_sb_txPowerNeg12dBm,   //-12dBm
    mk_sb_txPowerNeg8dBm,    //-8dBm
    mk_sb_txPowerNeg4dBm,    //-4dBm
    mk_sb_txPower0dBm,       //0dBm
    mk_sb_txPower2dBm,       //2dBm
    mk_sb_txPower3dBm,       //3dBm
    mk_sb_txPower4dBm,       //4dBm
    mk_sb_txPower5dBm,       //5dBm
    mk_sb_txPower6dBm,       //6dBm
    mk_sb_txPower7dBm,       //7dBm
    mk_sb_txPower8dBm,       //8dBm
};

typedef NS_ENUM(NSInteger, mk_sb_bluetoothFixMechanism) {
    mk_sb_bluetoothFixMechanism_timePriority,
    mk_sb_bluetoothFixMechanism_rssiPriority,
};

typedef NS_ENUM(NSInteger, mk_sb_gpsPositioningType) {
    mk_sb_gpsPositioningType_traditionalGpsModule,
    mk_sb_gpsPositioningType_loRaCloud
};

@protocol mk_sb_indicatorSettingsProtocol <NSObject>

@property (nonatomic, assign)BOOL deviceState;
@property (nonatomic, assign)BOOL lowPower;
@property (nonatomic, assign)BOOL charging;
@property (nonatomic, assign)BOOL fullCharge;
@property (nonatomic, assign)BOOL bluetoothConnection;
@property (nonatomic, assign)BOOL networkCheck;
@property (nonatomic, assign)BOOL inFix;
@property (nonatomic, assign)BOOL fixSuccessful;
@property (nonatomic, assign)BOOL failToFix;

@end

@protocol mk_sb_timingModeReportingTimePointProtocol <NSObject>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:15   2:30   3:45
@property (nonatomic, assign)NSInteger minuteGear;

@end

@protocol mk_sb_motionModeEventsProtocol <NSObject>

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@property (nonatomic, assign)BOOL fixOnEnd;

@property (nonatomic, assign)BOOL fixOnStationaryState;

@end

@protocol mk_sb_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. If minIndex==0,maxIndex must be 0.The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end

#pragma mark ****************************************Delegate************************************************

@protocol mk_sb_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
 @"rssi":@(-55),
 @"peripheral":peripheral,
 @"deviceName":@"LW008-MT",
 
 @"deviceType":@"00",           //@"00":LR1110  @"10":L76
 @"txPower":@(-55),             //dBm
 @"deviceState":@"0",           //0 (Standby Mode), 1 (Timing Mode), 2 (Periodic Mode), 3 (Motion Mode)
 @"lowPower":@(lowPower),       //Whether the device is in a low battery state.
 @"needPassword":@(YES),
 @"idle":@(NO),               //Whether the device is idle.
 @"move":@(YES),               //Whether there is any movement from the last lora payload to the current broadcast moment (for example, 0 means no movement, 1 means movement).
 @"voltage":@"3.333",           //V
 @"macAddress":@"AA:BB:CC:DD:EE:FF",
 @"connectable":advDic[CBAdvertisementDataIsConnectable],
 }
 */
- (void)mk_sb_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_sb_startScan;

/// Stops scanning equipment.
- (void)mk_sb_stopScan;

@end

@protocol mk_sb_storageDataDelegate <NSObject>

- (void)mk_sb_receiveStorageData:(NSString *)content;

@end


@protocol mk_sb_centralManagerLogDelegate <NSObject>

- (void)mk_sb_receiveLog:(NSString *)deviceLog;

@end
