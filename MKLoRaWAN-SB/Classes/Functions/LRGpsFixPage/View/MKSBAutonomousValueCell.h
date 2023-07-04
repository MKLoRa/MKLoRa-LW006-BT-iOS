//
//  MKSBAutonomousValueCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBAutonomousValueCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *value;

@property (nonatomic, copy)NSString *placeholder;

@property (nonatomic, assign)NSInteger maxLength;

@end

@protocol MKSBAutonomousValueCellDelegate <NSObject>

- (void)sb_autonomousValueCellValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKSBAutonomousValueCell : MKBaseCell

@property (nonatomic, weak)id <MKSBAutonomousValueCellDelegate>delegate;

@property (nonatomic, strong)MKSBAutonomousValueCellModel *dataModel;

+ (MKSBAutonomousValueCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
