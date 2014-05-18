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
#import "OrderProductCell.h"

@interface OrderProductViewController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OrderProductViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
  
    
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.products = [[NSArray alloc] init];
    self.products = [self.account.products allObjects];
    
    NSLog(@"Products >>> %@ ", self.products);
    
    self.orderProducts = [[NSMutableArray alloc] init];
    
    
    [self.tableView reloadData];
  
    if([self.products count] == 0){
           self.tableView.separatorColor = [UIColor clearColor];
    }
    
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
    OrderProductCell *productCell;
    
    //EntityAccount *entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    //NSLog(@"Account CELL: %@",entry);
    
    NSInteger actualNumberOfRows = [self.products count];
    if (actualNumberOfRows == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
     
    }else{
        
       productCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       [productCell configureCellForEntry:[self.products objectAtIndex:indexPath.row]];
       UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 2)];
       line.backgroundColor = [UIColor lightGrayColor];
       [cell addSubview:line];
        
    }
    return (actualNumberOfRows == 0 ? cell:productCell);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   // NSInteger actualNumberOfRows = [self.products count];
   // if (actualNumberOfRows != 0) {
        return 105;
    
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

- (IBAction)addToCart:(id)sender {
   
    NSLog(@" add to cart!!");
    UIStepper *stepper = (UIStepper *) sender;
    
    stepper.maximumValue = 10;
    stepper.minimumValue = 0;
    int count=0;
    
    OrderProductCell  *productCell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:self.tableView.indexPathForSelectedRow];
   
    
    if (stepper){
        count++;
        [productCell.itemCountField setText:[NSString stringWithFormat:@"x %d",count]];
       // [productCell reloadInputViews];
    }
    else{
        count--;
        [productCell.itemCountField setText:[NSString stringWithFormat:@"x %d",count]];
    
    }
    [self.tableView reloadData];
    
}
@end
