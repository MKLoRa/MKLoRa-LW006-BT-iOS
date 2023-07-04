//
//  MKSBAlarmFunctionCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBAlarmFunctionCellModel : NSObject

@property (nonatomic, copy)NSString *exitTime;

@end

@protocol MKSBAlarmFunctionCellDelegate <NSObject>

- (void)sb_exitAlarmTypeChanged:(NSString *)value;

@end

@interface MKSBAlarmFunctionCell : MKBaseCell

@property (nonatomic, strong)MKSBAlarmFunctionCellModel *dataModel;

@property (nonatomic, weak)id <MKSBAlarmFunctionCellDelegate>delegate;

+ (MKSBAlarmFunctionCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
