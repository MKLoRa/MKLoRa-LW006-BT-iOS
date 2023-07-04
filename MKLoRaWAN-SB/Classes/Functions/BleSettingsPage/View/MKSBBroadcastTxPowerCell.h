//
//  MKSBBroadcastTxPowerCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBBroadcastTxPowerCellModel : NSObject

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,     //2dBm
 8,       //3dBm
 9,       //4dBm
 10,      //5dBm
 11,     //6dBm
 12,     //7dBm
 13,     //8dBm
 */
@property (nonatomic, assign)NSInteger txPowerValue;

@end

@protocol MKSBBroadcastTxPowerCellDelegate <NSObject>

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,     //2dBm
 8,       //3dBm
 9,       //4dBm
 10,      //5dBm
 11,     //6dBm
 12,     //7dBm
 13,     //8dBm
 */
- (void)sb_txPowerValueChanged:(NSInteger)txPower;

@end

@interface MKSBBroadcastTxPowerCell : MKBaseCell

@property (nonatomic, weak)id <MKSBBroadcastTxPowerCellDelegate>delegate;

@property (nonatomic, strong)MKSBBroadcastTxPowerCellModel *dataModel;

+ (MKSBBroadcastTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
