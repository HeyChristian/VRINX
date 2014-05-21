//
//  CroperViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/19/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CropperDelegate <NSObject>     //define a protocol named
- (void) setCroppedImage:(UIImage *)image;
@end

@interface CroperViewController : UIViewController


@property (nonatomic, assign) id<CropperDelegate>delegate; //create a delegate

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)cropAction:(id)sender;
- (IBAction)retakeAction:(id)sender;

@property (strong,nonatomic) UIImage *sourceImage;
@property (nonatomic,assign) CGSize croppingSize;

@end
