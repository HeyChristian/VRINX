//
//  EntityClient.h
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EntityClient : NSManagedObject

@property (nonatomic, retain) NSString * clientName;

@end
