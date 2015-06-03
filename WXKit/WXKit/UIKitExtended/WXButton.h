//
//  WXButton.h
//  WXKit
//
//  Created by Charlie Wu on 22/09/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WXButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

- (instancetype)initWithTitle:(NSString *)title andFrame:(CGRect)frame andAction:(ActionBlock)actionBlock;

- (instancetype)initWithTitle:(NSString *)title andAction:(ActionBlock)actionBlock;

- (void)setAction:(ActionBlock)actionBlock;

@end
