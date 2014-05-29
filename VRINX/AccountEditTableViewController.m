//
//  AccountEditTableViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//
#import "UIImage+RoundedImage.h"
#import "AccountEditTableViewController.h"
#import "CoreDataStack.h"
#import "EntityAccount.h"
#import "AccountDetail.h"
#import "CroperViewController.h"
#import "GlobalResource.h"


@interface AccountEditTableViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CropperDelegate,UITextFieldDelegate>{
    
    GlobalResource *global;
    int numberOfSection;
}

@property (nonatomic,strong) UIImage *pickedImage;

@end

@implementation AccountEditTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.accountNameField.delegate=self;
    self.descriptionField.delegate=self;
    self.earningPercentField.delegate=self;
    self.salesTaxField.delegate=self;
    [self.view endEditing:YES];
    
    global =[GlobalResource sharedInstance];
    
    if(global.account != nil){
        // edit mode
        
        self.accountNameField.text = global.account.name;
        self.descriptionField.text= global.account.shortDesc;
        self.salesTaxField.text = [NSString stringWithFormat:@"%@", global.account.tax];
        self.earningPercentField.text = [NSString stringWithFormat:@"%@", global.account.earningPercent];
        self.pickedImage = [UIImage imageWithData:global.account.logo];
        self.logoView.image = self.pickedImage;
        
        self.showLogoSegment.selectedSegmentIndex = [global.account.showLogo intValue];
        self.showAccountNameSegment.selectedSegmentIndex= [global.account.showName intValue];
        self.showDescSegment.selectedSegmentIndex=[global.account.showDescription intValue];
        
        numberOfSection=5;
       
        
    }else{
        
        
        self.showLogoSegment.selected = YES;
        self.showAccountNameSegment.selectedSegmentIndex= YES;
        self.showDescSegment.selectedSegmentIndex=YES;
        
        
        self.showLogoSegment.selectedSegmentIndex = 1;
        self.showAccountNameSegment.selectedSegmentIndex= 1;
        self.showDescSegment.selectedSegmentIndex=1;
        
        
        numberOfSection=4;
    }
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
    [self.tableView reloadData];
}
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if([segue.identifier isEqualToString:@"Detail"]){
        
       AccountDetail *detail = [[AccountDetail alloc]  init];
       detail = (AccountDetail *) segue.destinationViewController;
       //detail.account =  self.account;
        
    
    }
    
    
}
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return numberOfSection;
    
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    self.pickedImage =  info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self performSegueWithIdentifier:@"cropper" sender:self.view];
    
    CroperViewController *cropper = [[CroperViewController alloc]init];
    cropper.delegate=self;
    cropper.sourceImage = [self pickedImage];
    cropper.croppingSize =  CGSizeMake(640,240);
    [self.navigationController pushViewController:cropper animated:YES];
    
   
    
  //  [self.navigationController presentViewController:cropper animated:YES completion:nil];
    
    //[self addChildViewController:cropper];
   // [self.view addSubview:cropper.view];
   
    //[self addChildViewController:cropper];
    
    // [self presentModalViewController:cropper animated:YES];
    //[self presentViewController:cropper animated:YES completion:nil];
    
    
}
-(void) setCroppedImage:(UIImage *)image{
    
    CGRect rect = CGRectMake(0,0,320,120);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *newImage=[UIImage imageWithData:imageData];
    
  
    //CGSize size = CGSizeMake(320, 120);
    self.pickedImage =newImage; //[UIImage imageWithColor:image andColor:[UIColor whiteColor] andSize:size];

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
    
    
    account.showLogo = [NSNumber numberWithInteger:self.showLogoSegment.selectedSegmentIndex];
    account.showName = [NSNumber numberWithInteger:self.showAccountNameSegment.selectedSegmentIndex];
    account.showDescription = [NSNumber numberWithInteger:self.showDescSegment.selectedSegmentIndex];
    
    

    [coreDataStack saveContext];
    
    
}

-(NSNumber *) getValue: (UISegmentedControl *)segment{
    
    if(segment.selectedSegmentIndex==0){
        return [NSNumber numberWithInt:0];
    }else{
        return [NSNumber numberWithInt:1];
    }
    
    
}
-(void) updateAccount{
    
    
    global.account.name = self.accountNameField.text;
    global.account.shortDesc = self.descriptionField.text;
    global.account.tax = [NSDecimalNumber decimalNumberWithString:self.salesTaxField.text];
    global.account.earningPercent =[NSDecimalNumber decimalNumberWithString:self.earningPercentField.text];
    global.account.logo = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    
    global.account.showLogo = [NSNumber numberWithBool:self.showLogoSegment.selectedSegmentIndex];
    global.account.showName = [NSNumber numberWithBool:self.showAccountNameSegment.selectedSegmentIndex];
    global.account.showDescription = [NSNumber numberWithBool:self.showDescSegment.selectedSegmentIndex];
    
    
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
}

#pragma mark - Table view data source
-(void)dismissSelf{
     [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)save:(id)sender {
    
    if(global.account != nil){
        [self updateAccount];
    }else{
        [self createAccount];
    }
    
    
    //Reload Detail Screen
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

- (IBAction)DeleteAccount:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Warning"
                          message:@"This action will delete all account data, including orders, products and statistics. \n\n Are you sure you take this action?"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Yes, Im Sure", nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"0");
    }
    else if (buttonIndex == 1) {
        NSLog(@"1");
     
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        [[coreDataStack  managedObjectContext] deleteObject:global.account];
        [coreDataStack saveContext];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void) promptForSource{
    UIActionSheet *actionSheed = [[UIActionSheet alloc] initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Roll", nil];
    
    [actionSheed showInView:self.view];
    
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != actionSheet.cancelButtonIndex){
        if(buttonIndex != actionSheet.firstOtherButtonIndex){
        
            [self promptForPhotoRoll];
            
        }else{
      
            [self promptForCamera];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
