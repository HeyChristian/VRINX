//
//  EntityAccount.h
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityOrder, EntityProduct;

@interface EntityAccount : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * earningPercent;
@property (nonatomic, retain) NSDecimalNumber * earnings;
@property (nonatomic, retain) NSDecimalNumber * investment;
@property (nonatomic, retain) NSData * logo;
@property (nonatomic, retain) NSDecimalNumber * missed;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * shortDesc;
@property (nonatomic, retain) NSDecimalNumber * tax;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSSet *products;
@property (nonatomic, retain) NSSet *orders;
@end

@interface EntityAccount (CoreDataGeneratedAccessors)

- (void)addProductsObject:(EntityProduct *)value;
- (void)removeProductsObject:(EntityProduct *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

- (void)addOrdersObject:(EntityOrder *)value;
- (void)removeOrdersObject:(EntityOrder *)value;
- (void)addOrders:(NSSet *)values;
- (void)removeOrders:(NSSet *)values;

@end
