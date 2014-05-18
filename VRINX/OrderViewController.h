//
//  OrderViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityAccount.h"

@interface OrderViewController : UIViewController


@property (nonatomic,strong) EntityAccount *account;
@property (nonatomic,strong) NSArray *orders;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
