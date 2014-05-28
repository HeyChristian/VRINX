//
//  ContactListTableViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/27/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "ContactListTableViewController.h"
#import "APContact.h"
#import "APAddressBook.h"
#import "MONActivityIndicatorView.h"
#import "ContactCell.h"
#import "DataGenerator.h"

@interface ContactListTableViewController ()<MONActivityIndicatorViewDelegate>

@property (retain, nonatomic)  MONActivityIndicatorView *indicatorView;

@end

@implementation ContactListTableViewController

@synthesize indicatorView;

#pragma mark - life cycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        addressBook = [[APAddressBook alloc] init];
    }
    return self;
}

#pragma mark - appearance

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 3;
    indicatorView.radius = 20;
    indicatorView.internalSpacing = 3;
    indicatorView.duration = 0.5;
    indicatorView.delay = 0.5;
    indicatorView.center = self.view.center;
    [self.view addSubview:indicatorView];
   
    
    [self loadContacts];

    
    separator = [DataGenerator wordsFromLetters];
    indexes = [separator valueForKey:@"headerTitle"];
    
}

#pragma mark - table view data source implementation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

#pragma mark - table view delegate implementation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
     //return [separator count];
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [separator objectAtIndex:section];
}*/

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.contacts count];
    //return 0;//return [[[self.contacts objectAtIndex:section] objectForKey:@"FirstName"] count] ;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    APContact *contact = (APContact *)[self.contacts objectAtIndex:indexPath.row];
    
    [cell configureCellForEntry:contact];
    return cell;
}

#pragma mark - private

- (void)loadContacts
{
     [indicatorView startAnimating];
   // __weak __typeof(self) weakSelf = self;
    
    addressBook.fieldsMask = APContactFieldAll;
    
    addressBook.sortDescriptors = @[
                                    [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES],
                                    [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]];
    addressBook.filterBlock = ^BOOL(APContact *contact)
    {
        return contact.phones.count > 0 && contact.firstName.length > 0;
    };
    [addressBook loadContacts:^(NSArray *contacts, NSError *error)
     {
         [indicatorView stopAnimating];
         if (!error)
         {
             self.contacts = [[NSMutableArray alloc] initWithArray:contacts];
             [self.tableView reloadData];
             
         }
         else
         {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:error.localizedDescription
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
             [alertView show];
         }
     }];
}

@end
