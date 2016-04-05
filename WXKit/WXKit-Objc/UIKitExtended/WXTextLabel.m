//
//  WXTextLabel.m
//  WXKit
//
//  Created by Charlie Wu on 6/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXTextLabel.h"
#import "UIView+WXKit.h"

@interface WXTextLabel() 
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *textField;
@end

@implementation WXTextLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _label = [[UILabel alloc] init];
    _label.textColor = [self tintColor];
    _label.font = [UIFont systemFontOfSize:10.0f];
    _label.alpha = 0;

    _textField = [[UILabel alloc] init];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.numberOfLines = 0;
    _textField.textColor = [UIColor colorWithWhite:0.297f alpha:1.0f];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.label];
    [self addSubview:self.textField];// constrains for label
    [self addConstraintWithItem:_label
                      attribute:NSLayoutAttributeTop
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeTop
                       constant:8.0f];

    [self addConstraintWithItem:_label
                      attribute:NSLayoutAttributeLeft
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeLeft
                       constant:8.0f];

    [self addConstraintWithItem:_label
                      attribute:NSLayoutAttributeRight
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeRight
                       constant:8.0f];

    [_label addConstraintWithItem:_label
                        attribute:NSLayoutAttributeHeight
                        relatedBy:NSLayoutRelationEqual
                           toItem:nil
                        attribute:NSLayoutAttributeNotAnAttribute
                         constant:10.0f];

    //constrains for text field
    [self addConstraintWithItem:_textField
                      attribute:NSLayoutAttributeTop
                      relatedBy:NSLayoutRelationEqual
                         toItem:_label
                      attribute:NSLayoutAttributeBottom
                       constant:0.0f];

    [self addConstraintWithItem:_textField
                      attribute:NSLayoutAttributeLeft
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeLeft
                       constant:8.0f];

    [self addConstraintWithItem:_textField
                      attribute:NSLayoutAttributeRight
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeRight
                       constant:8.0f];

    [_textField addConstraintWithItem:_textField
                            attribute:NSLayoutAttributeHeight
                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                               toItem:nil
                            attribute:NSLayoutAttributeNotAnAttribute
                             constant:25.0f];

}

- (void)textFieldDidChange:(NSNotification *)notification
{
    self.textField.text = self.textField.text;
    [self updateViewLayout];
}

- (NSString *)labelText
{
    return self.label.text;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textField.text = text;
    [self updateViewLayout];
}

- (void)setLabelText:(NSString *)labelText
{
    self.label.text = labelText;
    [self updateViewLayout];
}

- (void)updateViewLayout
{
    [self.label.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constrain, NSUInteger idx, BOOL *stop) {
        if (constrain.firstItem == self.label && constrain.firstAttribute == NSLayoutAttributeHeight){
            constrain.constant = self.text.length > 0 ? 10.0f : 2.0f;
            [self.label updateConstraints];
        }
    }];

    if (self.text.length == 0) {
        self.label.alpha = 0.0f;
        self.textField.text = self.labelText;
        self.textField.textColor = [UIColor colorWithWhite:0.614 alpha:1.0f];
    } else {
        self.textField.textColor = [UIColor colorWithWhite:0.297f alpha:1.0f];
        self.label.alpha = 1.0f;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.label.textColor = self.tintColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.label.textColor = [UIColor colorWithWhite:0.66f alpha:1.0f];
}

+ (CGFloat)leftRightPadding
{
    return 16;
}

+ (CGFloat)topBottomPadding
{
    return 16;
}

+ (CGFloat)labelHeight
{
    return 10;
}

+ (CGFloat)defaultHeight
{
    return 46;
}
@end
