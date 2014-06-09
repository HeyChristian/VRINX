//
//  OrderDetailViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 6/8/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *clientNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *itemTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *shippingTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *taxTotallabel;

@property (weak, nonatomic) IBOutlet UILabel *adionalTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *discountTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *granTotalLabel;



@end
