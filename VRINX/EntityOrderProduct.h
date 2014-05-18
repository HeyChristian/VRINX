//
//  EntityOrderProduct.h
//  VRINX
//
//  Created by Christian Vazquez on 5/18/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityProduct;

@interface EntityOrderProduct : NSManagedObject

@property (nonatomic, retain) NSNumber * itemCount;
@property (nonatomic, retain) EntityProduct *products;

@end
