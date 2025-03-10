//
//  MKSBLoRaSettingAccountCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2025/3/3.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBLoRaSettingAccountCellModel : NSObject

@property (nonatomic, copy)NSString *account;

@end

@protocol MKSBLoRaSettingAccountCellDelegate <NSObject>

- (void)sb_loRaSettingAccountCell_logoutBtnPressed;

@end

@interface MKSBLoRaSettingAccountCell : MKBaseCell

@property (nonatomic, strong)MKSBLoRaSettingAccountCellModel *dataModel;

@property (nonatomic, weak)id <MKSBLoRaSettingAccountCellDelegate>delegate;

+ (MKSBLoRaSettingAccountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
