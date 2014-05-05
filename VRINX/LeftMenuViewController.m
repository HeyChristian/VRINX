//
//  LeftMenuViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UIViewController+RESideMenu.h"


@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //    self.leftMenuTableView = ({
    //        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
    //        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    //        tableView.delegate = self;
    //        tableView.dataSource = self;
    //        tableView.opaque = NO;
    //        tableView.backgroundColor = [UIColor clearColor];
    //        tableView.backgroundView = nil;
    //        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //        tableView.bounces = NO;
    //        tableView.scrollsToTop = NO;
    //        tableView;
    //    });
    //   [self.view addSubview:self.leftMenuTableView];
    
    
    //self.leftMenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
    self.leftMenuTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    self.leftMenuTableView.delegate = self;
    self.leftMenuTableView.dataSource = self;
    self.leftMenuTableView.opaque = NO;
    self.leftMenuTableView.backgroundColor = [UIColor clearColor];
    self.leftMenuTableView.backgroundView = nil;//[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Stars"]];
    self.leftMenuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftMenuTableView.bounces = NO;
    self.leftMenuTableView.scrollsToTop = NO;
    //self.leftMenuTableView.style = UITableViewStylePlain;
    
    [self.view setBackgroundColor:nil];
    [self.view addSubview:self.leftMenuTableView];
    
    
    //UINavigationBar *navigationBar      = [UINavigationBar appearance];
    //navigationBar.tintColor             = [UIColor whiteColor];
    //navigationBar.backgroundColor       = [UIColor colorWithRed:0.94 green:0.47 blue:0.47 alpha:1.0];
    // self.navigationController.navigationBar  = [UINavigationBar appearance];
    
    //    [self.navigationController.navigationBar  setBackgroundColor:[UIColor colorWithRed:0.94 green:0.47 blue:0.47 alpha:1.0]];
}




#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // switch (indexPath.row) {
    //    case 2:
    
    if(indexPath.row == 2){
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AccountsViewController"]] animated:YES];
        
        
        UINavigationBar *navigationBar      = [UINavigationBar appearance];
        navigationBar.tintColor             = [UIColor whiteColor];
        navigationBar.backgroundColor       = [UIColor colorWithRed:0.94 green:0.47 blue:0.47 alpha:1.0];
        
        
        [self.sideMenuViewController hideMenuViewController];
    }else if(indexPath.row ==4){
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileController"]]
                                                     animated:YES];
        
        UINavigationBar *navigationBar      = [UINavigationBar appearance];
        navigationBar.tintColor             = [UIColor whiteColor];
        navigationBar.backgroundColor       = [UIColor colorWithRed:0.94 green:0.47 blue:0.47 alpha:1.0];
        [self.sideMenuViewController hideMenuViewController];
        
        
    }
    
    
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"",@"",@"Accounts", @"Calendar", @"My Profile", @"Settings", @"Log Out"];
    NSArray *images = @[@"IconEmpty",@"IconEmpty",@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

@end
