//
//  MKNormalService.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2025/3/4.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKBaseService.h"

#import "MKNetworkDefine.h"
#import "MKNetworkingStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKUserCreateDeviceModel : NSObject

@property (nonatomic, copy)NSString *macAddress;

/// 是否是正式环境
@property (nonatomic, assign)BOOL isHome;

/*
 设备类型
 0:LW001-BG PRO
 1:LW004-PB
 2:LW005-MP
 3:LW006
 4:LW007-PIR
 5:LW008-MT
 */
@property (nonatomic, assign)NSInteger deviceType;

/// 网关ID，空或者八个字节
@property (nonatomic, copy)NSString *gwId;

/*
 0:AS923
 1:EU868
 2:US915-0
 3:US915-1
 4:AU915-0
 5:AU915-1
 */
@property (nonatomic, assign)NSInteger region;

/// 登录用户名
@property (nonatomic, copy)NSString *username;

- (NSDictionary *)params;

@end

@interface MKNormalService : MKBaseService

/// 用户登录服务器
/// - Parameters:
///   - username: 用户名
///   - password: 密码
///   - isHome: YES:正式环境 NO:测试环境
///   - sucBlock: 成功回调
///   - failBlock: 失败回调
- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                   isHome:(BOOL)isHome
                 sucBlock:(MKNetworkRequestSuccessBlock)sucBlock
                failBlock:(MKNetworkRequestFailureBlock)failBlock;

/// 取消调用登陆接口
- (void)cancelLogin;

/// 创建设备
/// - Parameters:
///   - deviceModel: deviceModel
///   - token:  登录的token
///   - sucBlock: 成功回调
///   - failBlock: 失败回调
- (void)addDeviceToCloud:(MKUserCreateDeviceModel *)deviceModel
                   token:(NSString *)token
                sucBlock:(MKNetworkRequestSuccessBlock)sucBlock
               failBlock:(MKNetworkRequestFailureBlock)failBlock;

/// 取消创建设备接口
- (void)cancelAddDevice;

@end

NS_ASSUME_NONNULL_END
