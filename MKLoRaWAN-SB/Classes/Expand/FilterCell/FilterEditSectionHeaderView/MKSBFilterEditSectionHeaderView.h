//
//  MKSBFilterEditSectionHeaderView.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKSBFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_sb_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_sb_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKSBFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKSBFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKSBFilterEditSectionHeaderViewDelegate>delegate;

+ (MKSBFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
