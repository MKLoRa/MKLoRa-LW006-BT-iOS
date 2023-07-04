//
//  MKSBFilterBeaconCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKSBFilterBeaconCellDelegate <NSObject>

- (void)mk_sb_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_sb_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKSBFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKSBFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKSBFilterBeaconCellDelegate>delegate;

+ (MKSBFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
