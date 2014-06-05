//
//  OrderViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderViewController.h"
#import "ChooseOrderTypeController.h"
#import "GlobalResource.h"
#import "EntityOrder.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    GlobalResource *global;
    
}

@end

@implementation OrderViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.orders = [[NSArray alloc] init];
    global = [GlobalResource sharedInstance];
    
    self.orders = [global.account.orders allObjects];
    
    self.tableView.dataSource =self;
    self.tableView.delegate =self;
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Back"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(performBack:)];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    global.selectedContact=nil;
    global.orderProducts=[[NSMutableArray alloc] init];
}
-(IBAction)performBack:(id) sender{
    
    NSLog(@"perform back into order view controller");
    
    [self performSegueWithIdentifier:@"backToDetail" sender:nil];
    /*
    if(global.backSegueIdentifier != nil){
        [self performSegueWithIdentifier:global.backSegueIdentifier sender:nil];
    }else{
         [self.navigationController popToRootViewControllerAnimated:YES];
    }*/
    
}

#pragma mark - Navigation

 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
     if([segue.identifier isEqualToString:@"newOrder"] || [segue.identifier isEqualToString:@"newOrderBtn"] ){
     
        // ChooseOrderTypeController *orderProductVC = (ChooseOrderTypeController *) segue.destinationViewController;
        // orderProductVC.account = global.account;
     
    //     NSLog(@"Order Product Account: %@",orderProductVC.account);
         
     }
     
 
 }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchResultsController sections][section];
    
    // NSLog(@"# of Records : %lu", (unsigned long)[sectionInfo numberOfObjects]);
    
    //return [sectionInfo numberOfObjects];
    
    
    NSInteger actualNumberOfRows = [self.orders count];
    return (actualNumberOfRows  == 0) ? 1 : actualNumberOfRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //EntityAccount *entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    //NSLog(@"Account CELL: %@",entry);
    
    //[cell configureCellForEntry:entry];
    
    NSInteger actualNumberOfRows = [self.orders count];
    if (actualNumberOfRows == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        EntityOrder *order = [self.orders objectAtIndex:indexPath.row];
        cell.textLabel.text = [self formatDate:order.orderDate];
        
    }
    // Produce the correct cell the usual way
    
    
    return cell;
}
-(NSString *) formatDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    
    return [dateFormatter stringFromDate:date];
    
}
@end
