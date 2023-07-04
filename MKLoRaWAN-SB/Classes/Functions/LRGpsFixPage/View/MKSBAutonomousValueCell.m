//
//  MKSBAutonomousValueCell.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBAutonomousValueCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKTextField.h"

@implementation MKSBAutonomousValueCellModel
@end

@interface MKSBAutonomousValueCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@end

@implementation MKSBAutonomousValueCell

+ (MKSBAutonomousValueCell *)initCellWithTableView:(UITableView *)tableView {
    MKSBAutonomousValueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKSBAutonomousValueCellIdenty"];
    if (!cell) {
        cell = [[MKSBAutonomousValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKSBAutonomousValueCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(50.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.textField.mas_left).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)textFieldValueChanged {
    NSString *inputValue = self.textField.text;
    if (!ValidStr(inputValue)) {
        self.textField.text = @"";
        if ([self.delegate respondsToSelector:@selector(sb_autonomousValueCellValueChanged:index:)]) {
            [self.delegate sb_autonomousValueCellValueChanged:self.textField.text index:self.dataModel.index];
        }
        return;
    }
    NSString *string = [inputValue substringFromIndex:(inputValue.length - 1)];
    BOOL next = NO;
    if ([string regularExpressions:isRealNumbers]) {
        next = YES;
    }else {
        //非数字，如果是第一个字符，可以为负号，其余字符一律不对
        if (inputValue.length == 1 && [string isEqualToString:@"-"]) {
            next = YES;
        }
    }
    if (!next) {
        self.textField.text = [inputValue substringToIndex:(inputValue.length - 1)];
        if ([self.delegate respondsToSelector:@selector(sb_autonomousValueCellValueChanged:index:)]) {
            [self.delegate sb_autonomousValueCellValueChanged:self.textField.text index:self.dataModel.index];
        }
        return;
    }
    if (self.dataModel.maxLength > 0) {
        if (inputValue.length > self.dataModel.maxLength) {
            self.textField.text = [inputValue substringToIndex:self.dataModel.maxLength];
            if ([self.delegate respondsToSelector:@selector(sb_autonomousValueCellValueChanged:index:)]) {
                [self.delegate sb_autonomousValueCellValueChanged:self.textField.text index:self.dataModel.index];
            }
            return;
        }
    }
    self.textField.text = inputValue;
    if ([self.delegate respondsToSelector:@selector(sb_autonomousValueCellValueChanged:index:)]) {
        [self.delegate sb_autonomousValueCellValueChanged:self.textField.text index:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKSBAutonomousValueCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKSBAutonomousValueCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.textField.text = SafeStr(_dataModel.value);
    self.textField.attributedPlaceholder = [MKCustomUIAdopter attributedString:@[SafeStr(_dataModel.placeholder)]
                                                                         fonts:@[MKFont(12.f)]
                                                                        colors:@[UIColorFromRGB(0x353535)]];
    ;
    self.textField.maxLength = _dataModel.maxLength;
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(13.f);
    }
    return _msgLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                          placeHolder:@""
                                                             textType:mk_normal];
        _textField.font = MKFont(13.f);
        [_textField addTarget:self
                       action:@selector(textFieldValueChanged)
             forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.textAlignment = NSTextAlignmentRight;
        _unitLabel.font = MKFont(10.f);
        _unitLabel.text = @"x0.00001";
    }
    return _unitLabel;
}

@end
