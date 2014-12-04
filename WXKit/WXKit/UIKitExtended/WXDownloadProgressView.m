//
//  WXProgressView.m
//  ReadReddit
//
//  Created by Charlie Wu on 19/11/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXDownloadProgressView.h"
#import <QuartzCore/QuartzCore.h>

@interface WXDownloadProgressView()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *startButton;
@end

@implementation WXDownloadProgressView

@synthesize progress = _progress, lineWidth = _lineWidth;

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self updateProgress];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self updateProgress];
}

- (void)setStarted:(BOOL)started {
    _started = started;
    [self updateProgress];
}

- (void)layoutSubviews {

    if (!self.cancelButton) {
        CGFloat buttonRatio = .3;
        CGRect frame = CGRectMake((1-buttonRatio) * self.frame.size.width / 2,
                                  (1-buttonRatio) * self.frame.size.height / 2,
                                  self.frame.size.width * buttonRatio,
                                  self.frame.size.height * buttonRatio);
        self.cancelButton = [[UIButton alloc] initWithFrame:frame];
        self.cancelButton.backgroundColor = self.tintColor;
        self.cancelButton.layer.borderColor = self.tintColor.CGColor;
        self.cancelButton.layer.cornerRadius = self.frame.size.width * buttonRatio * .15;
        [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
    }

    if (!self.startButton) {
        CGRect frame = self.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        self.startButton = [[UIButton alloc] initWithFrame:frame];
        [self.startButton setBackgroundImage:self.startStateImage forState:UIControlStateNormal];
        [self.startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.startButton];
    }
    [super layoutSubviews];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    if (self.started && [self pointInside:point withEvent:nil]) {
        [self.cancelButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)updateProgress {

    self.progressLayer.hidden = !self.started;
    self.paddingLayer.hidden = !self.started;
    self.startButton.hidden = self.started;
    self.cancelButton.hidden = !self.started;

    if (self.started) {

        if (self.progressLayer) {
            self.progressLayer.strokeEnd = self.progress;
        }
    }
}

- (void)startButtonAction:(id)sender {
    self.started = YES;
    self.progress = 0;
    [self updateProgress];
    if (self.startAction) self.startAction(sender);
}


- (void)cancelButtonAction:(id)sender {
    self.started = NO;
    self.progress = 0;
    [self updateProgress];
    if (self.cancelAction) self.cancelAction(sender);
}
@end
