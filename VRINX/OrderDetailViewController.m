//
//  OrderDetailViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 6/8/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "EntityOrder.h"
#import "GlobalResource.h"

@interface OrderDetailViewController (){
     GlobalResource *global;
}
 
@end

@implementation OrderDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    global = [GlobalResource sharedInstance];
    
    self.clientNameLabel.text = global.selectedOrder.clientName;
    
    
    
}




@end
