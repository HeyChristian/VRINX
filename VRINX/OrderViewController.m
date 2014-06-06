//
//  OrderViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderViewController.h"
#import "ChooseOrderTypeController.h"
#import "GlobalResource.h"
#import "EntityOrder.h"
#import "OrderCell.h"
#import "Tools.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    GlobalResource *global;

}

@end

@implementation OrderViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.orders = [[NSArray alloc] init];
    global = [GlobalResource sharedInstance];
    
    self.orders = [global.account.orders allObjects];
    
    self.tableView.dataSource =self;
    self.tableView.delegate =self;
    
    //initWithImage: [UIImage imageNamed:@"cusBack"]
    UIBarButtonItem *barBtnItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(performBack:)];
    [barBtnItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = barBtnItem;
    
    [self setupDataSource];
    //84
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    global.selectedContact=nil;
    global.orderProducts=[[NSMutableArray alloc] init];
    
}
-(IBAction)performBack:(id) sender{
    if(global.backSegueIdentifier.length > 0){
        [self performSegueWithIdentifier:global.backSegueIdentifier sender:nil];
    }else{
         [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void) setupDataSource
{
    NSMutableArray *unsortedDates = [[NSMutableArray alloc] init]; // [self.sections allKeys];
    
    for(EntityOrder *order in self.orders){
       [unsortedDates addObject:order.orderDate];
    }
    
   NSArray *sortedDateArray = [unsortedDates sortedArrayUsingSelector:@selector(compare:)];
    
    
    self.tableViewSections = [NSMutableArray arrayWithCapacity:0];
    self.tableViewCells = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = calendar.timeZone;
    [dateFormatter setDateFormat:@"MMMM YYYY"];
    
    NSUInteger dateComponents = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSInteger previousYear = -1;
    NSInteger previousMonth = -1;
    NSMutableArray* tableViewCellsForSection = nil;
    for (NSDate* date in sortedDateArray)
    {
        NSDateComponents* components = [calendar components:dateComponents fromDate:date];
        NSInteger year = [components year];
        NSInteger month = [components month];
        if (year != previousYear || month != previousMonth)
        {
            NSString* sectionHeading = [dateFormatter stringFromDate:date];
            [self.tableViewSections addObject:sectionHeading];
            tableViewCellsForSection = [NSMutableArray arrayWithCapacity:0];
            [self.tableViewCells setObject:tableViewCellsForSection forKey:sectionHeading];
            previousYear = year;
            previousMonth = month;
        }
        [tableViewCellsForSection addObject:date];
    }
}


#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.tableViewSections.count;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    id key = [self.tableViewSections objectAtIndex:section];
    NSArray* tableViewCellsForSection = [self.tableViewCells objectForKey:key];
    if(tableViewCellsForSection.count == 0){
        return 1;
    }else{
        return tableViewCellsForSection.count;
    }
}

- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.tableViewSections objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    NSInteger actualNumberOfRows = [self.orders count];
    if (actualNumberOfRows == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
        return cell;
    }else{
        
        OrderCell *ocell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        EntityOrder *order = [self.orders objectAtIndex:indexPath.row];
        //ocell.textLabel.text = [Tools  :order.orderDate];
        
        [ocell configureCellForEntry:order];
        
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 84, 320, .5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [ocell addSubview:line];
        return ocell;
        
    }
    // Produce the correct cell the usual way
    
    
    return cell;
}
-(NSString *) formatDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    
    return [dateFormatter stringFromDate:date];
    
}
@end
