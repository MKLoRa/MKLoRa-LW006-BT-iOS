//
//  MKSBDFUModule.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBDFUModule : NSObject

- (void)updateWithFileUrl:(NSString *)url
            progressBlock:(void (^)(CGFloat progress))progressBlock
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
