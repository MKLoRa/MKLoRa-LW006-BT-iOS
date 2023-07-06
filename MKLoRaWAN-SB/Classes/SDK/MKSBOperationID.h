
typedef NS_ENUM(NSInteger, mk_sb_taskOperationID) {
    mk_sb_defaultTaskOperationID,
    
#pragma mark - Read
    mk_sb_taskReadDeviceModelOperation,        //读取产品型号
    mk_sb_taskReadFirmwareOperation,           //读取固件版本
    mk_sb_taskReadHardwareOperation,           //读取硬件类型
    mk_sb_taskReadSoftwareOperation,           //读取软件版本
    mk_sb_taskReadManufacturerOperation,       //读取厂商信息
    mk_sb_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 系统参数读取
    mk_sb_taskReadTimeZoneOperation,            //读取时区
    mk_sb_taskReadMacAddressOperation,              //读取mac地址
    mk_sb_taskReadSelftestStatusOperation,          //读取自检故障原因
    mk_sb_taskReadPCBAStatusOperation,              //读取产测状态
    mk_sb_taskReadBatteryVoltageOperation,          //读取电池电量
    mk_sb_taskReadWorkModeOperation,            //读取工作模式
    mk_sb_taskReadShutdownPayloadStatusOperation,   //读取关机信息上报状态
    mk_sb_taskReadOffByButtonOperation,             //读取按键关机功能开关
    mk_sb_taskReadLowPowerPayloadStatusOperation,   //读取低电触发心跳开关状态
    mk_sb_taskReadLowPowerPromptOperation,          //读取低电百分比
    mk_sb_taskReadHeartbeatIntervalOperation,   //读取设备心跳间隔
    mk_sb_taskReadThreeAxisWakeupConditionsOperation,       //读取三轴唤醒条件
    mk_sb_taskReadThreeAxisMotionParametersOperation,       //读取运动检测判断条件
    mk_sb_taskReadBuzzerSoundTypeOperation,         //读取蜂鸣器声效选择
    mk_sb_taskReadVibrationIntensityOperation,      //读取马达震动强度
    mk_sb_taskReadMotorStateOperation,              //读取马达异常状态
    mk_sb_taskReadIndicatorSettingsOperation,   //读取指示灯开关状态
    mk_sb_taskReadBatteryInformationOperation,      //读取电池电量消耗
    mk_sb_taskReadAutoPowerOnOperation,             //读取充电自动开机开关
    mk_sb_taskReadHardwareTypeOperation,            //读取硬件版本

#pragma mark - 蓝牙参数读取
    mk_sb_taskReadConnectationNeedPasswordOperation,    //读取连接是否需要密码
    mk_sb_taskReadPasswordOperation,                    //读取连接密码
    mk_sb_taskReadBroadcastTimeoutOperation,            //读取蓝牙广播超时时间
    mk_sb_taskReadTxPowerOperation,                     //读取蓝牙TX Power
    mk_sb_taskReadDeviceNameOperation,                  //读取广播名称
    mk_sb_taskReadAdvIntervalOperation,                 //读取广播间隔
    
#pragma mark - 模式相关参数读取
    mk_sb_taskReadStandbyModePositioningStrategyOperation,          //读取待机模式定位策略
    mk_sb_taskReadPeriodicModePositioningStrategyOperation,         //读取定期模式定位策略
    mk_sb_taskReadPeriodicModeReportIntervalOperation,              //读取定期模式上报间隔
    mk_sb_taskReadTimingModePositioningStrategyOperation,           //读取定时模式定位策略
    mk_sb_taskReadTimingModeReportingTimePointOperation,            //读取定时模式时间点
    mk_sb_taskReadMotionModeEventsOperation,                        //读取运动模式事件
    mk_sb_taskReadMotionModeNumberOfFixOnStartOperation,            //读取运动开始定位上报次数
    mk_sb_taskReadMotionModePosStrategyOnStartOperation,            //读取运动开始定位策略
    mk_sb_taskReadMotionModeReportIntervalInTripOperation,          //读取运动中定位间隔
    mk_sb_taskReadMotionModePosStrategyInTripOperation,             //读取运动中定位策略
    mk_sb_taskReadMotionModeTripEndTimeoutOperation,                //读取运动结束判断时间
    mk_sb_taskReadMotionModeNumberOfFixOnEndOperation,              //读取运动结束定位次数
    mk_sb_taskReadMotionModeReportIntervalOnEndOperation,           //读取运动结束定位间隔
    mk_sb_taskReadMotionModePosStrategyOnEndOperation,              //读取运动结束定位策略
    mk_sb_taskReadMotionModePosStrategyOnStationaryOperation,       //读取静止状态下的定位策略
    mk_sb_taskReadMotionModeReportIntervalOnStationaryOperation,    //读取静止状态下的定位间隔
    mk_sb_taskReadDownlinkForPositioningStrategyOperation,          //读取下行请求定位策略
    
#pragma mark - 蓝牙扫描过滤参数读取
    mk_sb_taskReadScanningPHYTypeOperation,             //读取蓝牙扫描PHY选择
    mk_sb_taskReadRssiFilterValueOperation,             //读取RSSI过滤规则
    mk_sb_taskReadFilterRelationshipOperation,          //读取广播内容过滤逻辑
    mk_sb_taskReadFilterByMacPreciseMatchOperation, //读取精准过滤MAC开关
    mk_sb_taskReadFilterByMacReverseFilterOperation,    //读取反向过滤MAC开关
    mk_sb_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_sb_taskReadFilterByAdvNamePreciseMatchOperation, //读取精准过滤ADV Name开关
    mk_sb_taskReadFilterByAdvNameReverseFilterOperation,    //读取反向过滤ADV Name开关
    mk_sb_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    mk_sb_taskReadFilterTypeStatusOperation,            //读取过滤设备类型开关
    mk_sb_taskReadFilterByBeaconStatusOperation,        //读取iBeacon类型过滤开关
    mk_sb_taskReadFilterByBeaconMajorRangeOperation,    //读取iBeacon类型Major范围
    mk_sb_taskReadFilterByBeaconMinorRangeOperation,    //读取iBeacon类型Minor范围
    mk_sb_taskReadFilterByBeaconUUIDOperation,          //读取iBeacon类型UUID
    mk_sb_taskReadFilterByUIDStatusOperation,                //读取UID类型过滤开关
    mk_sb_taskReadFilterByUIDNamespaceIDOperation,           //读取UID类型过滤的Namespace ID
    mk_sb_taskReadFilterByUIDInstanceIDOperation,            //读取UID类型过滤的Instance ID
    mk_sb_taskReadFilterByURLStatusOperation,               //读取URL类型过滤开关
    mk_sb_taskReadFilterByURLContentOperation,              //读取URL过滤的内容
    mk_sb_taskReadFilterByTLMStatusOperation,               //读取TLM过滤开关
    mk_sb_taskReadFilterByTLMVersionOperation,              //读取TLM过滤类型
    mk_sb_taskReadFilterByBXPBeaconStatusOperation,      //读取BXP-iBeacon类型过滤开关
    mk_sb_taskReadFilterByBXPBeaconMajorRangeOperation,    //读取BXP-iBeacon类型Major范围
    mk_sb_taskReadFilterByBXPBeaconMinorRangeOperation,    //读取BXP-iBeacon类型Minor范围
    mk_sb_taskReadFilterByBXPBeaconUUIDOperation,          //读取BXP-iBeacon类型UUID
    mk_sb_taskReadBXPButtonFilterStatusOperation,           //读取BXP-Button过滤条件开关
    mk_sb_taskReadBXPButtonAlarmFilterStatusOperation,      //读取BXP-Button报警过滤开关
    mk_sb_taskReadFilterByBXPTagIDStatusOperation,         //读取BXP-TagID类型开关
    mk_sb_taskReadPreciseMatchTagIDStatusOperation,        //读取BXP-TagID类型精准过滤tagID开关
    mk_sb_taskReadReverseFilterTagIDStatusOperation,    //读取读取BXP-TagID类型反向过滤tagID开关
    mk_sb_taskReadFilterBXPTagIDListOperation,             //读取BXP-TagID过滤规则
    mk_sb_taskReadFilterByPirStatusOperation,           //读取PIR过滤开关
    mk_sb_taskReadFilterByPirDetectionStatusOperation,  //读取PIR设备过滤sensor_detection_status
    mk_sb_taskReadFilterByPirSensorSensitivityOperation,    //读取PIR设备过滤sensor_sensitivity
    mk_sb_taskReadFilterByPirDoorStatusOperation,           //读取PIR设备过滤door_status
    mk_sb_taskReadFilterByPirDelayResponseStatusOperation,  //读取PIR设备过滤delay_response_status
    mk_sb_taskReadFilterByPirMajorRangeOperation,           //读取PIR设备Major过滤范围
    mk_sb_taskReadFilterByPirMinorRangeOperation,           //读取PIR设备Minor过滤范围
    mk_sb_taskReadFilterByOtherStatusOperation,         //读取Other过滤条件开关
    mk_sb_taskReadFilterByOtherRelationshipOperation,   //读取Other过滤条件的逻辑关系
    mk_sb_taskReadFilterByOtherConditionsOperation,     //读取Other的过滤条件列表
    
#pragma mark - 定位参数读取
    mk_sb_taskReadWifiDataTypeOperation,        //读取WIFI定位数据格式
    mk_sb_taskReadWifiFixMechanismOperation,    //读取WIFI定位机制
    mk_sb_taskReadWifiPositioningTimeoutOperation,  //读取WIFI扫描超时时间
    mk_sb_taskReadWifiNumberOfBSSIDOperation,       //读取WIFI定位成功BSSID数量
    mk_sb_taskReadBluetoothFixMechanismOperation,           //读取蓝牙定位机制选择
    mk_sb_taskReadBlePositioningTimeoutOperation,   //读取蓝牙定位超时时间
    mk_sb_taskReadBlePositioningNumberOfMacOperation,   //读取蓝牙定位成功MAC数量
    mk_sb_taskReadGPSPositioningOperation,          //读取GPS选择
    mk_sb_taskReadLCGpsExtrmeModeStatusOperation,       //读取GPS极限上传模式
    mk_sb_taskReadLCPositioningTimeoutOperation,        //读取GPS定位超时时间(L76C)
    mk_sb_taskReadLCPDOPOperation,                      //读取GPSPDOP配置(L76C)
    mk_sb_taskReadLRGPSDataTypeOperation,               //读取GPS定位数据格式(LR1110)
    mk_sb_taskReadLRPositioningTimeoutOperation,        //读取GPS定位超时时间(LR1110)
    mk_sb_taskReadLRStatelliteThresholdOperation,       //读取GPS搜星数量(LR1110)
    mk_sb_taskReadLRPositioningSystemOperation,         //读取定位系统(LR1110)
    mk_sb_taskReadLRAutonomousAidingOperation,          //读取定位方式选择(LR1110)
    mk_sb_taskReadLRLatitudeLongitudeOperation,         //读取辅助定位经纬度(LR1110)
    mk_sb_taskReadLRNotifyOnEphemerisStatusOperation,  //读取星历开始更新事件开关(LR1110)
    mk_sb_taskReadOfflineFixStatusOperation,    //读取离线定位功能开关状态
    
#pragma mark - 设备控制参数配置
    mk_sb_taskPowerOffOperation,                        //关机
    mk_sb_taskRestartDeviceOperation,                   //配置设备重新入网
    mk_sb_taskFactoryResetOperation,                    //设备恢复出厂设置
    mk_sb_taskConfigDeviceTimeOperation,                //配置时间戳
    mk_sb_taskConfigTimeZoneOperation,                  //配置时区
    mk_sb_taskConfigWorkModeOperation,                  //配置工作模式
    mk_sb_taskConfigShutdownPayloadStatusOperation,     //配置关机信息上报状态
    mk_sb_taskConfigOFFByButtonOperation,               //配置按键关机开关状态
    mk_sb_taskConfigLowPowerPayloadStatusOperation,     //配置低电触发心跳开关状态
    mk_sb_taskConfigLowPowerPromptOperation,            //配置低电百分比
    mk_sb_taskConfigHeartbeatIntervalOperation,         //配置设备心跳间隔
    mk_sb_taskConfigThreeAxisWakeupConditionsOperation,         //配置三轴唤醒条件
    mk_sb_taskConfigThreeAxisMotionParametersOperation,         //配置运动检测判断
    mk_sb_taskConfigBuzzerSoundTypeOperation,           //配置蜂鸣器声效选择
    mk_sb_taskConfigVibrationIntensityOperation,        //配置马达震动强度
    mk_sb_taskResetMotorStateOperation,                 //清除马达异常状态
    mk_sb_taskConfigIndicatorSettingsOperation,         //配置指示灯开关状态
    mk_sb_taskBatteryResetOperation,                    //清除电池电量数据
    mk_sb_taskConfigAutoPowerOnOperation,               //配置充电自动开机开关
    
    
    
    
    
    
    
    
    
    
    
#pragma mark - 蓝牙参数配置
    mk_sb_taskConfigNeedPasswordOperation,              //配置是否需要连接密码
    mk_sb_taskConfigPasswordOperation,                  //配置连接密码
    mk_sb_taskConfigBroadcastTimeoutOperation,          //配置蓝牙广播超时时间
    mk_sb_taskConfigTxPowerOperation,                   //配置蓝牙TX Power
    mk_sb_taskConfigDeviceNameOperation,                //配置蓝牙广播名称
    mk_sb_taskConfigAdvIntervalOperation,               //配置蓝牙广播间隔
    
#pragma mark - 配置模式相关参数
    mk_sb_taskConfigStandbyModePositioningStrategyOperation,        //配置待机模式定位策略
    mk_sb_taskConfigPeriodicModePositioningStrategyOperation,       //配置定期模式定位策略
    mk_sb_taskConfigPeriodicModeReportIntervalOperation,            //配置定期模式上报间隔
    mk_sb_taskConfigTimingModePositioningStrategyOperation,         //配置定时模式定位策略
    mk_sb_taskConfigTimingModeReportingTimePointOperation,          //配置定时模式时间点
    mk_sb_taskConfigMotionModeEventsOperation,                      //配置运动模式事件
    mk_sb_taskConfigMotionModeNumberOfFixOnStartOperation,          //配置运动开始定位上报次数
    mk_sb_taskConfigMotionModePosStrategyOnStartOperation,          //配置运动开始定位策略
    mk_sb_taskConfigMotionModeReportIntervalInTripOperation,        //配置运动中定位间隔
    mk_sb_taskConfigMotionModePosStrategyInTripOperation,           //配置运动中定位策略
    mk_sb_taskConfigMotionModeTripEndTimeoutOperation,              //配置运动结束判断时间
    mk_sb_taskConfigMotionModeNumberOfFixOnEndOperation,            //配置运动结束定位次数
    mk_sb_taskConfigMotionModeReportIntervalOnEndOperation,         //配置运动结束定位间隔
    mk_sb_taskConfigMotionModePosStrategyOnEndOperation,            //配置运动结束定位策略
    mk_sb_taskConfigMotionModePosStrategyOnStationaryOperation,     //配置静止状态下的定位策略
    mk_sb_taskConfigMotionModeReportIntervalOnStationaryOperation,  //配置静止状态下的定位间隔
    mk_sb_taskConfigDownlinkForPositioningStrategyOperation,        //配置下行请求定位策略
    
    
#pragma mark - 蓝牙扫描过滤参数配置
    mk_sb_taskConfigScanningPHYTypeOperation,           //配置蓝牙扫描PHY选择
    mk_sb_taskConfigRssiFilterValueOperation,           //配置rssi过滤规则
    mk_sb_taskConfigFilterRelationshipOperation,        //配置广播内容过滤逻辑
    mk_sb_taskConfigFilterByMacPreciseMatchOperation,   //配置精准过滤MAC开关
    mk_sb_taskConfigFilterByMacReverseFilterOperation,  //配置反向过滤MAC开关
    mk_sb_taskConfigFilterMACAddressListOperation,      //配置MAC过滤规则
    mk_sb_taskConfigFilterByAdvNamePreciseMatchOperation,   //配置精准过滤Adv Name开关
    mk_sb_taskConfigFilterByAdvNameReverseFilterOperation,  //配置反向过滤Adv Name开关
    mk_sb_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    mk_sb_taskConfigFilterByBeaconStatusOperation,          //配置iBeacon类型过滤开关
    mk_sb_taskConfigFilterByBeaconMajorOperation,           //配置iBeacon类型过滤的Major范围
    mk_sb_taskConfigFilterByBeaconMinorOperation,           //配置iBeacon类型过滤的Minor范围
    mk_sb_taskConfigFilterByBeaconUUIDOperation,            //配置iBeacon类型过滤的UUID
    mk_sb_taskConfigFilterByUIDStatusOperation,                 //配置UID类型过滤的开关状态
    mk_sb_taskConfigFilterByUIDNamespaceIDOperation,            //配置UID类型过滤的Namespace ID
    mk_sb_taskConfigFilterByUIDInstanceIDOperation,             //配置UID类型过滤的Instance ID
    mk_sb_taskConfigFilterByURLStatusOperation,                 //配置URL类型过滤的开关状态
    mk_sb_taskConfigFilterByURLContentOperation,                //配置URL类型过滤的内容
    mk_sb_taskConfigFilterByTLMStatusOperation,                 //配置TLM过滤开关
    mk_sb_taskConfigFilterByTLMVersionOperation,                //配置TLM过滤数据类型
    mk_sb_taskConfigFilterByBXPBeaconStatusOperation,          //配置BXP-iBeacon类型过滤开关
    mk_sb_taskConfigFilterByBXPBeaconMajorOperation,           //配置BXP-iBeacon类型过滤的Major范围
    mk_sb_taskConfigFilterByBXPBeaconMinorOperation,           //配置BXP-iBeacon类型过滤的Minor范围
    mk_sb_taskConfigFilterByBXPBeaconUUIDOperation,            //配置BXP-iBeacon类型过滤的UUID
    mk_sb_taskConfigFilterByBXPDeviceInfoStatusOperation,       //配置BXP-DeviceInfo过滤开关
    mk_sb_taskConfigBXPAccFilterStatusOperation,            //配置BeaconX Pro-ACC设备过滤开关
    mk_sb_taskConfigBXPTHFilterStatusOperation,             //配置BeaconX Pro-TH设备过滤开关
    mk_sb_taskConfigFilterByBXPButtonStatusOperation,           //配置BXP-Button过滤开关
    mk_sb_taskConfigFilterByBXPButtonAlarmStatusOperation,      //配置BXP-Button类型过滤内容
    mk_sb_taskConfigFilterByBXPTagIDStatusOperation,            //配置BXP-TagID类型过滤开关
    mk_sb_taskConfigPreciseMatchTagIDStatusOperation,           //配置BXP-TagID类型精准过滤Tag-ID开关
    mk_sb_taskConfigReverseFilterTagIDStatusOperation,          //配置BXP-TagID类型反向过滤Tag-ID开关
    mk_sb_taskConfigFilterBXPTagIDListOperation,                //配置BXP-TagID过滤规则
    mk_sb_taskConfigFilterByPirStatusOperation,             //配置PIR设备过滤开关
    mk_sb_taskConfigFilterByPirDetectionStatusOperation,    //配置PIR设备过滤sensor_detection_status
    mk_sb_taskConfigFilterByPirSensorSensitivityOperation,  //配置PIR设备过滤sensor_sensitivity
    mk_sb_taskConfigFilterByPirDoorStatusOperation,         //配置PIR设备过滤door_status
    mk_sb_taskConfigFilterByPirDelayResponseStatusOperation,    //配置PIR设备过滤delay_response_status
    mk_sb_taskConfigFilterByPirMajorOperation,                  //配置PIR设备Major过滤范围
    mk_sb_taskConfigFilterByPirMinorOperation,                  //配置PIR设备Minor过滤范围
    mk_sb_taskConfigFilterByOtherStatusOperation,           //配置Other过滤关系开关
    mk_sb_taskConfigFilterByOtherRelationshipOperation,     //配置Other过滤条件逻辑关系
    mk_sb_taskConfigFilterByOtherConditionsOperation,       //配置Other过滤条件列表
    


#pragma mark - 定位参数配置
    mk_sb_taskConfigLCGpsExtrmeModeStatusOperation,         //配置GPS极限上传模式(L76C)
    mk_sb_taskConfigLCPositioningTimeoutOperation,          //配置GPS定位超时时间(L76C)
    mk_sb_taskConfigLCPDOPOperation,                        //配置PDOP(L76C)
    mk_sb_taskConfigLRGPSDataTypeOperation,                 //配置GPS定位数据格式(LR1110)
    mk_sb_taskConfigLRPositioningTimeoutOperation,          //配置GPS定位超时时间(LR1110)
    mk_sb_taskConfigLRStatelliteThresholdOperation,         //配置GPS搜星数量(LR1110)
    mk_sb_taskConfigLRPositioningSystemOperation,           //配置GPS定位星座(LR1110)
    mk_sb_taskConfigLRAutonomousAidingOperation,            //配置定位方式选择(LR1110)
    mk_sb_taskConfigLRLatitudeLongitudeOperation,           //配置辅助定位经纬度(LR1110)
    mk_sb_taskConfigLRNotifyOnEphemerisStatusOperation,     //配置星历开始更新事件开关(LR1110)
    
    
    
    mk_sb_taskConfigWifiDataTypeOperation,              //配置WIFI定位数据格式
    mk_sb_taskConfigWifiFixMechanismOperation,          //配置wifi定位机制
    mk_sb_taskConfigWifiPositioningTimeoutOperation,    //配置WIFI扫描超时时间
    mk_sb_taskConfigWifiNumberOfBSSIDOperation,         //配置WIFI定位成功BSSID数量
    mk_sb_taskConfigBluetoothFixMechanismOperation,             //配置蓝牙定位机制
    mk_sb_taskConfigBlePositioningTimeoutOperation,     //配置蓝牙定位超时时间
    mk_sb_taskConfigBlePositioningNumberOfMacOperation,     //配置蓝牙定位mac数量
    mk_sb_taskConfigGPSPositioningOperation,            //配置GPS选择
    mk_sb_taskConfigOfflineFixOperation,                //配置离线定位功能开关状态
    
#pragma mark - 密码特征
    mk_sb_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备LoRa参数读取
    mk_sb_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_sb_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_sb_taskReadLorawanModemOperation,            //读取LoRaWAN入网类型
    mk_sb_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_sb_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_sb_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_sb_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_sb_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_sb_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_sb_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_sb_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_sb_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_sb_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_sb_taskReadLorawanADRACKLimitOperation,              //读取ADR_ACK_LIMIT
    mk_sb_taskReadLorawanADRACKDelayOperation,              //读取ADR_ACK_DELAY
    mk_sb_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_sb_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    mk_sb_taskReadDeviceInfoPayloadDataOperation,       //读取设备信息包上行配置
    mk_sb_taskReadHeartbeatPayloadDataOperation,        //读取心跳数据包上行配置
    mk_sb_taskReadLowPowerPayloadDataOperation,         //读取低电状态数据包上行配置
    mk_sb_taskReadEventPayloadDataOperation,            //读取事件信息包上行配置
    mk_sb_taskReadGPSLimitPayloadDataOperation,         //读取GPS极限定位数据包上行配置
    mk_sb_taskReadPositioningPayloadDataOperation,      //读取定位数据包上行配置
    
#pragma mark - 辅助功能读取
    mk_sb_taskReadDownlinkPositioningStrategyOperation,     //读取下行请求定位策略
    mk_sb_taskReadManDownDetectionOperation,                //读取闲置功能使能
    mk_sb_taskReadManDownPositioningStrategyOperation,      //读取ManDown定位策略
    mk_sb_taskReadManDownDetectionTimeoutOperation,         //读取ManDown检测超时时间
    mk_sb_taskReadManDownReportIntervalOperation,           //读取ManDown定位数据上报间隔
    mk_sb_taskReadAlarmTypeOperation,                       //读取报警类型选择
    mk_sb_taskReadExitAlarmTypeTimeOperation,               //读取退出报警按键时长
    mk_sb_taskReadAlertAlarmTriggerModeOperation,           //读取Alert报警触发按键模式
    mk_sb_taskReadAlertAlarmPositioningStrategyOperation,   //读取Alert报警定位策略
    mk_sb_taskReadAlertAlarmNotifyStatusOperation,          //读取Alert报警事件通知
    mk_sb_taskReadSosAlarmTriggerModeOperation,             //读取SOS报警触发按键模式
    mk_sb_taskReadSosAlarmPositioningStrategyOperation,     //读取SOS报警定位策略
    mk_sb_taskReadSosAlarmReportIntervalOperation,          //读取SOS报警数据上报间隔
    mk_sb_taskReadSosAlarmNotifyStatusOperation,            //读取SOS报警事件通知
    
#pragma mark - 设备LoRa参数配置
    mk_sb_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_sb_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_sb_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_sb_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_sb_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_sb_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_sb_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_sb_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_sb_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_sb_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_sb_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_sb_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_sb_taskConfigLorawanADRACKLimitOperation,        //配置ADR_ACK_LIMIT
    mk_sb_taskConfigLorawanADRACKDelayOperation,        //配置ADR_ACK_DELAY
    mk_sb_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_sb_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    mk_sb_taskConfigDeviceInfoPayloadOperation,         //配置设备信息包上行参数
    mk_sb_taskConfigHeartbeatPayloadOperation,          //配置心跳数据包上行参数
    mk_sb_taskConfigLowPowerPayloadOperation,           //配置低电状态数据包上行参数
    mk_sb_taskConfigEventPayloadOperation,              //配置事件信息包上行参数
    mk_sb_taskConfigGPSLimitPayloadOperation,           //配置GPS极限定位数据包上行参数
    mk_sb_taskConfigPositioningPayloadOperation,        //配置定位数据包上行参数
    
    
#pragma mark - 辅助功能配置
    mk_sb_taskConfigDownlinkPositioningStrategyOperation,  //配置下行请求定位策略
    mk_sb_taskConfigManDownDetectionStatusOperation,            //配置闲置功能使能
    mk_sb_taskConfigManDownPositioningStrategyOperation,        //配置ManDown定位策略
    mk_sb_taskConfigManDownDetectionTimeoutOperation,           //配置ManDown检测超时时间
    mk_sb_taskConfigManDownReportIntervalOperation,             //配置ManDown定位数据上报间隔
    mk_sb_taskConfigAlarmTypeOperation,                         //配置报警类型选择
    mk_sb_taskConfigExitAlarmTypeTimeOperation,                 //配置退出报警按键
    mk_sb_taskConfigAlertAlarmTriggerModeOperation,             //配置Alert报警触发按键模式
    mk_sb_taskConfigAlertAlarmPositioningStrategyOperation,     //配置Alert报警定位策略
    mk_sb_taskConfigAlertAlarmNotifyEventOperation,             //配置Alert报警事件通知
    mk_sb_taskConfigSosAlarmTriggerModeOperation,               //配置SOS报警触发按键模式
    mk_sb_taskConfigSosAlarmPositioningStrategyOperation,       //配置SOS报警定位策略
    mk_sb_taskConfigSosAlarmReportIntervalOperation,            //配置SOS报警定位数据上报间隔
    mk_sb_taskConfigSosAlarmNotifyEventOperation,               //配置SOS报警事件通知
    
#pragma mark - 存储数据协议
    mk_sb_taskReadNumberOfDaysStoredDataOperation,      //读取多少天本地存储的数据
    mk_sb_taskClearAllDatasOperation,                   //清除存储的所有数据
    mk_sb_taskPauseSendLocalDataOperation,              //暂停/恢复数据传输
};
