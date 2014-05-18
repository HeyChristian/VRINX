//
//  EntityProduct.h
//  VRINX
//
//  Created by Christian Vazquez on 5/17/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityAccount, EntityOrderProduct;

@interface EntityProduct : NSManagedObject

@property (nonatomic, retain) NSData * itemPhoto;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * shortDesc;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) EntityAccount *products;
@property (nonatomic, retain) EntityOrderProduct *orderProducts;

@end
