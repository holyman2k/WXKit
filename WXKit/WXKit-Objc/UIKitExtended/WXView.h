//
//  WXBorderedView.h
//  Documents
//
//  Created by Charlie Wu on 25/11/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WXView : UIView

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
