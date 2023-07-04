//
//  CBPeripheral+MKSBAdd.m
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKSBAdd.h"

#import <objc/runtime.h>

static const char *sb_manufacturerKey = "sb_manufacturerKey";
static const char *sb_deviceModelKey = "sb_deviceModelKey";
static const char *sb_hardwareKey = "sb_hardwareKey";
static const char *sb_softwareKey = "sb_softwareKey";
static const char *sb_firmwareKey = "sb_firmwareKey";

static const char *sb_passwordKey = "sb_passwordKey";
static const char *sb_disconnectTypeKey = "sb_disconnectTypeKey";
static const char *sb_customKey = "sb_customKey";
static const char *sb_storageDataKey = "sb_storageDataKey";
static const char *sb_logKey = "sb_logKey";

static const char *sb_passwordNotifySuccessKey = "sb_passwordNotifySuccessKey";
static const char *sb_disconnectTypeNotifySuccessKey = "sb_disconnectTypeNotifySuccessKey";
static const char *sb_customNotifySuccessKey = "sb_customNotifySuccessKey";

@implementation CBPeripheral (MKSBAdd)

- (void)sb_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &sb_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &sb_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &sb_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &sb_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &sb_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &sb_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &sb_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &sb_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &sb_storageDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &sb_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)sb_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &sb_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &sb_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        objc_setAssociatedObject(self, &sb_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)sb_connectSuccess {
    if (![objc_getAssociatedObject(self, &sb_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &sb_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &sb_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.sb_manufacturer || !self.sb_deviceModel || !self.sb_hardware || !self.sb_software || !self.sb_firmware) {
        return NO;
    }
    if (!self.sb_password || !self.sb_disconnectType || !self.sb_custom || !self.sb_log || !self.sb_storageData) {
        return NO;
    }
    return YES;
}

- (void)sb_setNil {
    objc_setAssociatedObject(self, &sb_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &sb_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_storageDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &sb_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &sb_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)sb_manufacturer {
    return objc_getAssociatedObject(self, &sb_manufacturerKey);
}

- (CBCharacteristic *)sb_deviceModel {
    return objc_getAssociatedObject(self, &sb_deviceModelKey);
}

- (CBCharacteristic *)sb_hardware {
    return objc_getAssociatedObject(self, &sb_hardwareKey);
}

- (CBCharacteristic *)sb_software {
    return objc_getAssociatedObject(self, &sb_softwareKey);
}

- (CBCharacteristic *)sb_firmware {
    return objc_getAssociatedObject(self, &sb_firmwareKey);
}

- (CBCharacteristic *)sb_password {
    return objc_getAssociatedObject(self, &sb_passwordKey);
}

- (CBCharacteristic *)sb_disconnectType {
    return objc_getAssociatedObject(self, &sb_disconnectTypeKey);
}

- (CBCharacteristic *)sb_custom {
    return objc_getAssociatedObject(self, &sb_customKey);
}

- (CBCharacteristic *)sb_storageData {
    return objc_getAssociatedObject(self, &sb_storageDataKey);
}

- (CBCharacteristic *)sb_log {
    return objc_getAssociatedObject(self, &sb_logKey);
}

@end
