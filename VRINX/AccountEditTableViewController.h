//
//  AccountEditTableViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@class EntityAccount;

@interface AccountEditTableViewController : UITableViewController



@property (nonatomic,strong)EntityAccount *account;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UITextField *accountNameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;

@property (weak, nonatomic) IBOutlet UITextField *earningPercentField;
@property (weak, nonatomic) IBOutlet UITextField *salesTaxField;


- (IBAction)save:(id)sender;
- (IBAction)changeLogo:(id)sender;

@end
