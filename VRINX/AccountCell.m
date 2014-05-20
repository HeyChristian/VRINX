//
//  AccountCell.m
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//
#import "UIImage+RoundedImage.h"
#import "AccountCell.h"
#import "EntityAccount.h"
@implementation AccountCell




-(void)configureCellForEntry:(EntityAccount *)account{
    
    NSLog(@" Account: %@",account);
    
    
    if(account.logo){
        
      
        
        UIImage *logo = [UIImage imageWithData:account.logo];
        CGRect rect = CGRectMake(-5,0,320,100);
        UIGraphicsBeginImageContext( rect.size );
        [logo drawInRect:rect];
        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(picture1);
        UIImage *newImage=[UIImage imageWithData:imageData];
        
        CGRect bounds = [self bounds];
        [[UIColor whiteColor] setFill];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToMask(context, bounds, [newImage CGImage]);
        CGContextFillRect(context, bounds);
        
        
        
        //CGSize size = CGSizeMake(320, 120);
        //self.logoView.image = [UIImage imageWithColor:logo andColor:[UIColor whiteColor] andSize:size];
        self.logoView.image = logo;
        
        self.accountName.text = nil;
    }else{
        self.accountName.text = account.name;
        
        //self.logoView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
}

@end
