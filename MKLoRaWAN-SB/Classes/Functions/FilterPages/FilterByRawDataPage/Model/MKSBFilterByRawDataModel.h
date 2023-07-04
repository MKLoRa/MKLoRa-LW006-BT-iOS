//
//  MKSBFilterByRawDataModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 20236/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBFilterByRawDataModel : NSObject

@property (nonatomic, assign)BOOL iBeacon;

@property (nonatomic, assign)BOOL uid;

@property (nonatomic, assign)BOOL url;

@property (nonatomic, assign)BOOL tlm;

@property (nonatomic, assign)BOOL bxpBeacon;

@property (nonatomic, assign)BOOL bxpDeviceInfo;

@property (nonatomic, assign)BOOL bxpAcc;

@property (nonatomic, assign)BOOL bxpTH;

@property (nonatomic, assign)BOOL bxpButton;

@property (nonatomic, assign)BOOL bxpTag;

@property (nonatomic, assign)BOOL pir;

@property (nonatomic, assign)BOOL other;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
