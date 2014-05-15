//
//  OrderMasterViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/15/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderMasterViewController.h"
#import "RMDateSelectionViewController.h"

@interface OrderMasterViewController ()<RMDateSelectionViewControllerDelegate>

//@property (strong, nonatomic) NSIndexPath *datePickerIndexPath;
//@property (strong,nonatomic)NSDate *orderDate;

@end

@implementation OrderMasterViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    
    self.orderDateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    
    self.orderCell.hidden = YES;
    
    
}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 0;
}*/
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 1) {
        [self openDateSelectionControllerWithBlock:self];
    }// else if (indexPath.section == 0 && indexPath.row == 1) {
       // [self openDateSelectionControllerWithBlock:self];
    //}
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - RMDateSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    //Do something
    
    
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    //Do something else
}
#pragma mark - Actions
- (IBAction)openDateSelectionController:(id)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    dateSelectionVC.titleLabel.text = @"This is an example title.\n\nPlease choose a date and press 'Select' or 'Cancel'.";
    
    //You can enable or disable bouncing and motion effects
    //dateSelectionVC.disableBouncingWhenShowing = YES;
    //dateSelectionVC.disableMotionEffects = YES;
    
    [dateSelectionVC show];
    
    //You can access the actual UIDatePicker via the datePicker property
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.minuteInterval = 5;
    dateSelectionVC.datePicker.date = [NSDate date];//[NSDate dateWithTimeIntervalSince1970:NSDate:0];
    
    //You can also adjust colors (enabling example will result in a black version)
    //dateSelectionVC.tintColor = [UIColor whiteColor];
    //dateSelectionVC.backgroundColor = [UIColor colorWithWhite:0.25 alpha:1];
}

- (IBAction)openDateSelectionControllerWithBlock:(id)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    
    //You can enable or disable bouncing and motion effects
    //dateSelectionVC.disableBouncingWhenShowing = YES;
    //dateSelectionVC.disableMotionEffects = YES;
    
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSLog(@"Successfully selected date: %@ (With block)", aDate);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, yyyy"];
        
        self.orderDateLabel.text = [dateFormatter stringFromDate:aDate];
        
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, yyyy"];
        
        self.orderDateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
        
        
    }];
    
    //You can access the actual UIDatePicker via the datePicker property
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.minuteInterval = 1;
    dateSelectionVC.datePicker.date = [NSDate date];//[NSDate dateWithTimeIntervalSinceReferenceDate:0];
}

#pragma mark - Helpers


- (IBAction)selectOrderDate:(id)sender {
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    
    [dateSelectionVC show];
}
- (IBAction)setMultipleOrders:(id)sender {
    
  //  NSLog(@"state: %@", self.multipleOrderSwitch.on);
    
    if(self.multipleOrderSwitch.on){
        self.orderCell.hidden=NO;
        self.productCell.hidden=YES;
        
    
    }else{
        self.productCell.hidden=NO;
        self.orderCell.hidden=YES;
    }
    
}
@end
