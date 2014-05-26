//
//  OrderMasterViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/15/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderMasterViewController.h"
#import "OrderProductViewController.h"
#import "RMDateSelectionViewController.h"
#import "TempProduct.h"
@interface OrderMasterViewController ()<RMDateSelectionViewControllerDelegate,UITextFieldDelegate,OrderProductDelegate>

//@property (strong, nonatomic) NSIndexPath *datePickerIndexPath;
//@property (strong,nonatomic)NSDate *orderDate;

@end

@implementation OrderMasterViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.orderNumberField.delegate = self;
    self.taxField.delegate=self;
    self.shippingField.delegate=self;
    [self.view endEditing:YES];
    
    
    self.orderProducts = [[NSMutableArray alloc] init];
    
    
}
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"orderProducts"] || [segue.identifier isEqualToString:@"orderProductsBtn"]){
        
        OrderProductViewController  *newProduct = (OrderProductViewController *) segue.destinationViewController;
        newProduct.delegate = self;
        newProduct.account = self.account;
        newProduct.orderProducts = self.orderProducts;
        NSLog(@"Order Product Account: %@", newProduct.account);
    }
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view endEditing:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    
    self.orderDateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    
    self.orderCell.hidden = YES;
    
    
}
#pragma mark - Order Product Delegate Functions
-(void) setOrderProduct:(NSMutableArray *)orderProducts{
    self.orderProducts = orderProducts;
    
    int count=0;
    
    for(TempOrderProduct *op in orderProducts){
        count += op.itemCount.intValue;
    }
    
    self.productCountLabel.text = [NSString stringWithFormat:@"( %d )",count];
    
}

#pragma mark - Table view data source

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
    
    [self.view endEditing:YES];
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
    [self.view endEditing:YES];
    if(self.multipleOrderSwitch.on){
        self.orderCell.hidden=NO;
        self.productCell.hidden=YES;
        
    
    }else{
        self.productCell.hidden=NO;
        self.orderCell.hidden=YES;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
