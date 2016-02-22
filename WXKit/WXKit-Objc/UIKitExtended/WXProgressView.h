//
//  WXProgressView.h
//  Documents
//
//  Created by Charlie Wu on 4/12/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WXProgressView : UIView

@property (nonatomic, readonly) CAShapeLayer *paddingLayer;
@property (nonatomic, readonly) CAShapeLayer *progressLayer;

@property (nonatomic) IBInspectable CGFloat progress;
@property (nonatomic) IBInspectable CGFloat lineWidth;
@property (nonatomic) IBInspectable BOOL showTrackingCircle;
@property (nonatomic) IBInspectable CGFloat trackingCircleSizeRatio;

@end
