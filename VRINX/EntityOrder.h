//
//  EntityOrder.h
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityOrder, EntityOrderProduct;

@interface EntityOrder : NSManagedObject

@property (nonatomic) BOOL isMasterOrder;
@property (nonatomic, retain) NSDecimalNumber * total;
@property (nonatomic, retain) NSString * orderDesc;
@property (nonatomic, retain) NSDecimalNumber * shippingTotal;
@property (nonatomic, retain) NSDecimalNumber * taxesTotal;
@property (nonatomic) NSTimeInterval creationDate;
@property (nonatomic) NSTimeInterval estimateDelivery;
@property (nonatomic) NSTimeInterval updateDate;
@property (nonatomic, retain) NSSet *orderProducts;
@property (nonatomic, retain) NSSet *childOrders;
@end

@interface EntityOrder (CoreDataGeneratedAccessors)

- (void)addOrderProductsObject:(EntityOrderProduct *)value;
- (void)removeOrderProductsObject:(EntityOrderProduct *)value;
- (void)addOrderProducts:(NSSet *)values;
- (void)removeOrderProducts:(NSSet *)values;

- (void)addChildOrdersObject:(EntityOrder *)value;
- (void)removeChildOrdersObject:(EntityOrder *)value;
- (void)addChildOrders:(NSSet *)values;
- (void)removeChildOrders:(NSSet *)values;

@end
