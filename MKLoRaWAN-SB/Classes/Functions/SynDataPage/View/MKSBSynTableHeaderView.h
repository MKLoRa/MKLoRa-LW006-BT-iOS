//
//  MKSBSynTableHeaderView.h
//  MKLoRaWAN-SB_Example
//
//  Created by aa on 2023/7/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKCustomUIModule/MKTextField.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSBMsgIconButton : UIControl

@property (nonatomic, strong)UIImageView *topIcon;

@property (nonatomic, strong)UILabel *msgLabel;

@end

@interface MKSBSynTableHeaderView : UIView

@property (nonatomic, strong, readonly)MKTextField *textField;

@property (nonatomic, strong, readonly)UIButton *startButton;

@property (nonatomic, strong, readonly)MKSBMsgIconButton *synButton;

@property (nonatomic, strong, readonly)MKSBMsgIconButton *emptyButton;

@property (nonatomic, strong, readonly)MKSBMsgIconButton *exportButton;

@property (nonatomic, strong, readonly)UILabel *sumLabel;

@property (nonatomic, strong, readonly)UILabel *countLabel;

@end

NS_ASSUME_NONNULL_END
