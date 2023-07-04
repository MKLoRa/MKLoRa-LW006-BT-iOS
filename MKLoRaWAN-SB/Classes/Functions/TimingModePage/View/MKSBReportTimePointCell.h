//
//  MKSBReportTimePointCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBReportTimePointCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger hourIndex;

@property (nonatomic, assign)NSInteger timeSpaceIndex;

@end

@protocol MKSBReportTimePointCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)sb_cellDeleteButtonPressed:(NSInteger)index;

/// 用户选择了hour事件
- (void)sb_hourButtonPressed:(NSInteger)index;

/// 用户选择了时间间隔事件
- (void)sb_timeSpaceButtonPressed:(NSInteger)index;

/**
 重新设置cell的子控件位置，主要是删除按钮方面的处理
 */
- (void)sb_cellResetFrame;

/// cell的点击事件，用来重置cell的布局
- (void)sb_cellTapAction;

@end

@interface MKSBReportTimePointCell : MKBaseCell

@property (nonatomic, weak)id <MKSBReportTimePointCellDelegate>delegate;

@property (nonatomic, strong)MKSBReportTimePointCellModel *dataModel;

+ (MKSBReportTimePointCell *)initCellWithTableView:(UITableView *)tableView;

- (BOOL)canReset;
- (void)resetCellFrame;
- (void)resetFlagForFrame;

@end

NS_ASSUME_NONNULL_END
