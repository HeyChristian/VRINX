//
//  OrderCell.h
//  VRINX
//
//  Created by Christian Vazquez on 6/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityOrder.h"
@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;

@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UIView *dueView;

-(void)configureCellForEntry:(EntityOrder *)order;
    
@end
