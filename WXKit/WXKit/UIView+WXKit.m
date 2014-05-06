//
//  UIView+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "UIView+WXKit.h"

@implementation UIView (WXKit)

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

    return image;
}

- (NSLayoutConstraint *)addConstraintWithItem:(id)view1
                                   attribute:(NSLayoutAttribute)attr1
                                   relatedBy:(NSLayoutRelation)relation
                                      toItem:(id)view2
                                   attribute:(NSLayoutAttribute)attr2
                                    constant:(CGFloat)c
{
    NSLayoutConstraint *constrain = [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
    [self addConstraint:constrain];
    return constrain;
}

- (NSLayoutConstraint *)addConstraintWithItem:(id)view1
                                    attribute:(NSLayoutAttribute)attr1
                                    relatedBy:(NSLayoutRelation)relation
                                       toItem:(id)view2
                                    attribute:(NSLayoutAttribute)attr2
                                     constant:(CGFloat)c
                                     priority:(UILayoutPriority)priority
{
    NSLayoutConstraint *constrain = [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
    constrain.priority = priority;
    [self addConstraint:constrain];
    return constrain;
}
@end
