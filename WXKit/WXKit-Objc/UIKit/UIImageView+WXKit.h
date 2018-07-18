//
//  UIImageView+WXKit.h
//  PagedPhotoView
//
//  Created by Charlie Wu on 13/02/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WXKit)

- (CGSize)sizeThatFitInSize:(CGSize)size;

- (void)fitIntoSize:(CGSize)size;

- (void)setImageAsync:(UIImage *(^)())loadingBlock;

- (void)setImageAsync:(UIImage *(^)())loadingBlock completion:(void(^)())completion;

@end
