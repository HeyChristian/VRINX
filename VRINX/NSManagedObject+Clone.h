//
//  NSManagedObject+Clone.h
//  VRINX
//
//  Created by Christian Vazquez on 6/3/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Clone)
- (NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context exludeEntities:(NSArray *)namesOfEntitiesToExclude;
@end
