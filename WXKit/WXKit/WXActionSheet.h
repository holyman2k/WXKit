//
//  WXActionSheet.h
//  WXKit
//
//  Created by Charlie Wu on 30/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WXActionSheetBlock)(void);

@interface WXActionSheet : UIActionSheet

- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)addButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action;

- (instancetype)addCancelButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action;

- (instancetype)addDesctructiveButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action;

@end
