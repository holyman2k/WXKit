//
//  WXTextInput.m
//  WXKit
//
//  Created by Charlie Wu on 5/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXTextInput.h"

@interface WXTextInput() <UITextFieldDelegate>
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textField;
@end

@implementation WXTextInput


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
    _label.textColor = self.tintColor;
    _label.font = [UIFont systemFontOfSize:10.0f];
    _label.alpha = 0;

    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = [UIColor colorWithWhite:0.297f alpha:1.0f];
    _textField.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_textField];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.textField.isFirstResponder) [self.textField becomeFirstResponder];
}

- (void)layoutSubviews
{
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.label];
    [self addSubview:self.textField];

    // constrains for label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0f
                                                      constant:8.0f]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0f
                                                      constant:8.0f]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0f
                                                      constant:8.0f]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:10.0f]];

    //constrains for text field
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.label
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0f
                                                      constant:0.0f]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0f
                                                      constant:8.0f]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0f
                                                      constant:8.0f]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:25.0f]];


    [super layoutSubviews];

}

- (void)textFieldDidChange:(NSNotification *)notification
{
    self.textField.text = self.textField.text;
    [self updateViewLayout];
}

- (NSString *)text
{
    return self.textField.text;
}

- (NSString *)labelText
{
    return self.label.text;
}

- (void)setText:(NSString *)text
{
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
    [UIView animateWithDuration:.3 animations:^{
        if (self.textField.text.length == 0) {
            self.label.alpha = 0.0f;
            self.textField.placeholder = self.labelText;
        } else {
            self.label.alpha = 1.0f;
        }
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.label.textColor = self.tintColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.label.textColor = [UIColor colorWithWhite:0.66f alpha:1.0f];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
