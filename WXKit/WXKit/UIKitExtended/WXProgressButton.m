//
//  WXProgressButton.m
//  WXKit
//
//  Created by Charlie Wu on 3/06/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import "WXProgressButton.h"
#import "WXButton.h"

@interface WXProgressButton()

@property (nonatomic, strong) WXButton *startButton;
@property (nonatomic, strong) WXButton *cancelButton;

@property (nonatomic) WXProgressButonState buttonState;

@end

@implementation WXProgressButton

#pragma mark - object life cycle

#pragma mark - accessories

- (void)setStartButtonImage:(UIImage *)startButtonImage {
    _startButtonImage = startButtonImage;
    [self setupStartButton];
}

- (void)setStartButtonTitle:(NSString *)startButtonTitle {
    _startButtonTitle = startButtonTitle;
    [self setupStartButton];
}

- (void)setStartButtonImageInsets:(UIEdgeInsets)startButtonImageInsets {
    _startButtonImageInsets = startButtonImageInsets;
    [self setupStartButton];
}

- (void)setCancelButtonRatio:(CGFloat)cancelButtonRatio {
    _cancelButtonRatio = cancelButtonRatio;
    [self setupCancelButton];
}

- (void)setCancelButtonHidden:(BOOL)cancelButtonHidden {
    _cancelButtonHidden = cancelButtonHidden;
    [self setupCancelButton];
}

- (void)setStarted:(BOOL)started {
    _started = started;
    self.buttonState = started ? WXProgressButonStateStarted : WXProgressButonStateStopped;
    [self updateProgress];
}

#pragma mark - view methods

- (void)layoutSubviews {

    [self setupCancelButton];
    [self setupStartButton];
    [super layoutSubviews];
}

#pragma mark - public methods

- (void)start {
    self.started = YES;
}

- (void)stop {
    self.started = NO;
}

#pragma mark - private methods

- (void)setupCancelButton {
    if (!self.cancelButton) {
        self.cancelButton = [[WXButton alloc] init];
    }

    if (self.cancelButtonHidden) {
        [self.cancelButton removeFromSuperview];
    } else {
        [self addSubview:self.cancelButton];
    }

    CGFloat buttonRatio = self.cancelButtonRatio <= 0 ? .3 : self.cancelButtonRatio;
    CGRect frame = CGRectMake((1-buttonRatio) * self.frame.size.width / 2,
                              (1-buttonRatio) * self.frame.size.height / 2,
                              self.frame.size.width * buttonRatio,
                              self.frame.size.height * buttonRatio);
    self.cancelButton.frame = frame;
    self.cancelButton.backgroundColor = self.tintColor;
    self.cancelButton.layer.borderColor = self.tintColor.CGColor;
    self.cancelButton.layer.cornerRadius = self.frame.size.width * buttonRatio * .15;
}

- (void)setupStartButton {
    if (!self.startButton) {
        CGRect frame = self.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        self.startButton = [[WXButton alloc] initWithFrame:frame];

        [self addSubview:self.startButton];
    }

    [self.startButton setTitleColor:self.tintColor forState:UIControlStateNormal];
    [self.startButton setImage:self.startButtonImage forState:UIControlStateNormal];
    [self.startButton setTitle:self.startButtonTitle forState:UIControlStateNormal];
    [self.startButton setImageEdgeInsets:self.startButtonImageInsets];
}

- (void)updateProgress {

    BOOL started = self.buttonState == WXProgressButonStateStarted;

    self.progressLayer.hidden = !started;
    self.paddingLayer.hidden  = self.progressLayer.hidden;

    self.startButton.hidden = started;
    self.cancelButton.hidden = !self.startButton.hidden;

    if (started) {
        if (self.progressLayer) {
            self.progressLayer.strokeEnd = self.progress;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.hidden) return;
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!self.cancelButton.hidden && self.cancelButton.superview != nil && [self pointInside:point withEvent:nil]) {
        [self.cancelButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)tintColorDidChange {
    [self setupStartButton];
}

@end
