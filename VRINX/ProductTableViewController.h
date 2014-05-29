//
//  ProductTableViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EntityAccount, EntityProduct;

@interface ProductTableViewController : UITableViewController

//@property(nonatomic,strong) EntityAccount *account;
@property(nonatomic,strong) EntityProduct *product;
@property(nonatomic,strong) NSArray *products;

@end
