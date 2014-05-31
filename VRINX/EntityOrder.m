//
//  EntityOrder.m
//  VRINX
//
//  Created by Christian Vazquez on 5/31/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "EntityOrder.h"
#import "EntityAccount.h"
#import "EntityContactOrder.h"
#import "EntityOrder.h"
#import "EntityOrderProduct.h"


@implementation EntityOrder

@dynamic creationDate;
@dynamic orderDate;
@dynamic isMasterOrder;
@dynamic shippingTotal;
@dynamic shortDesc;
@dynamic taxTotal;
@dynamic updateDate;
@dynamic granTotal;
@dynamic additionalCostTotal;
@dynamic discount;
@dynamic itemsTotal;
@dynamic accountOrders;
@dynamic orderProducts;
@dynamic orders;
@dynamic contactOrder;

@end
