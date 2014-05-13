//
//  AccountEditTableViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "AccountEditTableViewController.h"
#import "CoreDataStack.h"
#import "EntityAccount.h"

@interface AccountEditTableViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImage *pickedImage;

@end

@implementation AccountEditTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if(self.account != nil){
        // edit mode
        
        self.accountNameField.text = self.account.name;
        self.descriptionField.text= self.account.shortDesc;
        self.salesTaxField.text = [NSString stringWithFormat:@"%@", self.account.tax];
        self.earningPercentField.text = [NSString stringWithFormat:@"%@", self.account.earningPercent];
        self.pickedImage = [UIImage imageWithData:self.account.logo];
        self.logoView.image = self.pickedImage;
        
        
        
    }else{
        
        /*
        self.accountNameField.text = nil;
        self.descriptionField.text= nil;
        self.salesTaxField.text = nil;
        self.earningPercentField.text = nil;
        */

    }
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage =  image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) createAccount{
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    EntityAccount *account = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:coreDataStack.managedObjectContext];
    
    account.name = self.accountNameField.text;
    account.shortDesc = self.descriptionField.text;
    account.tax = [NSDecimalNumber decimalNumberWithString:self.salesTaxField.text];
    account.earningPercent =[NSDecimalNumber decimalNumberWithString:self.earningPercentField.text];
    account.logo = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    
    
    //entry.body = self.textView.text;
    //entry.date = [[NSDate date] timeIntervalSince1970];
    //entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    //entry.location = self.location;
    
    
    [coreDataStack saveContext];
    
    
}
-(void) updateAccount{
    
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}*/


//}
-(void)dismissSelf{
   // [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
   // [self popToViewController:object animated:YES];
     [self.navigationController popViewControllerAnimated: YES];
    
  //   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    if(self.account != nil){
        [self updateAccount];
    }else{
        [self createAccount];
    }
    
    [self dismissSelf];
    
    
}

- (IBAction)changeLogo:(id)sender {
    
    //if device have camera
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self promptForSource];
    }else{
        [self promptForPhotoRoll];
    }
    
}
-(void) promptForSource{
    UIActionSheet *actionSheed = [[UIActionSheet alloc] initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Roll", nil];
    
    [actionSheed showInView:self.view];
    
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != actionSheet.cancelButtonIndex){
        if(buttonIndex != actionSheet.firstOtherButtonIndex){
            [self promptForCamera];
        }else{
            [self promptForPhotoRoll];
        }
    }
}

-(void)promptForCamera{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)promptForPhotoRoll{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void) setPickedImage:(UIImage *)pickedImage{
    _pickedImage = pickedImage;
    if(pickedImage == nil){
        self.logoView.image  = [UIImage imageNamed:@"icn_noimage"];
    }else{
        self.logoView.image = pickedImage;
    }
}

@end
