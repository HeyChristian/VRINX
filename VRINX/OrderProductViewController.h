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

typedef enum SOURCE{

    ALL=0,
    INCART=1

}SOURCE;

@interface OrderProductViewController : UITableViewController
 




@property(nonatomic,assign) SOURCE selectedSource;
@property(nonatomic,strong) EntityAccount *account;
@property(nonatomic,strong) EntityOrder *order;
@property(nonatomic,strong) NSMutableArray *orderProducts;
@property(nonatomic,strong) NSArray *products;
@property(nonatomic,strong) EntityOrderProduct *inCartProduct;

- (IBAction)filterProductSource:(id)sender;

@end
