//
//  EntityProduct.h
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EntityProduct : NSManagedObject

@property (nonatomic) int16_t price;
@property (nonatomic, retain) NSData * itemPhoto;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * shortDesc;

@end
