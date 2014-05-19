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
#import "EmptyOrderProductCell.h"

#import "TempProduct.h"
#import "TempOrderProduct.h"

@interface OrderProductViewController()<UITableViewDataSource,UITableViewDelegate>

 
@end



@implementation OrderProductViewController

@synthesize selectedSource;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.selectedSource = ALL;
    
    
    self.products = [[NSArray alloc] init];
    self.products = [self.account.products allObjects];
    
    NSLog(@"Products >>> %@ ", self.products);
    
    self.orderProducts = [[NSMutableArray alloc] init];
    
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    [self.tableView reloadData];
  
    
    
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
   
    NSInteger actualNumberOfRows =  (self.selectedSource == ALL ?[self.products count]:[self.orderProducts count]);
    return (actualNumberOfRows  == 0) ? 1 : actualNumberOfRows;
}

- (NSArray*)tableData{
    
    if(self.selectedSource == ALL){
        
        if([self.products count] == 0){
            self.tableView.separatorColor = [UIColor clearColor];
        }
        
        return self.products;
    }else{
        if([self.orderProducts count] == 0){
            self.tableView.separatorColor = [UIColor clearColor];
        }
        return self.orderProducts;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for row at index path: %ld",(long)indexPath.row);
    
    
   EmptyOrderProductCell  *emptyCell;
    OrderProductCell *productCell;
    
    
    
    NSInteger actualNumberOfRows =  (self.selectedSource == ALL ?[self.products count]:[self.orderProducts count]);
    
    if (actualNumberOfRows == 0) {
        emptyCell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
        if(self.selectedSource == ALL)
            emptyCell.EmptyMessagelabel.text = @"No have any product in the pocket";
        else
            emptyCell.EmptyMessagelabel.text = @"No have any product in the cart";
        
        self.tableView.separatorColor = [UIColor clearColor];
        
    }else{
        
       productCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       
        
        if(self.selectedSource == ALL){
           [productCell configureCellForEntry:[self.products objectAtIndex:indexPath.row]];
        }else{
            EntityOrderProduct *order =[self.orderProducts objectAtIndex:indexPath.row];
           [productCell configureCellForEntry:order.product];
        }
        
       UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 105, 320, .5)];
       line.backgroundColor = [UIColor lightGrayColor];
       
        [productCell addSubview:line];
        
       productCell.itemStepper.tag = indexPath.row;
       [productCell.itemStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    return (actualNumberOfRows == 0 ? emptyCell:productCell);
}

- (void)stepperValueChanged:(UIStepper *)sender {
    // Replace old stepper value with new one
    
    NSLog(@"stepper value changed in >> opvc");
    UIStepper *stepper = (UIStepper *) sender;
    
    NSLog(@"Stepper ID: %ld",(long)stepper.tag);
    NSLog(@"Stepper Value: %f", stepper.value);
   
    if(self.selectedSource == ALL){
        bool exist = NO;
        EntityProduct *product = [self.products objectAtIndex:stepper.tag];
        
        for(TempOrderProduct *top in self.orderProducts){
            
            if([top.product.objectID isEqual:product.objectID]){
                exist=YES;
                
                
            }
        }
        
        TempOrderProduct *inCartProduct = [[TempOrderProduct alloc] init];
        TempProduct *tempProduct = [[TempProduct alloc] init];
        
        for(int i = 0; i < self.orderProducts.count; i++)
        {
            tempProduct =  [self.orderProducts objectAtIndex:i];
            if([tempProduct.objectID isEqual:product.objectID]){
                
            
            }
            
        }
        
        
        
        
        //Necesito actualizar el listado del carrito, ya que cada vez que agrego se actualiza como si fuera uno nuevo y no el conteo de el producto seleccionado. hay que iliterar en la lista utilizando el ID unico ObjectID para verificar la existencia de el objeto
        
        tempProduct.objectID=product.objectID;
        tempProduct.name = product.name;
        tempProduct.itemPhoto = product.itemPhoto;
        tempProduct.shortDesc = product.shortDesc;
        tempProduct.price = product.price;
        
        inCartProduct.product = tempProduct;
        inCartProduct.itemCount = [[NSNumber alloc] initWithDouble:stepper.value];
        
        [self.orderProducts addObject:inCartProduct];
        
        
        NSLog(@"product for change  stepper value>> %@",inCartProduct);
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 105;
}



#pragma mark - IBActions
- (IBAction)filterProductSource:(id)sender {
    
    NSLog(@"Reaload Data with Selected Segment");
    
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        self.selectedSource = ALL;
    }
    else{
        self.selectedSource = INCART;
    }
    
    [self.tableView reloadData];
}

@end
