//
//  ContactListTableViewController.h
//  VRINX
//
//  Created by Christian Vazquez on 5/27/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class APAddressBook;

@interface ContactListTableViewController : UITableViewController
{
    APAddressBook *addressBook;
    NSArray *separator;
    NSArray *indexes;
}

@property(nonatomic,strong) NSMutableArray *contacts;

@end
