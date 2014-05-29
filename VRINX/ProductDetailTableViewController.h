//
//  ProductDetailTableViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class EntityAccount;
@class EntityProduct;

@interface ProductDetailTableViewController : UITableViewController



@property (nonatomic,strong) EntityProduct *product;
//@property (nonatomic,strong) EntityAccount *account;
@property (weak, nonatomic) IBOutlet UITableViewCell *itemPhotoCell;


@property (weak, nonatomic) IBOutlet UITextField *productNameField;
@property (weak, nonatomic) IBOutlet UITextField *shortDescriptionField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)save:(id)sender;
- (IBAction)setProductImage:(id)sender;

@end
