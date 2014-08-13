//
//  WXTextLabel.h
//  WXKit
//
//  Created by Charlie Wu on 6/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXTextLabel : UIView

@property (nonatomic) NSString *text;
@property (nonatomic) NSString *labelText;

+ (CGFloat)leftRightPadding;

+ (CGFloat)topBottomPadding;

+ (CGFloat)labelHeight;

+ (CGFloat)defaultHeight;

@end
