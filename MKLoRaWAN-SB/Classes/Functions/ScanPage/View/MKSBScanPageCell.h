//
//  MKSBScanPageCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKSBScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)sb_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKSBScanPageModel;
@interface MKSBScanPageCell : MKBaseCell

@property (nonatomic, strong)MKSBScanPageModel *dataModel;

@property (nonatomic, weak)id <MKSBScanPageCellDelegate>delegate;

+ (MKSBScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
