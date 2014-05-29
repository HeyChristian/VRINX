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
#import "GlobalResource.h"
@interface OrderProductViewController()<UITableViewDataSource,UITableViewDelegate>{
    
    GlobalResource *global;
    
}

 
@end



@implementation OrderProductViewController

@synthesize selectedSource;
@synthesize delegate;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    global=[GlobalResource sharedInstance];
    
    self.selectedSource = ALL;
  
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    /*
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.checkoutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Select Items for Checkout" style: target:<#(id)#> action:<#(SEL)#>
                        //initWithBarButtonSystemItem:(UIBarButtonSystemItem)UIBarButtonItemStylePlain target:self action:nil];  //@selector(cropImage:)];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:flexibleSpace,self.checkoutBtn ,flexibleSpace, nil];
   
    self.toolbarItems = toolbarItems;
    */
    
    
    
    self.products = [[NSArray alloc] init];
    self.products = [global.account.products allObjects];
    
    NSLog(@"order products >>> %@ ", self.orderProducts);
    
    if(self.orderProducts == nil){
        self.orderProducts = [[NSMutableArray alloc] init];
    }
    
    [self.navigationController setToolbarHidden:YES];
    
    
    [self SortDataSource];
  
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    //Pass order product to parent view
  //  if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [self.delegate setOrderProduct:self.orderProducts];
    //}
    [super viewWillDisappear:animated];
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"newProduct"]){
        
        ProductDetailTableViewController  *newProduct = (ProductDetailTableViewController *) segue.destinationViewController;
       //  newProduct.account = global.account;
        
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

-(NSNumber *) GetCountOrderProducts{
    
    
    if([self.orderProducts count] ==  0){
        return 0;
    }else{
        
        bool noItems=false;
        for(TempOrderProduct *op in self.orderProducts){
            if(op.itemCount>0){
                noItems=false;
            }else{
                [self.orderProducts removeObject:op];
            }
            
        }
        
        if(noItems)
            return 0;
        else
            return [[NSNumber alloc] initWithInt:1];
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"cell for row at index path: %ld",(long)indexPath.row);
    
    
   EmptyOrderProductCell  *emptyCell;
   OrderProductCell *productCell;
    
    
    
    NSInteger actualNumberOfRows =  (self.selectedSource == ALL ?[self.products count]: [self GetCountOrderProducts].integerValue);
    
    
    
    if (actualNumberOfRows == 0) {
        emptyCell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
        if(self.selectedSource == ALL)
            emptyCell.EmptyMessagelabel.text = @"No have any product in the pocket";
        else
            emptyCell.EmptyMessagelabel.text = @"No have any product in the cart";
        
        self.tableView.separatorColor = [UIColor clearColor];
        [self.searchBar setHidden:YES];
        
        self.tableView.backgroundColor = [UIColor whiteColor];
    }else{
       
        [self.searchBar setHidden:NO];
        
        self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        productCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       
        int itemCount=0;
        
        if(self.selectedSource == ALL){
        
            itemCount =[self getItemCountByProduct:[self.products objectAtIndex:indexPath.row] andOrderProducts:self.orderProducts];
            
           [productCell configureCellForEntry:[self.products objectAtIndex:indexPath.row] andItemCount:itemCount];
        
        }else{
         
            EntityOrderProduct *order =[self.orderProducts objectAtIndex:indexPath.row];
            
            if(order.itemCount ==0 ){
            
                [self.orderProducts removeObjectAtIndex:indexPath.row];
            
            }else{
                itemCount =[self getItemCountByProduct:order.product andOrderProducts:self.orderProducts];
                
                
                [productCell configureCellForEntry:order.product andItemCount:itemCount];
            }
        }
        
        
        
       UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 105, 320, .5)];
       line.backgroundColor = [UIColor lightGrayColor];
       [productCell addSubview:line];
       
        //productCell.itemStepper.tag = indexPath.row;
      // [productCell.itemStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    return (actualNumberOfRows == 0 ? emptyCell:productCell);
}
-(int) getItemCountByProduct:(EntityProduct *) product andOrderProducts:(NSMutableArray *)orderProducts{
    int count=0;
    
    for(TempOrderProduct *op in orderProducts){
        if(op.product.uuid == product.uuid){
            count = [op.itemCount intValue];
        }
    }
    return count;
}


