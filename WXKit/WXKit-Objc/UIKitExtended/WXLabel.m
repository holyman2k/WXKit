//
//  WXLabel.m
//  Documents
//
//  Created by Charlie Wu on 26/11/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXLabel.h"
#import "UILabel+WXKit.h"

@implementation WXLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    self.clipsToBounds = YES;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width = size.width + self.leftRightPadding * 2;
    return size;
}


@end
