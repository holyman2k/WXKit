//
//  UIView+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WXKit)

- (UIImage *)screenshot;

- (NSLayoutConstraint *)addConstraintWithItem:(id)view1
                                   attribute:(NSLayoutAttribute)attr1
                                   relatedBy:(NSLayoutRelation)relation
                                      toItem:(id)view2
                                   attribute:(NSLayoutAttribute)attr2
                                    constant:(CGFloat)c;

- (NSLayoutConstraint *)addConstraintWithItem:(id)view1
                                    attribute:(NSLayoutAttribute)attr1
                                    relatedBy:(NSLayoutRelation)relation
                                       toItem:(id)view2
                                    attribute:(NSLayoutAttribute)attr2
                                     constant:(CGFloat)c
                                     priority:(UILayoutPriority)priority;

- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)attr
                                            toItem:(id)view1
                                         attribute:(NSLayoutAttribute)attr1
                                         relatedBy:(NSLayoutRelation)relation
                                          constant:(CGFloat)c;

- (NSLayoutConstraint *)addEqualConstraint:(NSLayoutAttribute)attr
                               toChildView:(UIView *)childView
                                   contant:(CGFloat)c;

- (NSLayoutConstraint *)addConstraint:(NSLayoutAttribute)attr
                              contant:(CGFloat)c;

- (NSLayoutConstraint *)heightConstraint;

- (NSLayoutConstraint *)widthConstraint;

@end
