//
//  OrderCell.m
//  VRINX
//
//  Created by Christian Vazquez on 6/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderCell.h"
#import "Tools.h"
#import <QuartzCore/QuartzCore.h>

@implementation OrderCell



-(void)configureCellForEntry:(EntityOrder *)order{
   // self.timeView.frame
    self.timeView.layer.cornerRadius = 5;
   // self.timeView.layer.masksToBounds = YES;
    self.clientNameLabel.text = order.clientName;
    self.orderDateLabel.text = [Tools timeIntervalWithStartDate:order.orderDate];
    
}
@end
