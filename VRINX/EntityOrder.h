//
//  EntityOrder.h
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityAccount, EntityOrder, EntityOrderProduct;

@interface EntityOrder : NSManagedObject

@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * estimateDelivery;
@property (nonatomic, retain) NSNumber * isMasterOrder;
@property (nonatomic, retain) NSString * shortDesc;
@property (nonatomic, retain) NSDecimalNumber * shippingTotal;
@property (nonatomic, retain) NSDecimalNumber * taxesTotal;
@property (nonatomic, retain) NSDecimalNumber * total;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) EntityAccount *accountOrders;
@property (nonatomic, retain) EntityOrder *orders;
@property (nonatomic, retain) NSSet *orderProducts;
@end

@interface EntityOrder (CoreDataGeneratedAccessors)

- (void)addOrderProductsObject:(EntityOrderProduct *)value;
- (void)removeOrderProductsObject:(EntityOrderProduct *)value;
- (void)addOrderProducts:(NSSet *)values;
- (void)removeOrderProducts:(NSSet *)values;

@end
