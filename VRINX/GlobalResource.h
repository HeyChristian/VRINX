//
//  GlobalResource.h
//  VRINX
//
//  Created by Christian Vazquez on 5/28/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APContact.h"
#import "CoreDataStack.h"

@class EntityAccount,EntityOrder;

@interface GlobalResource : NSObject{
    
    APContact *_selectedContact;
    EntityAccount  *_account;
    NSMutableArray *_orderProducts;
    NSString *_backSegueIdentifier;
    NSDate *_selectedDate;
    CoreDataStack *_coreDataStack;
    EntityOrder *_selectedOrder;
}



+ (GlobalResource *)sharedInstance;
+ (void) ClearResources;

    @property(strong, nonatomic, readwrite) APContact *selectedContact;
    @property(strong, nonatomic, readwrite) EntityAccount *account;
    @property(strong, nonatomic, readwrite) EntityOrder *selectedOrder;
    @property(strong, nonatomic, readwrite) NSMutableArray *orderProducts;
    @property(strong, nonatomic, readwrite) NSString *backSegueIdentifier;
    @property(strong, nonatomic, readwrite) NSDate *selectedDate;
    @property(nonatomic)  CoreDataStack *coreDataStack;

@end
