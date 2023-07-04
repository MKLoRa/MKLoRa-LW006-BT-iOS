//
//  MKSBTimingModeAddCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBTimingModeAddCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKSBTimingModeAddCellDelegate <NSObject>

- (void)sb_addButtonPressed;

@end

@interface MKSBTimingModeAddCell : MKBaseCell

@property (nonatomic, strong)MKSBTimingModeAddCellModel *dataModel;

@property (nonatomic, weak)id <MKSBTimingModeAddCellDelegate>delegate;

+ (MKSBTimingModeAddCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
