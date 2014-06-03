//
//  ProductDetailTableViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "ProductDetailTableViewController.h"

#import "EntityProduct.h"
#import "EntityAccount.h"
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "CroperViewController.h"
#import "GlobalResource.h"

@interface ProductDetailTableViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CropperDelegate>{
    
    GlobalResource *global;
    
}

@property (nonatomic,strong) UIImage *pickedImage;


@end

@implementation ProductDetailTableViewController



- (void)viewDidLoad
{
    
   // NSLog(@"account parameter: %@",self.account);
    
    [super viewDidLoad];
    global = [GlobalResource sharedInstance];
    
    if(self.product != nil){
       
        self.productNameField.text = self.product.name;
        self.shortDescriptionField.text = self.product.shortDesc;
        
      //  NSString* formattedNumber = [NSString stringWithFormat:@"@f", self.product.price];
       // NSDecimalNumber *doubleDecimal = [[NSDecimalNumber alloc] initWithDouble:self.product.price.doubleValue];

        self.priceField.text = [NSString stringWithFormat:@"%0.2f",self.product.price.doubleValue];
        self.pickedImage = [UIImage imageWithData:self.product.itemPhoto];
        self.imageView.image = self.pickedImage;
        
        
        
    }else{
        
        self.productNameField.text = nil;
        self.shortDescriptionField.text = nil;
        self.priceField.text =nil;
        self.imageView.image   = [UIImage imageNamed:@"box.png"];
        
    }
    [self setSquaredConernersToImageView];
   // NSLog(@"))))))): %@",self.account);
   
}


- (void)setSquaredConernersToImageView {
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
    
    self.imageView.layer.cornerRadius = 10.0f;
    
    self.imageView.layer.borderWidth = 3.0f;
    
    //CGColorRef *borderColor = [[CGColorRef alloc] initWithColor:[AppDelegate colorWithHexString:@"2293f5"]];
    
    self.imageView.layer.borderColor =[UIColor whiteColor].CGColor;
    
}

-(void)dismissSelf{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)save:(id)sender {

    if(self.product != nil){
        [self updateProduct];
    }else{
        [self createProduct];
    }
    
    [self dismissSelf];
    

}
-(void) createProduct{
    
    
   
   CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    EntityProduct *product = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:global.account.managedObjectContext];
    
    
    product.uuid=  [self getPK];   //[[NSUUID UUID] UUIDString];
    product.name = self.productNameField.text;
    product.shortDesc = self.shortDescriptionField.text;
    product.price = [NSDecimalNumber decimalNumberWithString:self.priceField.text];
    
    if(self.pickedImage != nil){
        product.itemPhoto = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    }else{
        product.itemPhoto = UIImageJPEGRepresentation([UIImage imageNamed:@"box.png"], 0.75);
    }
    [global.account addProductsObject:product];
    
    
    [coreDataStack saveContext];
    
    
}
-(NSString *)getPK{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"ddmmyyyyhms"; // or whatever you want; per the unicode standards
    
    NSString *pk = [[NSString alloc] initWithString:[dateFormatter  stringFromDate:[NSDate date]]];
    if([[pk substringWithRange:NSMakeRange(0,1)] isEqual:@"0"]){
        pk = [[NSString alloc] initWithString:[pk substringWithRange:NSMakeRange(1,pk.length-1)]];
    }
    NSLog(@"pk: %@",pk);
    
    return pk;
   // NSLog(@"pk  %@", pk);
    
    // return nil;
}
-(void) updateProduct{
    
    
    self.product.name = self.productNameField.text;
    self.product.shortDesc = self.shortDescriptionField.text;
    self.product.price = [NSDecimalNumber decimalNumberWithString:self.priceField.text];
    
    
    if(self.pickedImage != nil){
        self.product.itemPhoto = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    }else{
        self.product.itemPhoto = UIImageJPEGRepresentation([UIImage imageNamed:@"box.png"], 0.75);
    }
    
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
    
}
- (IBAction)setProductImage:(id)sender {
    
    //if device have camera
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self promptForSource];
    }else{
        [self promptForPhotoRoll];
    }
    
}

#pragma mark - Helpers

-(NSString *)formatCurrency:(NSNumber *)number{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:number];
}

#pragma mark - Image Helper
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage =  image;
    
    CroperViewController *cropper = [[CroperViewController alloc]init];
    cropper.delegate=self;
    cropper.sourceImage = [self pickedImage];
    cropper.croppingSize =  CGSizeMake(640,640);
    [self.navigationController pushViewController:cropper animated:YES];
    

    
    [self setSquaredConernersToImageView];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setCroppedImage:(UIImage *)image{
    
    CGRect rect = CGRectMake(0,0,200,200);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *newImage=[UIImage imageWithData:imageData];
    
    
    //CGSize size = CGSizeMake(320, 120);
    self.pickedImage =newImage; //[UIImage imageWithColor:image andColor:[UIColor whiteColor] andSize:size];
    
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
        self.imageView.image  = [UIImage imageNamed:@"box"];
    }else{
        self.imageView.image = pickedImage;
    }
}

@end
