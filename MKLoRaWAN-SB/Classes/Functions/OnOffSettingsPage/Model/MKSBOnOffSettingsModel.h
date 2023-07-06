//
//  MKSBOnOffSettingsModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBOnOffSettingsModel : NSObject

@property (nonatomic, assign)BOOL payload;

@property (nonatomic, assign)BOOL button;

@property (nonatomic, assign)BOOL powerOff;

@property (nonatomic, assign)BOOL powerOn;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
