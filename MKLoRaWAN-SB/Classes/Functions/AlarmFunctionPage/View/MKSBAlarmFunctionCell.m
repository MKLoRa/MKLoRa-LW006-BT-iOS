//
//  MKSBAlarmFunctionCell.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBAlarmFunctionCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"
#import "MKCustomUIAdopter.h"

@implementation MKSBAlarmFunctionCellModel
@end

@interface MKSBAlarmFunctionCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel * pressLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@end

@implementation MKSBAlarmFunctionCell

+ (MKSBAlarmFunctionCell *)initCellWithTableView:(UITableView *)tableView {
    MKSBAlarmFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKSBAlarmFunctionCellIdenty"];
    if (!cell) {
        cell = [[MKSBAlarmFunctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKSBAlarmFunctionCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.pressLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(50);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(25.f);
    }];
    [self.pressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.textField.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(70);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKSBAlarmFunctionCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKSBAlarmFunctionCellModel.class]) {
        return;
    }
    self.textField.text = SafeStr(_dataModel.exitTime);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.text = @"Exit Alarm Type";
    }
    return _msgLabel;
}

- (UILabel *)pressLabel {
    if (!_pressLabel) {
        _pressLabel = [[UILabel alloc] init];
        _pressLabel.textColor = DEFAULT_TEXT_COLOR;
        _pressLabel.textAlignment = NSTextAlignmentRight;
        _pressLabel.font = MKFont(12.f);
        _pressLabel.text = @"Long press";
    }
    return _pressLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                          placeHolder:@"5~15"
                                                             textType:mk_realNumberOnly];
        _textField.maxLength = 2;
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(sb_exitAlarmTypeChanged:)]) {
                [self.delegate sb_exitAlarmTypeChanged:text];
            }
        };
    }
    return _textField;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.font = MKFont(12.f);
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.text = @"s";
    }
    return _unitLabel;
}

@end
