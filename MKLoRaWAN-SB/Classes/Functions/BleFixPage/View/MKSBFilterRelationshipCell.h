//
//  MKSBFilterRelationshipCell.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBFilterRelationshipCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray *dataList;

@end

@protocol MKSBFilterRelationshipCellDelegate <NSObject>

- (void)sb_filterRelationshipChanged:(NSInteger)index dataListIndex:(NSInteger)dataListIndex;

@end

@interface MKSBFilterRelationshipCell : MKBaseCell

@property (nonatomic, strong)MKSBFilterRelationshipCellModel *dataModel;

@property (nonatomic, weak)id <MKSBFilterRelationshipCellDelegate>delegate;

+ (MKSBFilterRelationshipCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
