//
//  MKSBLRGpsFixModel.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/6/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBLRGpsFixModel : NSObject

@property (nonatomic, copy)NSString *timeout;

@property (nonatomic, copy)NSString *threshold;

/// 0:DAS 1:Customer
@property (nonatomic, assign)NSInteger dataType;

/// 0:GPS 1:Beidou 2:GPS&Beidou
@property (nonatomic, assign)NSInteger postionSystem;

@property (nonatomic, assign)BOOL aiding;

@property (nonatomic, copy)NSString *longitude;

@property (nonatomic, copy)NSString *latitude;

@property (nonatomic, assign)BOOL start;

@property (nonatomic, assign)BOOL end;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
