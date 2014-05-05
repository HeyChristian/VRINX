//
//  UIImage+RoundedImage.m
//  VRINX
//
//  Created by Christian Vazquez on 5/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "UIImage+RoundedImage.h"

@implementation UIImage (RoundedImage)


+ (UIImage *)roundedImageWithImage:(UIImage *)image {
    if (image) {
        CGContextRef cx = CGBitmapContextCreate(NULL, image.size.width, image.size.height, CGImageGetBitsPerComponent(image.CGImage), 0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage));
        
        CGContextBeginPath(cx);
        CGRect pathRect = CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextAddEllipseInRect(cx, pathRect);
        CGContextClosePath(cx);
        CGContextClip(cx);
        
        CGContextDrawImage(cx, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
        
        CGImageRef clippedImage = CGBitmapContextCreateImage(cx);
        CGContextRelease(cx);
        
        UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
        CGImageRelease(clippedImage);
        
        return roundedImage;
    }
    
    return nil;
}
+ (UIImage *)roundedImageWiththumbnailImage:(UIImage *)image {
    if (image) {
        CGContextRef cx = CGBitmapContextCreate(NULL, image.size.width, image.size.height, CGImageGetBitsPerComponent(image.CGImage), 0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage));
        NSLog(@" width: %f  - H: %f",image.size.height,image.size.height);
        CGContextBeginPath(cx);
        CGRect pathRect = CGRectMake(0, 0, 452.5f,452.5f);
        CGContextAddEllipseInRect(cx, pathRect);
        CGContextClosePath(cx);
        CGContextClip(cx);
        
        CGContextDrawImage(cx, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
        
        CGImageRef clippedImage = CGBitmapContextCreateImage(cx);
        CGContextRelease(cx);
        
        UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
        CGImageRelease(clippedImage);
        
        return roundedImage;
    }
    
    return nil;
}



@end
