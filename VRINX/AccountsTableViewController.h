//
//  AccountsTableViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAQBlurryTableViewController.h"

@interface AccountsTableViewController : JAQBlurryTableViewController
- (IBAction)SlideLeftMenu:(id)sender;




@property (strong, nonatomic) NSMutableArray *ArrayOfValues;
@property (strong, nonatomic) NSMutableArray *ArrayOfDates;


@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,strong) NSMutableArray *pages;

@end
