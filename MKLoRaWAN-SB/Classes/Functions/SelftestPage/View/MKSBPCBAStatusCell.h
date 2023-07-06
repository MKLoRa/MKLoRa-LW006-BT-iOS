//
//  MKSBPCBAStatusCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBPCBAStatusCellModel : NSObject

@property (nonatomic, copy)NSString *value0;

@property (nonatomic, copy)NSString *value1;

@property (nonatomic, copy)NSString *value2;

@end

@interface MKSBPCBAStatusCell : MKBaseCell

@property (nonatomic, strong)MKSBPCBAStatusCellModel *dataModel;

+ (MKSBPCBAStatusCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
