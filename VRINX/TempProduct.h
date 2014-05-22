//
//  TempProduct.h
//  VRINX
//
//  Created by Christian Vazquez on 5/19/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempProduct : NSObject

@property (nonatomic, retain) NSManagedObjectID *objectID;
@property (nonatomic, retain) NSData * itemPhoto;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * shortDesc;
@property (nonatomic, retain) NSString * uuid;
@end
