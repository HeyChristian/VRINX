//
//  EntityContactOrder.h
//  VRINX
//
//  Created by Christian Vazquez on 6/5/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EntityContactOrder : NSManagedObject

@property (nonatomic, retain) NSString * addressBookID;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * fullAddress;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * lastName;

@end
