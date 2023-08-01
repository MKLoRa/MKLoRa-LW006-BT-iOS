//
//  MKSBDeviceInfoCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/8/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBDeviceInfoCellModel : NSObject

@property (nonatomic, copy)NSString *leftMsg;

@property (nonatomic, copy)NSString *rightMsg;

- (CGFloat)cellHeightWithContentWidth:(CGFloat)width;

@end

@interface MKSBDeviceInfoCell : MKBaseCell

@property (nonatomic, strong)MKSBDeviceInfoCellModel *dataModel;

+ (MKSBDeviceInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
