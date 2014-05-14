//
//  EntityOrderProduct.h
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityOrder, EntityProduct;

@interface EntityOrderProduct : NSManagedObject

@property (nonatomic, retain) NSNumber * itemCount;
@property (nonatomic, retain) NSSet *products;
@property (nonatomic, retain) EntityOrder *orderProducts;
@end

@interface EntityOrderProduct (CoreDataGeneratedAccessors)

- (void)addProductsObject:(EntityProduct *)value;
- (void)removeProductsObject:(EntityProduct *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
