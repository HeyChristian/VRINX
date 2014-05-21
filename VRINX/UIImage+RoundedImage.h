//
//  UIImage+RoundedImage.h
//  VRINX
//
//  Created by Christian Vazquez on 5/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedImage)

+(UIImage *)roundedImageWithImage:(UIImage *)image;
+(UIImage *)roundedImageWiththumbnailImage:(UIImage *)image;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(UIImage *)squaredImageWithImage:(UIImage *)image;
+ (UIImage *)imageWithColor:(UIImage *)image andColor:(UIColor *)color andSize:(CGSize)size;

+ (UIImage *) resizeToSize:(UIImage *)image andSize:(CGSize)newSize thenCropWithRect:(CGRect) cropRect;
@end
