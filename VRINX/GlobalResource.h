//
//  GlobalResource.h
//  VRINX
//
//  Created by Christian Vazquez on 5/28/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APContact.h"

@class EntityAccount;

@interface GlobalResource : NSObject{
    
    APContact *_selectedContact;
    EntityAccount  *_account;
    NSString *_backSegueIdentifier;
}



+ (GlobalResource *)sharedInstance;

    @property(strong, nonatomic, readwrite) APContact *selectedContact;
    @property(strong, nonatomic, readwrite) EntityAccount *account;
    @property(strong, nonatomic, readwrite) NSString *backSegueIdentifier;

@end
