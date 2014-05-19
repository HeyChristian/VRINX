//
//  EntityAccount.h
//  VRINX
//
//  Created by Christian Vazquez on 5/18/14.
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
@property (nonatomic, retain) NSSet *orders;
@property (nonatomic, retain) NSSet *products;
@end

@interface EntityAccount (CoreDataGeneratedAccessors)

- (void)addOrdersObject:(EntityOrder *)value;
- (void)removeOrdersObject:(EntityOrder *)value;
- (void)addOrders:(NSSet *)values;
- (void)removeOrders:(NSSet *)values;

- (void)addProductsObject:(EntityProduct *)value;
- (void)removeProductsObject:(EntityProduct *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
