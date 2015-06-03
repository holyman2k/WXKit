//
//  WXButton.m
//  WXKit
//
//  Created by Charlie Wu on 22/09/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXButton.h"
@import QuartzCore;

@interface WXButton()

@property (nonatomic, strong) ActionBlock actionBlock;

@end

@implementation WXButton

- (instancetype)initWithTitle:(NSString *)title andFrame:(CGRect)frame andAction:(ActionBlock)actionBlock {
    if (self = [self initWithFrame:frame]) {
        _actionBlock = actionBlock;
        self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        [self setTitleColor:[self.tintColor colorWithAlphaComponent:.3] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        self.layer.borderColor = [UIColor colorWithWhite:0.75 alpha:1.0].CGColor;
        self.layer.borderWidth = [UIScreen mainScreen].scale == 1 ? 1 : .5;
        self.layer.cornerRadius = 5;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title andAction:(ActionBlock)actionBlock {
    if (self = [self initWithTitle:title andFrame:CGRectZero andAction:actionBlock]) {}
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.textColor = self.textColor ? self.textColor : self.tintColor;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    self.clipsToBounds = YES;
}

- (void)prepareForInterfaceBuilder {
    [self layoutSubviews];
}

- (void)setAction:(ActionBlock)actionBlock {
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.actionBlock = actionBlock;
}

- (void)action:(id)sender {
    if (self.actionBlock) self.actionBlock(sender);
}

- (void)tintColorDidChange {
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    [self setTitleColor:[self.tintColor colorWithAlphaComponent:.3] forState:UIControlStateHighlighted];
}

@end
