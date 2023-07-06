//
//  MKSBDebuggerCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKSBDebuggerCellDelegate <NSObject>

- (void)sb_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKSBDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKSBDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKSBDebuggerCellDelegate>delegate;

+ (MKSBDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
