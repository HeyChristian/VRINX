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
   
    NSInteger actualNumberOfRows = [self.products count];
    return (actualNumberOfRows  == 0) ? 1 : actualNumberOfRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for row at index path: %ld",(long)indexPath.row);
    
    
    UITableViewCell *cell;
    OrderProductCell *productCell;
    
    NSInteger actualNumberOfRows = [self.products count];
    if (actualNumberOfRows == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
     
    }else{
       productCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       [productCell configureCellForEntry:[self.products objectAtIndex:indexPath.row]];
       UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 2)];
       line.backgroundColor = [UIColor lightGrayColor];
       [cell addSubview:line];
        
        productCell.itemStepper.tag = indexPath.row;
        [productCell.itemStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    return (actualNumberOfRows == 0 ? cell:productCell);
}

- (void)stepperValueChanged:(UIStepper *)sender {
    // Replace old stepper value with new one
    
    NSLog(@"stepper value changed in >> opvc");
    UIStepper *stepper = (UIStepper *) sender;
    
    NSLog(@"Stepper ID: %ld",(long)stepper.tag);
    NSLog(@"Stepper Value: %f", stepper.value);
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 105;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
}


#pragma mark - IBActions
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
