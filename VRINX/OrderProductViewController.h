//
//  OrderProductViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/17/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityAccount.h"
#import "EntityOrder.h"
#import "EntityOrderProduct.h"
#import "TempOrderProduct.h"

typedef enum SOURCE{

    ALL=0,
    INCART=1

}SOURCE;


@protocol OrderProductDelegate <NSObject>     //define a protocol named
- (void) setOrderProduct:(NSMutableArray *)orderProducts;
@end

@interface OrderProductViewController : UITableViewController
 



@property (nonatomic, assign) id delegate; //create a delegate

@property(nonatomic,assign) SOURCE selectedSource;
@property(nonatomic,strong) EntityAccount *account;
@property(nonatomic,strong) EntityOrder *order;
@property(nonatomic,retain) NSMutableArray *orderProducts;
@property(nonatomic,strong) NSArray *products;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property(nonatomic,strong)  UIBarButtonItem *checkoutBtn;

- (IBAction)filterProductSource:(id)sender;

@end
