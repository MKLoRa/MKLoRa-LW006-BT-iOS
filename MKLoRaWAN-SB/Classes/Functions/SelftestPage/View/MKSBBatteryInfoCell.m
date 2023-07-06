//
//  MKSBBatteryInfoCell.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBBatteryInfoCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKSBBatteryInfoCellModel
@end

@interface MKSBBatteryInfoCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *workTimeLabel;

@property (nonatomic, strong)UILabel *advCountLabel;

@property (nonatomic, strong)UILabel *flashCountLabel;

@property (nonatomic, strong)UILabel *axisPostionLabel;

@property (nonatomic, strong)UILabel *blePostionLabel;

@property (nonatomic, strong)UILabel *wifiPostionLabel;

@property (nonatomic, strong)UILabel *gpsPostionLabel;

@property (nonatomic, strong)UILabel *loraSendCountLabel;

@property (nonatomic, strong)UILabel *loraPowerLabel;

@end

@implementation MKSBBatteryInfoCell

+ (MKSBBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView {
    MKSBBatteryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKSBBatteryInfoCellIdenty"];
    if (!cell) {
        cell = [[MKSBBatteryInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKSBBatteryInfoCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.workTimeLabel];
        [self.contentView addSubview:self.advCountLabel];
        [self.contentView addSubview:self.flashCountLabel];
        [self.contentView addSubview:self.axisPostionLabel];
        [self.contentView addSubview:self.blePostionLabel];
        [self.contentView addSubview:self.wifiPostionLabel];
        [self.contentView addSubview:self.gpsPostionLabel];
        [self.contentView addSubview:self.loraPowerLabel];
        [self.contentView addSubview:self.loraSendCountLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.workTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.advCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.workTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.flashCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.advCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.axisPostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.flashCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.blePostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.axisPostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.wifiPostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.blePostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.gpsPostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.wifiPostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraSendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.gpsPostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraSendCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKSBBatteryInfoCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKSBBatteryInfoCellModel.class]) {
        return;
    }
    self.workTimeLabel.text = [SafeStr(_dataModel.workTimes) stringByAppendingString:@" s"];
    self.advCountLabel.text = [SafeStr(_dataModel.advCount) stringByAppendingString:@" times"];
    self.flashCountLabel.text = [SafeStr(_dataModel.flashOperationCount) stringByAppendingString:@" times"];
    self.axisPostionLabel.text = [SafeStr(_dataModel.axisWakeupTimes) stringByAppendingString:@"ms"];
    self.blePostionLabel.text = [SafeStr(_dataModel.blePostionTimes) stringByAppendingString:@"ms"];
    self.wifiPostionLabel.text = [SafeStr(_dataModel.wifiPostionTimes) stringByAppendingString:@"ms"];
    self.gpsPostionLabel.text = [SafeStr(_dataModel.gpsPostionTimes) stringByAppendingString:@"s"];
    self.loraPowerLabel.text = [SafeStr(_dataModel.loraPowerConsumption) stringByAppendingString:@" mAS"];
    self.loraSendCountLabel.text = [SafeStr(_dataModel.loraSendCount) stringByAppendingString:@" times"];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"Battery information:";
    }
    return _msgLabel;
}

- (UILabel *)workTimeLabel {
    if (!_workTimeLabel) {
        _workTimeLabel = [self fetchValueLabel];
    }
    return _workTimeLabel;
}

- (UILabel *)advCountLabel {
    if (!_advCountLabel) {
        _advCountLabel = [self fetchValueLabel];
    }
    return _advCountLabel;
}

- (UILabel *)flashCountLabel {
    if (!_flashCountLabel) {
        _flashCountLabel = [self fetchValueLabel];
    }
    return _flashCountLabel;
}

- (UILabel *)axisPostionLabel {
    if (!_axisPostionLabel) {
        _axisPostionLabel = [self fetchValueLabel];
    }
    return _axisPostionLabel;
}

- (UILabel *)blePostionLabel {
    if (!_blePostionLabel) {
        _blePostionLabel = [self fetchValueLabel];
    }
    return _blePostionLabel;
}

- (UILabel *)wifiPostionLabel {
    if (!_wifiPostionLabel) {
        _wifiPostionLabel = [self fetchValueLabel];
    }
    return _wifiPostionLabel;
}

- (UILabel *)gpsPostionLabel {
    if (!_gpsPostionLabel) {
        _gpsPostionLabel = [self fetchValueLabel];
    }
    return _gpsPostionLabel;
}

- (UILabel *)loraSendCountLabel {
    if (!_loraSendCountLabel) {
        _loraSendCountLabel = [self fetchValueLabel];
    }
    return _loraSendCountLabel;
}

- (UILabel *)loraPowerLabel {
    if (!_loraPowerLabel) {
        _loraPowerLabel = [self fetchValueLabel];
    }
    return _loraPowerLabel;
}

- (UILabel *)fetchValueLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    return label;
}

@end
