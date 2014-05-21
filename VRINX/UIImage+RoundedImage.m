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
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
+(UIImage *)squaredImageWithImage:(UIImage *)image{
    
    
    return image;
}
+ (UIImage *)imageWithColor:(UIImage *)image andColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = image;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


+ (UIImage *) resizeToSize:(UIImage *)image andSize:(CGSize)newSize thenCropWithRect:(CGRect) cropRect {
    CGContextRef                context;
    CGImageRef                  imageRef;
    CGSize                      inputSize;
    UIImage                     *outputImage = nil;
    CGFloat                     scaleFactor, width;
    
    // resize, maintaining aspect ratio:
    
    inputSize = image.size;
    scaleFactor = newSize.height / inputSize.height;
    width = roundf( inputSize.width * scaleFactor );
    
    if ( width > newSize.width ) {
        scaleFactor = newSize.width / inputSize.width;
        newSize.height = roundf( inputSize.height * scaleFactor );
    } else {
        newSize.width = width;
    }
    
    UIGraphicsBeginImageContext( newSize );
    
    context = UIGraphicsGetCurrentContext();
    CGContextDrawImage( context, CGRectMake( 0, 0, newSize.width, newSize.height ), image.CGImage );
    outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    inputSize = newSize;
    
    // constrain crop rect to legitimate bounds
    if ( cropRect.origin.x >= inputSize.width || cropRect.origin.y >= inputSize.height ) return outputImage;
    if ( cropRect.origin.x + cropRect.size.width >= inputSize.width ) cropRect.size.width = inputSize.width - cropRect.origin.x;
    if ( cropRect.origin.y + cropRect.size.height >= inputSize.height ) cropRect.size.height = inputSize.height - cropRect.origin.y;
    
    // crop
    if ( ( imageRef = CGImageCreateWithImageInRect( outputImage.CGImage, cropRect ) ) ) {
        outputImage = [[UIImage alloc] initWithCGImage: imageRef];
        CGImageRelease( imageRef );
    }
    
    return outputImage;
}
@end
