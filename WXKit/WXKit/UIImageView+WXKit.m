//
//  UIImageView+WXKit.m
//  PagedPhotoView
//
//  Created by Charlie Wu on 13/02/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "UIImageView+WXKit.h"

@implementation UIImageView (WXKit)

- (CGSize)sizeThatFitInSize:(CGSize)size
{
    double newWidth;
    double newHeight;

    UIImage *image = self.image;

    if (image.size.height >= image.size.width) {
        newHeight = size.height;
        newWidth = (image.size.width / image.size.height ) * newHeight;

        if (newWidth > size.width){
            CGFloat diff = (newWidth - size.width) / newWidth;
            newHeight = newHeight - diff * newHeight;
            newWidth= size.width;
        }
    }
    else {
        newWidth = size.width;
        newHeight = size.width / image.size.width * image.size.height;
        if (newHeight > size.height) {
            CGFloat diff = (newHeight - size.height) / newHeight;
            newWidth = newWidth - newWidth * diff;
            newHeight = size.height;
        }
    }
    return CGSizeMake(newWidth, newHeight);
}

- (void)fitIntoSize:(CGSize)size
{
    CGSize fitSize = [self sizeThatFitInSize:size];
    CGRect frame = self.frame;
    frame.size = fitSize;
    self.frame = frame;
}

@end
