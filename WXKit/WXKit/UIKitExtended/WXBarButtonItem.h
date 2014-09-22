//
//  WXBarButtonItem.h
//  WXKit
//
//  Created by Charlie Wu on 22/09/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXBarButtonItem : UIBarButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(ActionBlock)actionBlock;

@end
