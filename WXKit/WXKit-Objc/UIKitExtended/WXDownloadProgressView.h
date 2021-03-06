//
//  WXProgressView.h
//  ReadReddit
//
//  Created by Charlie Wu on 19/11/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXProgressView.h"

IB_DESIGNABLE
@interface WXDownloadProgressView : WXProgressView

@property (nonatomic) IBInspectable CGFloat cancelButtonRatio;
@property (nonatomic, strong) IBInspectable UIImage *startStateImage;
@property (nonatomic, getter=isStarted) IBInspectable BOOL started;
@property (nonatomic, getter=isCancellable) IBInspectable BOOL cancellable;

@property (nonatomic, strong) void(^startAction)(UIButton *sender);
@property (nonatomic, strong) void(^cancelAction)(UIButton *sender);

@end
