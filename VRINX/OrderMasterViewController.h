//
//  OrderMasterViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/15/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityAccount.h"
#import "TempOrderProduct.h"



@interface OrderMasterViewController : UITableViewController

@property(nonatomic,strong) EntityAccount *account;

@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *productCell;

@property (weak, nonatomic) IBOutlet UITextField *orderNumberField;
@property (weak, nonatomic) IBOutlet UITextField *taxField;
@property (weak, nonatomic) IBOutlet UITextField *shippingField;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;

@property(nonatomic,strong) NSMutableArray *orderProducts;
@property(nonatomic) bool withoutSave;




@end
