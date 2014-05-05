//
//  OtherUserInfoTableViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface OtherUserInfoTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageProfile;

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberField;



@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) PFFile *file;
@property (nonatomic,retain) NSString *haveProfilePicture;

- (IBAction)changeProfilePicture:(id)sender;
- (IBAction)finishSetup:(id)sender;
@end
