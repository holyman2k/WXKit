//
//  WXLabel.h
//  Documents
//
//  Created by Charlie Wu on 26/11/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WXLabel : UILabel

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat topBottomPadding;
@property (nonatomic) IBInspectable CGFloat leftRightPadding;
@end
