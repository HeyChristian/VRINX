//
//  AccountDetail.m
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "AccountDetail.h"
#import "CoreDataStack.h"
#import "EntityAccount.h"
#import "AccountEditTableViewController.h"
#import "ProductTableViewController.h"
#import "OrderViewController.h"
#import "GlobalResource.h"

@interface AccountDetail (){
    GlobalResource *global;
}

@property(nonatomic,strong) NSArray *products;
@property(nonatomic,strong) NSArray *orders;

@end

@implementation AccountDetail



- (void)viewDidLoad
{
    [super viewDidLoad];
    global = [GlobalResource sharedInstance];
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    if(global.account){
        self.accountNameLabel.text = global.account.name;
        self.shortDescriptionLabel.text= global.account.shortDesc;
        self.missingLabel.text = [self formatCurrency:global.account.missed];
        self.earningsLabel.text = [self formatCurrency:global.account.earnings];
        self.logoView.image = [UIImage imageWithData:global.account.logo];;
    }
    
    self.products = [[NSArray alloc] init];
    self.products = [global.account.products allObjects];
    self.productCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.products.count];
    
    self.orders = [[NSArray alloc] init];
    self.orders = [global.account.orders allObjects];
    self.orderCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.orders.count];
    
    
    
    [self.tableView reloadData];
    [self.tableView reloadData];
}
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"edit"]){
        
      //  AccountEditTableViewController  *editAccountVC = (AccountEditTableViewController *) segue.destinationViewController;
       // editAccountVC.account = global.account;
    
    }else if([segue.identifier isEqualToString:@"products"]){
     
        //ProductTableViewController *productVC = (ProductTableViewController *) segue.destinationViewController;
       // productVC.account = global.account;
        
    }else if([segue.identifier isEqualToString:@"orders"]){
        
      //  OrderViewController *orderVC = (OrderViewController *) segue.destinationViewController;
       // orderVC.account = global.account;
        
        global.backSegueIdentifier = @"backToDetail";
    }
    
    
}
#pragma mark - Helpers

-(NSString *)formatCurrency:(NSNumber *)number{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:number];
}


@end
