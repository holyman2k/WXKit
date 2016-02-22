//
//  WXTextLabel.h
//  WXKit
//
//  Created by Charlie Wu on 6/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WXTextLabel : UIView

@property (nonatomic) IBInspectable NSString *text;
@property (nonatomic) IBInspectable NSString *labelText;

+ (CGFloat)leftRightPadding;

+ (CGFloat)topBottomPadding;

+ (CGFloat)labelHeight;

+ (CGFloat)defaultHeight;

@end