- (void)stepperValueChanged:(UIStepper *)sender {
    // Replace old stepper value with new one
    //[self.tableView beginUpdates];
    
   // NSLog(@"stepper value changed in >> opvc");
    UIStepper *stepper = (UIStepper *) sender;
    
    //NSLog(@"Stepper ID: %ld",(long)stepper.tag);
   // NSLog(@"Stepper Value: %f", stepper.value);
   
    NSNumber *itemCount = nil; // [[NSNumber alloc] initWithDouble:stepper.value + 1];
    bool exist = NO;
    if(self.selectedSource == ALL){
        
        [self.orderProducts removeAllObjects];
        
        EntityProduct *product = [self.products objectAtIndex:stepper.tag];
        
        
        
        TempOrderProduct *inCartProduct = [[TempOrderProduct alloc] init];
        TempProduct *tempProduct = [[TempProduct alloc] init];
        
        for(int i = 0; i < self.orderProducts.count; i++)
        {
            inCartProduct =  [self.orderProducts objectAtIndex:i];
            if([inCartProduct.product.uuid isEqual:product.uuid]){
                
                
                if(itemCount > 0 ){
                    inCartProduct.itemCount = [[NSNumber alloc] initWithInt:inCartProduct.itemCount.intValue + 1];
                    [self.orderProducts removeObjectAtIndex:i];
                    [self.orderProducts insertObject:inCartProduct atIndex:i];
                     exist=YES;
                }else{
                    [self.orderProducts removeObjectAtIndex:i];
                    
                }
               
               
            }
            if([inCartProduct.itemCount intValue] == 0 )
                [self.orderProducts removeObjectAtIndex:i];
            
            
        }
        
        if(exist==NO){
            tempProduct.uuid=product.uuid;
            tempProduct.objectID=product.objectID;
            tempProduct.name = product.name;
            tempProduct.itemPhoto = product.itemPhoto;
            tempProduct.shortDesc = product.shortDesc;
            tempProduct.price = product.price;
    
            inCartProduct.product = tempProduct;
            inCartProduct.itemCount = [[NSNumber alloc] initWithDouble:1];
        
            [self.orderProducts addObject:inCartProduct];
        }
        
      //  NSLog(@"product for change  stepper value>> %@",inCartProduct);
        
    }else if(self.selectedSource == INCART){
        
        EntityProduct *product = [self.products objectAtIndex:stepper.tag];
        
        
        
        TempOrderProduct *inCartProduct = [[TempOrderProduct alloc] init];
       // int productInCart = 0;
        
        for(int i = 0; i < self.orderProducts.count; i++)
        {
            inCartProduct =  [self.orderProducts objectAtIndex:i];
            if([inCartProduct.product.uuid isEqual:product.uuid]){
                
                
                if(itemCount > 0 ){
                    inCartProduct.itemCount = itemCount;
                    [self.orderProducts removeObjectAtIndex:i];
                    [self.orderProducts insertObject:inCartProduct atIndex:i];
                    
                }else{
                    [self.orderProducts removeObjectAtIndex:i];
                    
                }
            }
            
            if([inCartProduct.itemCount intValue] == 0 )
                [self.orderProducts removeObjectAtIndex:i];
            
           // NSLog(@"InCart Prod: %@",inCartProduct.product.name);
            
          //  NSLog(@"InCart Count: %@",inCartProduct.itemCount);
        }
        
        
        
    }
    
   // [self.tableView endUpdates];
    
    [self.tableView reloadData];
    
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
       // [self CleanCart];
    }
    NSLog(@"In Cart : %@", self.orderProducts.debugDescription);
    
    [self.tableView reloadData];
}

