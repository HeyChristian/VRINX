//
//  OrderMasterViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/15/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderMasterViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *orderCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *productCell;
@property (weak, nonatomic) IBOutlet UISwitch *multipleOrderSwitch;

@property (weak, nonatomic) IBOutlet UITextField *orderNumberField;
@property (weak, nonatomic) IBOutlet UITextField *taxField;
@property (weak, nonatomic) IBOutlet UITextField *shippingField;



- (IBAction)setMultipleOrders:(id)sender;

@end
