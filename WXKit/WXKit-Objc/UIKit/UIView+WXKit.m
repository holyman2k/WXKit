//
//  UIView+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

@implementation UIView (WXKit)

- (UIImage *)screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (NSLayoutConstraint *)heightConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self || constraint.firstAttribute == NSLayoutAttributeHeight) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint *)widthConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self || constraint.firstAttribute == NSLayoutAttributeWidth) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint *)addEqualConstraint:(NSLayoutAttribute)attr
                               toChildView:(UIView *)childView
                                   contant:(CGFloat)c {
    NSAssert(![(UIView *) childView translatesAutoresizingMaskIntoConstraints], @"translate autoresizing mask into constrains must be turned off");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:attr
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:childView
                                                                  attribute:attr
                                                                 multiplier:1
                                                                   constant:c];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)constraintWithIdentifier:(NSString *)identifier {
    return [self.constraints firstObjectPassTest:^BOOL(NSLayoutConstraint *constraint) {
        return [constraint.identifier isEqualToString:identifier];
    }];
}

- (NSLayoutConstraint *)addConstraint:(NSLayoutAttribute)attr
                              contant:(CGFloat)c {
    NSAssert(attr == NSLayoutAttributeWidth || attr == NSLayoutAttributeHeight, @"only can add with or height layout attribute");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:attr
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:c];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addConstraintAttribute:(NSLayoutAttribute)attr1
                                   toChildView:(UIView *)childView
                                 withAttribute:(NSLayoutAttribute)attr2
                                     relatedBy:(NSLayoutRelation)relation
                                      constant:(CGFloat)constant
                                      priority:(UILayoutPriority)priority {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:childView attribute:attr2 relatedBy:relation toItem:self attribute:attr1 multiplier:1 constant:constant];
    constraint.priority = priority;
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addConstraintWithItem:(id)view1
                                    attribute:(NSLayoutAttribute)attr1
                                    relatedBy:(NSLayoutRelation)relation
                                       toItem:(id)view2
                                    attribute:(NSLayoutAttribute)attr2
                                     constant:(CGFloat)c {
    NSLayoutConstraint *constrain = [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
    [self addConstraint:constrain];
    return constrain;
}

- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)attr
                                            toItem:(id)view1
                                         attribute:(NSLayoutAttribute)attr1
                                         relatedBy:(NSLayoutRelation)relation
                                          constant:(CGFloat)c {
    NSAssert(![(UIView *) view1 translatesAutoresizingMaskIntoConstraints], @"translate autoresizing mask into constrains must be turned off");
    NSLayoutConstraint *constrain = [NSLayoutConstraint constraintWithItem:self attribute:attr relatedBy:relation toItem:view1 attribute:attr1 multiplier:1 constant:c];
    [self addConstraint:constrain];
    return constrain;
}

- (NSLayoutConstraint *)addConstraintWithItem:(id)view1
                                    attribute:(NSLayoutAttribute)attr1
                                    relatedBy:(NSLayoutRelation)relation
                                       toItem:(id)view2
                                    attribute:(NSLayoutAttribute)attr2
                                     constant:(CGFloat)c
                                     priority:(UILayoutPriority)priority {
    NSLayoutConstraint *constrain = [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:1 constant:c];
    constrain.priority = priority;
    [self addConstraint:constrain];
    return constrain;
}

@end
