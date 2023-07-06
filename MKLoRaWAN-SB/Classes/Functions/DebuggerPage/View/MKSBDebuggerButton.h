//
//  MKSBDebuggerButton.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/5.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBDebuggerButton : UIControl

@property (nonatomic, strong, readonly)UIImageView *topIcon;

@property (nonatomic, strong, readonly)UILabel *msgLabel;

@end

NS_ASSUME_NONNULL_END