- (IBAction)addItem:(id)sender {
    UIButton *btn = (UIButton *) sender;
    NSNumber *pk = [[NSNumber alloc] initWithInteger:btn.tag];
    [self changeItemStock:pk.stringValue andOperator:@"add"];
}

- (IBAction)removeItem:(id)sender {
    
    UIButton *btn = (UIButton *) sender;
    NSNumber *pk = [[NSNumber alloc] initWithInteger:btn.tag];
    [self changeItemStock:pk.stringValue andOperator:@"remove"];
}


-(void) changeItemStock:(NSString *)currentProductIdentifier andOperator:(NSString *) operator{
    
    NSLog(@"P: %@ - %@",currentProductIdentifier,operator);
    
    bool exist=NO;
    

        TempOrderProduct *inCartProduct = [[TempOrderProduct alloc] init];
    
        for(int pix = 0; pix < self.orderProducts.count; pix++)
        {
            inCartProduct =  [self.orderProducts objectAtIndex:pix];
            
            if([inCartProduct.product.uuid isEqual:currentProductIdentifier]){
                
                exist=YES;
                
                if([operator  isEqual: @"add"]){
                
                    inCartProduct.itemCount = [[NSNumber alloc] initWithInt:inCartProduct.itemCount.intValue + 1];
                
                }else if([operator isEqual:@"remove"]){
                    inCartProduct.itemCount = [[NSNumber alloc] initWithInt:inCartProduct.itemCount.intValue - 1];
                
                }
                    [self.orderProducts removeObjectAtIndex:pix];
                
                if(inCartProduct.itemCount.intValue > 0){
                 [self.orderProducts insertObject:inCartProduct atIndex:pix];
                 //  [self.orderProducts addObject:inCartProduct];
                }
                
                break;
            }//end if product identifier
            
           // if([inCartProduct.itemCount intValue] == 0 )
           //     [self.orderProducts removeObjectAtIndex:i];
            
            
        }//end for
        
        if(exist == NO && [operator isEqual:@"add"]){
            
            TempProduct *tempProduct = [[TempProduct alloc] init];
            
            for(int i=0; i < self.products.count; i++){
              EntityProduct  *product = [self.products objectAtIndex:i];
                if([currentProductIdentifier isEqual:product.uuid]){
                    
                    tempProduct.uuid        = product.uuid;
                    tempProduct.objectID    = product.objectID;
                    tempProduct.name        = product.name;
                    tempProduct.itemPhoto   = product.itemPhoto;
                    tempProduct.shortDesc   = product.shortDesc;
                    tempProduct.price       = product.price;
                    
                    break;
                }
            }
            
            TempOrderProduct *newProductOrder = [[TempOrderProduct alloc] init];
            newProductOrder.name      = tempProduct.name; // new Attribute for sorting.
            newProductOrder.product   = tempProduct;
            newProductOrder.itemCount = [[NSNumber alloc] initWithInt:1];
            
            [self.orderProducts addObject:newProductOrder];
        }
    
    
    [self SortDataSource];
    
    
}

-(void) SortDataSource{
    
    //Sort Order Products
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [self.orderProducts sortedArrayUsingDescriptors:sortDescriptors];
    
    self.orderProducts = [[NSMutableArray alloc] initWithArray:sortedArray];
    
    
    //Sort Products
    sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    sortDescriptors = [NSArray arrayWithObject:sortByName];
    sortedArray = [self.products sortedArrayUsingDescriptors:sortDescriptors];
    
    self.products = [[NSArray alloc] initWithArray:sortedArray];
    
    
    
    
    
    [self.tableView reloadData];
    
    
    
}


-(void) CleanCart{
    TempOrderProduct *inCartProduct = [[TempOrderProduct alloc] init];
    
    for(int i = 0; i < self.orderProducts.count; i++)
    {
        inCartProduct =  [self.orderProducts objectAtIndex:i];
       
        
        if([inCartProduct.itemCount intValue] == 0 )
            [self.orderProducts removeObjectAtIndex:i];
        
       
    }
    

}

@end
