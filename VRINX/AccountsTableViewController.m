//
//  AccountsTableViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "AccountsTableViewController.h"
#import "RESideMenu.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "AccountCell.h"
#import "EntityAccount.h"
#import "AccountDetail.h"

#import "BEMSimpleLineGraphView.h"


@interface AccountsTableViewController ()<NSFetchedResultsControllerDelegate,BEMSimpleLineGraphDelegate>{
    int totalNumber;
}

@property(nonatomic,strong) NSFetchedResultsController *fetchResultsController;


@end

@implementation AccountsTableViewController


BEMSimpleLineGraphView *myGraph;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
  //  UIView *fixItView = [[UIView alloc] init];
  //  fixItView = CGRectMake(0, 0, 320, 20);
   // fixItView = [UIColor colorWithRed:0.973 green:0.973 blue:0.973 alpha:1]; //change this to match your navigation bar
   // [self.view addSubview:fixItView];
    
    
    
    //Display account sales graphics
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HeaderCell"];
	[self configureBannerWithImage:[UIImage imageNamed:@"headerback"] height:190];
	[self initGraph];
  
    
    
    
    
    
    
    [self.fetchResultsController performFetch:nil];
    
    
    
    
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationItem setHidesBackButton:NO animated:YES];
    [self.navigationController setToolbarHidden:YES];
    
    
    [self.fetchResultsController performFetch:nil];
    [self.tableView reloadData];
    
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"Detail"]){
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
        AccountDetail *accountDetail = (AccountDetail *) segue.destinationViewController;
        accountDetail.account = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    }
    
}

#pragma mark - Core Data Function
-(NSFetchRequest *)entryListFetchRequest{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
    
     fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    
    return fetchRequest;
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    
  
    [self.tableView beginUpdates];
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    switch(type){
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
    
}
-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    
    [self.tableView endUpdates];
    
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    
    switch(type){
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
    }
}


-(NSFetchedResultsController *) fetchResultsController{
    if(_fetchResultsController != nil){
        return _fetchResultsController;
    }
    
   CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
   NSFetchRequest *fetchRequest =[self entryListFetchRequest];
    
  //  _fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:@"name" cacheName:nil];
    
   
    _fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    
    _fetchResultsController.delegate = self;
    
    return _fetchResultsController;
    
    
    


    
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchResultsController sections][section];
    
    NSLog(@"# of Records : %lu", (unsigned long)[sectionInfo numberOfObjects]);
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    EntityAccount *entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    NSLog(@"Account CELL: %@",entry);
    
    [cell configureCellForEntry:entry];
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    EntityAccount *entry =[self.fetchResultsController objectAtIndexPath:indexPath];
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [[coreDataStack  managedObjectContext] deleteObject:entry];
    [coreDataStack saveContext];
    
    
}


- (IBAction)SlideLeftMenu:(id)sender {
    
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
}

- (void)validateUser
{
    PFUser *currentUser = [PFUser currentUser];
    
    if(!currentUser){
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }else{
        
        [self performSegueWithIdentifier:@"FillAnotherUserInfo" sender:self];
        
        
    }
}

- (UIView *)EmptyAccountView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
    [imageView setImage:[UIImage imageNamed:@"icn_picture"]];
    [view addSubview:imageView];
    
    return view;
}





#pragma mark - SimpleLineGraph

-(void) initGraph{
    
    self.ArrayOfValues = [[NSMutableArray alloc] init];
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    totalNumber = 0;
    
    self.ArrayOfDates = [NSMutableArray arrayWithObjects: @"January",@"Febrary",@"March",@"Abril",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"Dicember",nil]; // Dates for the X-Axis of the graph
    
    for (int i = 0; i < 9; i++) {
        [self.ArrayOfValues addObject:[NSNumber numberWithInteger:(arc4random() % 70000)]]; // Random values for the graph
       // [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:2000 + i]]]; // Dates for the X-Axis of the graph
        
        totalNumber = totalNumber + [[self.ArrayOfValues objectAtIndex:i] intValue]; // All of the values added together
    }
    
    myGraph= [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    myGraph.delegate = self;
    
    
    
    UIColor *color = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    
  //  myGraph.colorTop = [UIColor whiteColor];
    myGraph.colorBottom = color;
    //myGraph.backgroundColor = color;
    
    myGraph.alpha=1;
    // Customization of the graph
    myGraph.enableTouchReport = YES;
    myGraph.colorTop = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
   //  myGraph.colorBottom = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    
    myGraph.colorLine = [UIColor whiteColor];
    myGraph.colorXaxisLabel = [UIColor whiteColor];
    myGraph.widthLine = 3.0;
    myGraph.enableTouchReport = YES;
    myGraph.enablePopUpReport = YES;
    myGraph.enableBezierCurve = YES;
    
    [self.contentView addSubview:myGraph];
    
}


#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[self.ArrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.ArrayOfValues objectAtIndex:index] floatValue];
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    //return [self.ArrayOfDates count];
    return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [self.ArrayOfDates objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
  //  self.labelValues.text = [NSString stringWithFormat:@"%@", [self.ArrayOfValues objectAtIndex:index]];
   // self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.ArrayOfDates objectAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //self.labelValues.alpha = 0.0;
        //self.labelDates.alpha = 0.0;
    } completion:^(BOOL finished){
        
        //self.labelValues.text = [NSString stringWithFormat:@"%i", [[myGraph calculatePointValueSum] intValue]];
        //self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.ArrayOfDates lastObject]];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
          //  self.labelValues.alpha = 1.0;
           // self.labelDates.alpha = 1.0;
        } completion:nil];
    }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
   // self.labelValues.text = [NSString stringWithFormat:@"%i", [[myGraph calculatePointValueSum] intValue]];
  //  self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.ArrayOfDates lastObject]];
}


- (void)refresh{
    [self.ArrayOfValues removeAllObjects];
    [self.ArrayOfDates removeAllObjects];
    
    for (int i = 0; i < 14; i++) {
        [self.ArrayOfValues addObject:[NSNumber numberWithInteger:(arc4random() % 70000)]]; // Random values for the graph
        [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:2000 + i]]]; // Dates for the X-Axis of the graph
        
        totalNumber = totalNumber + [[self.ArrayOfValues objectAtIndex:i] intValue]; // All of the values added together
    }
    
    
    
    UIColor *color = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    myGraph.colorTop = color;
    myGraph.colorBottom = color;
    myGraph.backgroundColor = color;
    self.view.tintColor = color;
    //self.labelValues.textColor = color;
    self.navigationController.navigationBar.tintColor = color;
    
    [myGraph reloadGraph];
}
@end
