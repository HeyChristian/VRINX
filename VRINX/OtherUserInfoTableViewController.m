//
//  OtherUserInfoTableViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OtherUserInfoTableViewController.h"
#import "UIImage+RoundedImage.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface OtherUserInfoTableViewController ()

@end

@implementation OtherUserInfoTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self loadUser];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     [self.navigationItem setHidesBackButton:YES animated:YES];
    
  
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 // Return the number of rows in the section.
    return 5;
}*/






- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 5.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
    
    if((indexPath.row == 0 && indexPath.section ==0) || (indexPath.row == 0 && indexPath.section == 3)){
        UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero]  init];
        backView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = backView;
    }
    
}
- (IBAction)changeProfilePicture:(id)sender {
    
    if(self.image == nil){
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
        self.imagePicker.videoMaximumDuration = 10;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
        
        
    }
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)setSquaredConernersToImageView {
    self.imageProfile.layer.cornerRadius = self.imageProfile.frame.size.width / 2;
    self.imageProfile.clipsToBounds = YES;
    
    self.imageProfile.layer.cornerRadius = 10.0f;
    
    self.imageProfile.layer.borderWidth = 3.0f;
    self.imageProfile.layer.borderColor = [UIColor whiteColor].CGColor;
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        // A photo was taken/seleted
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if(self.imagePicker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
            // UIImageWriteToSavedPhotosAlbum(self.image, nil,nil,nil);
            // self.profilePictureField.image = self.image;
            
            
           // UIImage *myRoundedImage = [UIImage roundedImageWithImage:self.image];
            
            
           /// UIImage *small = [UIImage imageWithCGImage:myRoundedImage.CGImage scale:0.05 orientation:myRoundedImage.imageOrientation];
            
            //self.image = small;
            [self.imageProfile setImage:self.image];
            NSLog(@" image : %@",self.image);
           
            [self setSquaredConernersToImageView];
            
        }
        
    }
    
    
   

    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)finishSetup:(id)sender {
  //  NSData *fileData =nil;
    
  //  if( self.image != nil){
        
     // *fileData = UIImagePNGRepresentation(self.image);
       // self.haveProfilePicture= @"YES";
     
        
        //self.file = [PFFile fileWithName:@"Image.png" data:fileData];
        
        /*
        [self.file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occurred!"
                                                                    message:@"Please try again!"
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }else{
             
                self.haveProfilePicture= @"YES";
            }
        }];
        */
//}

    
    NSString *firstname = [self.firstNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    NSString *lastname = [self.lastNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    NSString *mobile= [self.phoneNumberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    
    
    
    PFUser *user = [PFUser currentUser];
    
    user[@"Firstname"]=firstname;
    user[@"LastName"]=lastname;
    user[@"Mobile"]=mobile;
    
    
    
    if (self.image != nil){
       
      // NSData *fileData = UIImageJPEGRepresentation(self.image, 0.6); //UIImagePNGRepresentation(self.image);
       
        // Resize image
       // UIGraphicsBeginImageContext(CGSizeMake(640, 960));
       // [self.image drawInRect: CGRectMake(0, 0, 640, 960)];
       // UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
       // UIGraphicsEndImageContext();
        
       NSData *imageData = UIImageJPEGRepresentation(self.image, 0.05f);
       
        self.file = [PFFile fileWithName:@"Image.png" data:imageData];
        [self.file save];
        
        user[@"Image"]=self.file;
        
        //[newUser setObject:self.file forKey:@"ProfilePicture"];
    }
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
        
        if(error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                message:[error.userInfo objectForKey:@"error"]
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        }else{
            // [self dismissModalViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
           //  [self.navigationController popToRootViewControllerAnimated:YES];
            
            //  [self performSegueWithIdentifier:@"GoHome" sender:self];
            
        }
    }];
    
    
}


- (void)loadUser {
    PFUser *user = [PFUser currentUser];
    
    PFFile *imageFile = [user objectForKey:@"Image"];
    NSLog(@"Image Data URL: %@",imageFile.url);
    
    /*
     NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
     NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
     self.imageProfile.image = [UIImage imageWithData:imageData];
     [self setSquaredConernersToImageView];
     */
    NSLog(@"Object ID: %@",user.objectId);
    
    self.firstNameField.text = [user objectForKey:@"Firstname"];
    self.lastNameField.text = [user objectForKey:@"LastName"];
    self.phoneNumberField.text = [user objectForKey:@"Mobile"];
    
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:user.objectId];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            // for (PFObject *object in objects) {
            //    NSLog(@"%@", object.objectId);
            //}
            PFUser *u = objects[0];
            
            PFFile *imageFile = [u objectForKey:@"Image"];
            NSLog(@"Image Data URL: %@",imageFile.url);
            if(imageFile.url != nil){
                NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
                NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
                self.imageProfile.image = [UIImage imageWithData:imageData];
                [self setSquaredConernersToImageView];
            }
            
            
            self.firstNameField.text = [u objectForKey:@"Firstname"];
            self.lastNameField.text =[u objectForKey:@"LastName"];
            self.phoneNumberField.text = [u objectForKey:@"Mobile"];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
