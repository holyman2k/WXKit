//
//  WXBarButtonItem.m
//  WXKit
//
//  Created by Charlie Wu on 22/09/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

@interface WXBarButtonItem ()

@property(nonatomic, strong) ActionBlock actionBlock;

@end

@implementation WXBarButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(ActionBlock)actionBlock {
    if (self = [self initWithTitle:title style:style target:self action:@selector(action:)]) {
        _actionBlock = actionBlock;
    }

    return self;
}

- (instancetype)initWithSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(ActionBlock)actionBlock {

    if (self = [self initWithBarButtonSystemItem:systemItem target:nil action:nil]) {
        _actionBlock = actionBlock;
    }
    return self;
}

- (void)action:(id)sender {
    if (self.actionBlock) self.actionBlock(sender);
}

@end
