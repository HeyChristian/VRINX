//
//  OrderProductViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/17/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderProductViewController.h"
#import "EntityProduct.h"
#import "ProductDetailTableViewController.h"
#import "ProductCell.h"

@interface OrderProductViewController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OrderProductViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.productTableView.delegate=self;
    self.productTableView.dataSource=self;
    
    self.products = [[NSArray alloc] init];
    self.products = [self.account.products allObjects];
    self.orderProducts = [[NSMutableArray alloc] init];
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.productTableView reloadData];
  
  
    
}
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"newProduct"]){
        
        ProductDetailTableViewController  *newProduct = (ProductDetailTableViewController *) segue.destinationViewController;
        newProduct.account = self.account;
        
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
    
    
    NSInteger actualNumberOfRows = [self.products count];
    return (actualNumberOfRows  == 0) ? 1 : actualNumberOfRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ProductCell *productCell;
    
    //EntityAccount *entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    //NSLog(@"Account CELL: %@",entry);
    
    NSInteger actualNumberOfRows = [self.products count];
    if (actualNumberOfRows == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
        
    }else{
        
       productCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       [productCell configureCellForEntry:[self.products objectAtIndex:indexPath.row]];
        
       // CGFloat height = fmin(size.height, 100.0);
       // ProductCell.
    }
    return (actualNumberOfRows == 0 ? cell:productCell);
}

- (IBAction)filterProductSource:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        NSLog(@"select index: 0");
    }
    else{
        
        NSLog(@"select index: 1");
    }
    
}
@end
