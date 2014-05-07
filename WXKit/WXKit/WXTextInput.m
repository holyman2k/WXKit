//
//  WXTextInput.m
//  WXKit
//
//  Created by Charlie Wu on 5/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXTextInput.h"

@interface WXTextInput() <UITextFieldDelegate>
@property (strong, nonatomic) UILabel *labelValidation;
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_textField];
    }
    return self;
}

- (void)initialize
{
    _labelValidation = [[UILabel alloc] init];
    _labelValidation.textColor = [UIColor colorWithRed:0.841f green:0.231f blue:0.189f alpha:1.000f];
    _labelValidation.font = [UIFont systemFontOfSize:12.0f];
    _labelValidation.alpha = 0;

    _label = [[UILabel alloc] init];
    _label.textColor = [self tintColor];
    _label.font = [UIFont systemFontOfSize:10.0f];
    _label.alpha = 0;

    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = [UIColor colorWithWhite:0.297f alpha:1.0f];
    _textField.delegate = self;

    _labelValidation.translatesAutoresizingMaskIntoConstraints = NO;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_labelValidation];
    [self addSubview:_label];
    [self addSubview:_textField];

    // constrains for label validation
    [self addConstraintWithItem:_labelValidation
                      attribute:NSLayoutAttributeTop
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeTop
                       constant:0.0f];

    [self addConstraintWithItem:_labelValidation
                      attribute:NSLayoutAttributeLeft
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeLeft
                       constant:0.0f];

    [self addConstraintWithItem:_labelValidation
                      attribute:NSLayoutAttributeRight
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeRight
                       constant:0.0f];

    [_label addConstraintWithItem:_labelValidation
                        attribute:NSLayoutAttributeHeight
                        relatedBy:NSLayoutRelationEqual
                           toItem:nil
                        attribute:NSLayoutAttributeNotAnAttribute
                         constant:0.0f];

    // constrains for label
    [self addConstraintWithItem:_label
                      attribute:NSLayoutAttributeTop
                      relatedBy:NSLayoutRelationEqual
                         toItem:_labelValidation
                      attribute:NSLayoutAttributeTop
                       constant:0.0f];

    [self addConstraintWithItem:_label
                      attribute:NSLayoutAttributeLeft
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeLeft
                       constant:0.0f];

    [self addConstraintWithItem:_label
                      attribute:NSLayoutAttributeRight
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeRight
                       constant:0.0f];

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
                         toItem:self
                      attribute:NSLayoutAttributeTop
                       constant:10.0f];

    [self addConstraintWithItem:_textField
                      attribute:NSLayoutAttributeLeft
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeLeft
                       constant:0.0f];

    [self addConstraintWithItem:_textField
                      attribute:NSLayoutAttributeRight
                      relatedBy:NSLayoutRelationEqual
                         toItem:self
                      attribute:NSLayoutAttributeRight
                       constant:0.0f];

    [_textField addConstraintWithItem:_textField
                            attribute:NSLayoutAttributeHeight
                            relatedBy:NSLayoutRelationEqual
                               toItem:nil
                            attribute:NSLayoutAttributeNotAnAttribute
                             constant:25.0f
                             priority:UILayoutPriorityDefaultHigh];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.textField.isFirstResponder) [self.textField becomeFirstResponder];
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
    CGFloat height = self.frame.size.height;
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constrain, NSUInteger idx, BOOL *stop) {
        if (constrain.firstItem == self.textField && constrain.firstAttribute == NSLayoutAttributeTop){
            constrain.constant = self.text.length > 0 ? 10.0f : (height - 25) / 2;
            [self.label updateConstraints];
        }
    }];

    if (self.textField.text.length == 0) {
        self.label.alpha = 0.0f;
        self.textField.placeholder = self.labelText;
    } else {
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
