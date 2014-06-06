//
//  EntityOrder.h
//  VRINX
//
//  Created by Christian Vazquez on 6/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityAccount, EntityContactOrder, EntityOrder, EntityOrderProduct;

@interface EntityOrder : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * additionalCostTotal;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDecimalNumber * discount;
@property (nonatomic, retain) NSDecimalNumber * granTotal;
@property (nonatomic, retain) NSNumber * isMasterOrder;
@property (nonatomic, retain) NSDecimalNumber * itemsTotal;
@property (nonatomic, retain) NSDate * orderDate;
@property (nonatomic, retain) NSDecimalNumber * shippingTotal;
@property (nonatomic, retain) NSString * shortDesc;
@property (nonatomic, retain) NSDecimalNumber * taxTotal;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSString * clientName;
@property (nonatomic, retain) NSString * clientCompany;
@property (nonatomic, retain) NSNumber * clientRecordID;
@property (nonatomic, retain) NSString * clientPhoneNumber;
@property (nonatomic, retain) NSString * clientPhoneLabel;
@property (nonatomic, retain) NSData * clientThumbnail;
@property (nonatomic, retain) NSString * clientEmailLabel;
@property (nonatomic, retain) NSString * clientEmail;
@property (nonatomic, retain) EntityAccount *accountOrders;
@property (nonatomic, retain) EntityContactOrder *contactOrder;
@property (nonatomic, retain) NSSet *orderProducts;
@property (nonatomic, retain) NSSet *orders;
@end

@interface EntityOrder (CoreDataGeneratedAccessors)

- (void)addOrderProductsObject:(EntityOrderProduct *)value;
- (void)removeOrderProductsObject:(EntityOrderProduct *)value;
- (void)addOrderProducts:(NSSet *)values;
- (void)removeOrderProducts:(NSSet *)values;

- (void)addOrdersObject:(EntityOrder *)value;
- (void)removeOrdersObject:(EntityOrder *)value;
- (void)addOrders:(NSSet *)values;
- (void)removeOrders:(NSSet *)values;

@end
