//
//  MKSBBatteryInfoCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBBatteryInfoCellModel : NSObject

@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *flashOperationCount;

@property (nonatomic, copy)NSString *axisWakeupTimes;

@property (nonatomic, copy)NSString *blePostionTimes;

@property (nonatomic, copy)NSString *wifiPostionTimes;

@property (nonatomic, copy)NSString *gpsPostionTimes;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *loraPowerConsumption;

@end

@interface MKSBBatteryInfoCell : MKBaseCell

@property (nonatomic, strong)MKSBBatteryInfoCellModel *dataModel;

+ (MKSBBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
