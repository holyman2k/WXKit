//
//  WXButton.h
//  WXKit
//
//  Created by Charlie Wu on 22/09/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXButton : UIButton

- (instancetype)initWithTitle:(NSString *)title andFrame:(CGRect)frame andAction:(ActionBlock)actionBlock;

- (instancetype)initWithTitle:(NSString *)title andAction:(ActionBlock)actionBlock;

@end
