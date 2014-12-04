//
//  WXBorderedView.m
//  Documents
//
//  Created by Charlie Wu on 25/11/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXView.h"

@implementation WXView

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self updateStyle];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self updateStyle];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self updateStyle];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateStyle];
}

- (void)updateStyle {

    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
}

@end
