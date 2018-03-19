//
//  WXProgressButton.h
//  WXKit
//
//  Created by Charlie Wu on 3/06/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import "WXProgressView.h"

@class WXButton;

@interface WXProgressButton : WXProgressView

@property (nonatomic) IBInspectable CGFloat cancelButtonRatio;
@property (nonatomic, strong) IBInspectable UIImage *startButtonImage;
@property (nonatomic, strong) IBInspectable NSString *startButtonTitle;
@property (nonatomic) IBInspectable UIEdgeInsets startButtonImageInsets;

//! @brief default to no
@property (nonatomic, getter=isCancelButtonHidden) IBInspectable BOOL cancelButtonHidden;

@property (nonatomic, getter=isStarted) IBInspectable BOOL started;

@property (nonatomic, readonly) WXButton *startButton;
@property (nonatomic, readonly) WXButton *cancelButton;

@end
