//
//  MKSBDevEUICell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2025/3/5.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBDevEUICellModel : NSObject

@property (nonatomic, copy)NSString *devEUI;

@end

@interface MKSBDevEUICell : MKBaseCell

@property (nonatomic, strong)MKSBDevEUICellModel *dataModel;

+ (MKSBDevEUICell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
