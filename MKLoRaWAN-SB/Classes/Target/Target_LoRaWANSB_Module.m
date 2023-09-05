//
//  Target_LoRaWANSB_Module.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANSB_Module.h"

#import "MKSBScanController.h"

#import "MKSBAboutController.h"

@implementation Target_LoRaWANSB_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANSB_Module_ScanController:(NSDictionary *)params {
    return [[MKSBScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANSB_Module_AboutController:(NSDictionary *)params {
    return [[MKSBAboutController alloc] init];
}

@end
