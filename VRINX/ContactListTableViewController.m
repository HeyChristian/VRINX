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

NSArray *alphabets;

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
   
    alphabets = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    [self loadContacts];

    
  
    
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [alphabets count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *title = [self.contacts objectForKey:@"section"];
    return [title objectAtIndex:section];
    
    // return [[contentArray objectAtIndex:section] objectForKey:@"GroupName"];
    //return [alphabets objectAtIndex:section];
    
    //return [[self.contacts sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    
    NSArray *items = [self.contacts objectForKey:@"section"];
    return [[[items objectAtIndex:section] valueForKey:@"contact.@.count"] intValue];
    
   // return [self.contacts count];
    //return [[[contentArray objectAtIndex:section] valueForKeyPath:@"contents.@count"] intValue];

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *contactList = [self.contacts objectForKey:@"contact"];
    
    APContact *contact = (APContact *)[contactList objectAtIndex:indexPath.row];
    
  //  NSString *sectionTitle = [alphabets objectAtIndex:indexPath.section];
    
    
  //  NSArray *sectionAnimals = [self.contacts objectForKey:<#(id)#>];
   // NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
    
    
    
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
            self.contacts = [[NSDictionary alloc] init];
           
             for(APContact *tempC in contacts){
                 
                 [self.contacts setValue:[tempC.firstName substringWithRange:NSMakeRange(0,1)] forKey:@"section"];
                 [self.contacts setValue:tempC forKey:@"contact"];
                 
             }
             
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
