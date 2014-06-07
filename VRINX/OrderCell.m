//
//  OrderCell.m
//  VRINX
//
//  Created by Christian Vazquez on 6/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderCell.h"
#import "Tools.h"
#import "EntityOrderProduct.h"

#import <QuartzCore/QuartzCore.h>

@implementation OrderCell



-(void)configureCellForEntry:(EntityOrder *)order{
    self.totalView.layer.cornerRadius = 1;
    self.totalView.layer.masksToBounds = YES;
   
    
    self.dueView.layer.cornerRadius = 1;
    self.dueView.layer.masksToBounds = YES;
    
    self.clientNameLabel.text = order.clientName;
    self.orderDateLabel.text = [Tools timeIntervalWithStartDate:order.creationDate];
    
    int items=0;
    for(EntityOrderProduct *op in order.orderProducts){
        items += [op.itemCount intValue];
    }
    self.orderTotalLabel.text = [self formatCurrency:order.granTotal];
    self.dueLabel.text = [self formatCurrency:order.granTotal];
    
    self.itemCountLabel.text = [[NSString alloc] initWithFormat:@"%d",items];
    
}

-(NSString *)formatCurrency:(NSNumber *)number{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:number];
}

@end
