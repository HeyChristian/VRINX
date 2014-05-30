//
//  GlobalResource.m
//  VRINX
//
//  Created by Christian Vazquez on 5/28/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "GlobalResource.h"

@implementation GlobalResource

@synthesize selectedContact = _selectedContact;
@synthesize account=_account;
@synthesize orderProducts = _orderProducts;
@synthesize backSegueIdentifier = _backSegueIdentifier;

+ (GlobalResource *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalResource *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalResource alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        
        _selectedContact = [[APContact alloc] init];
        _backSegueIdentifier = [[NSString alloc] init];
        _orderProducts = [[NSMutableArray alloc] init];
        //_account=[[EntityAccount alloc] init];
    }
    return self;
}

+ (void) ClearResources{
    GlobalResource *global =[GlobalResource sharedInstance];
    
    global.selectedContact = [[APContact alloc] init];
    global.backSegueIdentifier = [[NSString alloc] init];
    global.account=nil;
    global.orderProducts = [[NSMutableArray alloc] init];
    
    
}

@end
