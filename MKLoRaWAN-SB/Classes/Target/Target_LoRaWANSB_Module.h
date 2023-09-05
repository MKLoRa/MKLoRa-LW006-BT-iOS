//
//  Target_LoRaWANSB_Module.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_LoRaWANSB_Module : NSObject

/// 扫描页面
- (UIViewController *)Action_LoRaWANSB_Module_ScanController:(NSDictionary *)params;

/// 关于页面
- (UIViewController *)Action_LoRaWANSB_Module_AboutController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
