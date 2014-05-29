//
//  ChooseOrderTypeController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/27/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "ChooseOrderTypeController.h"
//#import "OrderMasterViewController.h"

@interface ChooseOrderTypeController ()

@end

@implementation ChooseOrderTypeController


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"singleOrder"]  ){
        
       // OrderMasterViewController *orderProductVC = (OrderMasterViewController *) segue.destinationViewController;
       // orderProductVC.account = self.account;
        
       // NSLog(@"Order Product Account: %@",orderProductVC.account);
        
    }
    
    
}


@end
