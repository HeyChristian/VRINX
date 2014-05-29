//
//  AddressBookPeoplePickerViewController.h
//  AddressBookPeoplePicker
//
//  Created by Scott Carter on 5/4/13.
//

#import <UIKit/UIKit.h>
#import "APContact.h"

@protocol AddressBookDelegate <NSObject>     //define a protocol named
- (void) setSelectedContact:(APContact *)contact;
@end

@interface AddressBookPeoplePickerViewController : UIViewController

@property (nonatomic, assign) id<AddressBookDelegate>delegate; //create a delegate
@property (nonatomic,strong) APContact *contactSelected;

@end
