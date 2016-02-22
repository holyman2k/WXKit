//
//  WXProgressView.m
//  Documents
//
//  Created by Charlie Wu on 4/12/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXProgressView.h"

@interface WXProgressView()

@property (nonatomic, strong) CAShapeLayer *paddingLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation WXProgressView

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self updateProgress];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self updateProgress];
}

- (void)layoutSubviews {

    [super layoutSubviews];

    CGFloat paddingRatio = self.trackingCircleSizeRatio == 0 ? 1 : self.trackingCircleSizeRatio;
    CGFloat paddingLayerWidth = self.lineWidth * paddingRatio;
    CGRect paddingRect = CGRectInset(self.bounds, paddingLayerWidth / paddingRatio, paddingLayerWidth / paddingRatio);
    CGRect progressRect = CGRectInset(self.bounds, self.lineWidth, self.lineWidth);

    UIBezierPath *paddingPath = [UIBezierPath bezierPathWithOvalInRect:paddingRect];
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithOvalInRect:progressRect];
    progressPath.lineCapStyle = kCGLineCapRound;

    if (!self.paddingLayer && self.showTrackingCircle) {
        self.paddingLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:self.paddingLayer];
        self.paddingLayer.path = paddingPath.CGPath;
        self.paddingLayer.fillColor = nil;
        self.paddingLayer.lineWidth = paddingLayerWidth;
        self.paddingLayer.strokeColor = [UIColor colorWithWhite:0 alpha:.1].CGColor;
    }

    if (!self.progressLayer) {
        self.progressLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:self.progressLayer];
        self.progressLayer.lineCap = kCALineCapRound;
        self.progressLayer.path = paddingPath.CGPath;
        self.progressLayer.fillColor = nil;
        self.progressLayer.lineWidth = self.lineWidth;
        self.progressLayer.strokeColor = self.tintColor.CGColor;
        self.progressLayer.transform = CATransform3DRotate(self.progressLayer.transform, -M_PI / 2, 0, 0, 1);
    }


    self.paddingLayer.frame = self.layer.bounds;
    self.progressLayer.frame = self.layer.bounds;

    [self updateProgress];
}

- (void)updateProgress {

    if (self.progressLayer) {
        self.progressLayer.strokeEnd = self.progress;
    }
}


@end
