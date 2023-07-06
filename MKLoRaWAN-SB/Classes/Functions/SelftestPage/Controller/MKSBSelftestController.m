//
//  MKSBSelftestController.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKSBSelftestController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKAlertController.h"
#import "MKTextButtonCell.h"
#import "MKButtonMsgCell.h"
#import "MKNormalTextCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKSBInterface+MKSBConfig.h"

#import "MKSBSelftestModel.h"

#import "MKSBSelftestCell.h"
#import "MKSBPCBAStatusCell.h"
#import "MKSBBatteryInfoCell.h"

@interface MKSBSelftestController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
MKButtonMsgCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKSBSelftestModel *dataModel;

@end

@implementation MKSBSelftestController

- (void)dealloc {
    NSLog(@"MKSBSelftestController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60.f;
    }
    if (indexPath.section == 3) {
        return 300.f;
    }
    if (indexPath.section == 4) {
        MKButtonMsgCellModel *cellModel = self.section4List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 6) {
        return 0.f;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return self.section5List.count;
    }
    if (section == 6) {
        return self.section6List.count;
    }
    if (section == 7) {
        return self.section7List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKSBSelftestCell *cell = [MKSBSelftestCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKSBPCBAStatusCell *cell = [MKSBPCBAStatusCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKSBBatteryInfoCell *cell = [MKSBBatteryInfoCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 4) {
        MKButtonMsgCell *cell = [MKButtonMsgCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 5) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section5List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 6) {
        MKButtonMsgCell *cell = [MKButtonMsgCell initCellWithTableView:tableView];
        cell.dataModel = self.section6List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section7List[indexPath.row];
    return cell;
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    if (index == 0) {
        //GPS Positioning
        [self configGPSPositioning:dataListIndex];
        return;
    }
}

#pragma mark - MKButtonMsgCellDelegate
/// 右侧按钮点击事件
/// @param index 当前cell所在index
- (void)mk_buttonMsgCellButtonPressed:(NSInteger)index {
    if (index == 0) {
        //Battery Reset
        [self batteryReset];
        return;
    }
    if (index == 1) {
        //Reset Motor State
        [self resetMotorState];
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - 清除电池数据
- (void)batteryReset {
    NSString *msg = @"Are you sure to reset battery?";
    MKAlertController *alertView = [MKAlertController alertControllerWithTitle:@"Warning!"
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
    alertView.notificationName = @"mk_sb_needDismissAlert";
    @weakify(self);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:cancelAction];
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self sendBatteryResetCommandToDevice];
    }];
    [alertView addAction:moreAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)sendBatteryResetCommandToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKSBInterface sb_batteryResetWithSucBlock:^{
        [[MKHudManager share] hide];
        [self reloadBatteryDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)resetMotorState {
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKSBInterface sb_resetMotorStateWithSucBlock:^{
        [[MKHudManager share] hide];
        [self reloadMotoState];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)configGPSPositioning:(NSInteger)index {
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKSBInterface sb_configGPSPositioning:index sucBlock:^{
        [[MKHudManager share] hide];
        MKTextButtonCellModel *cellModel = self.section2List[0];
        cellModel.dataListIndex = index;
        self.dataModel.gpsPositioning = index;
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)reloadBatteryDatas {
    [[MKHudManager share] showHUDWithTitle:@"Reading..."
                                     inView:self.view
                              isPenetration:NO];
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        MKSBBatteryInfoCellModel *cellModel = self.section3List[0];
        cellModel.workTimes = self.dataModel.workTimes;
        cellModel.advCount = self.dataModel.advCount;
        cellModel.flashOperationCount = self.dataModel.flashOperationCount;
        cellModel.axisWakeupTimes = self.dataModel.axisWakeupTimes;
        cellModel.blePostionTimes = self.dataModel.blePostionTimes;
        cellModel.wifiPostionTimes = self.dataModel.wifiPostionTimes;
        cellModel.gpsPostionTimes = self.dataModel.gpsPostionTimes;
        cellModel.loraSendCount = self.dataModel.loraSendCount;
        cellModel.loraPowerConsumption = self.dataModel.loraPowerConsumption;

        
        [self.tableView mk_reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)reloadMotoState {
    [[MKHudManager share] showHUDWithTitle:@"Reading..."
                                     inView:self.view
                              isPenetration:NO];
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        MKNormalTextCellModel *cellModel = self.section5List[0];
        cellModel.rightMsg = (self.dataModel.motorState == 0 ? @"Normal" : @"Fault");
        
        [self.tableView mk_reloadSection:5 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    [self loadSection7Datas];
    
    for (NSInteger i = 0; i < 8; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKSBSelftestCellModel *cellModel = [[MKSBSelftestCellModel alloc] init];
    if ([self.dataModel.l76c integerValue] == 0 && [self.dataModel.acceData integerValue] == 0 && [self.dataModel.flash integerValue] == 0) {
        cellModel.value0 = @"0";
    }
    cellModel.value1 = ([self.dataModel.flash integerValue] == 1 ? @"3" : @"");
    cellModel.value2 = ([self.dataModel.acceData integerValue] == 1 ? @"2" : @"");
    cellModel.value3 = ([self.dataModel.l76c integerValue] == 1 ? @"1" : @"");
    
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKSBPCBAStatusCellModel *cellModel = [[MKSBPCBAStatusCellModel alloc] init];
    cellModel.value0 = (([self.dataModel.pcbaStatus integerValue] == 0) ? @"0" : @"");
    cellModel.value1 = (([self.dataModel.pcbaStatus integerValue] == 1) ? @"1" : @"");
    cellModel.value2 = (([self.dataModel.pcbaStatus integerValue] == 2) ? @"2" : @"");
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"GPS Positioning";
    cellModel.dataList = @[@"Traditional GPS module",@"LoRa Cloud"];
    cellModel.buttonLabelFont = MKFont(11.f);
    cellModel.dataListIndex = self.dataModel.gpsPositioning;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKSBBatteryInfoCellModel *cellModel = [[MKSBBatteryInfoCellModel alloc] init];
    cellModel.workTimes = self.dataModel.workTimes;
    cellModel.advCount = self.dataModel.advCount;
    cellModel.flashOperationCount = self.dataModel.flashOperationCount;
    cellModel.axisWakeupTimes = self.dataModel.axisWakeupTimes;
    cellModel.blePostionTimes = self.dataModel.blePostionTimes;
    cellModel.wifiPostionTimes = self.dataModel.wifiPostionTimes;
    cellModel.gpsPostionTimes = self.dataModel.gpsPostionTimes;
    cellModel.loraSendCount = self.dataModel.loraSendCount;
    cellModel.loraPowerConsumption = self.dataModel.loraPowerConsumption;
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKButtonMsgCellModel *cellModel = [[MKButtonMsgCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Battery Reset";
    cellModel.buttonTitle = @"Reset";
    cellModel.noteMsg = @"*After replace with the new battery, need to click \"Reset\", otherwise the low power prompt will be unnormal.";
    cellModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Motor State";
    cellModel.rightMsg = (self.dataModel.motorState == 0 ? @"Normal" : @"Fault");
    [self.section5List addObject:cellModel];
}

- (void)loadSection6Datas {
    MKButtonMsgCellModel *cellModel = [[MKButtonMsgCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Reset Motor State";
    cellModel.buttonTitle = @"Reset";
    cellModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    [self.section6List addObject:cellModel];
}
- (void)loadSection7Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"HW Version";
    cellModel.rightMsg = (self.dataModel.hwVersion == 0 ? @"Traditional GPS module Supported" : @"No");
    [self.section7List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Selftest Interface";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (NSMutableArray *)section6List {
    if (!_section6List) {
        _section6List = [NSMutableArray array];
    }
    return _section6List;
}

- (NSMutableArray *)section7List {
    if (!_section7List) {
        _section7List = [NSMutableArray array];
    }
    return _section7List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKSBSelftestModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKSBSelftestModel alloc] init];
    }
    return _dataModel;
}

@end
