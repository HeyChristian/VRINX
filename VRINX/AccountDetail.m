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

@interface AccountDetail ()

@end

@implementation AccountDetail



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if(self.account){
        self.accountNameLabel.text = self.account.name;
        self.shortDescriptionLabel.text= self.account.shortDesc;
        self.missingLabel.text = [self formatCurrency:self.account.missed];
        self.earningsLabel.text = [self formatCurrency:self.account.earnings];
        self.logoView.image = [UIImage imageWithData:self.account.logo];;
    }
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"edit"]){
        
        AccountEditTableViewController  *editAccountVC = (AccountEditTableViewController *) segue.destinationViewController;
        editAccountVC.account = self.account;
    
    }else if([segue.identifier isEqualToString:@"products"]){
     
        ProductTableViewController *productVC = (ProductTableViewController *) segue.destinationViewController;
        productVC.account = self.account;
        
    }
    
}
#pragma mark - Helpers

-(NSString *)formatCurrency:(NSNumber *)number{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:number];
}


@end
