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

@property (nonatomic, strong) IBInspectable UIImage *startStateImage;
@property (nonatomic) IBInspectable BOOL started;

@property (nonatomic, strong) void(^startAction)(UIButton *sender);
@property (nonatomic, strong) void(^cancelAction)(UIButton *sender);

@end
