//
//  OtherUserInfoTableViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OtherUserInfoTableViewController.h"
#import "UIImage+RoundedImage.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface OtherUserInfoTableViewController ()

@end

@implementation OtherUserInfoTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.leftBarButtonItem = nil;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 // Return the number of rows in the section.
    return 5;
}*/






- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 5.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
    
    if((indexPath.row == 0 && indexPath.section ==0) || (indexPath.row == 0 && indexPath.section == 3)){
        UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero]  init];
        backView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = backView;
    }
    
}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowsCount = 5; //[self tableView:tableView numberOfRowsInSection:indexPath.section];
    if (1 == rowsCount) {
        cell.contentView.layer.cornerRadius = 8.f;
        cell.contentView.layer.masksToBounds = YES;
    } else {
        if (0 == indexPath.row) {
            CGRect cellRect = cell.contentView.bounds;
            CGMutablePathRef firstRowPath = CGPathCreateMutable();
            CGPathMoveToPoint(firstRowPath, NULL, CGRectGetMinX(cellRect), CGRectGetMaxY(cellRect));
            CGPathAddLineToPoint(firstRowPath, NULL, CGRectGetMinX(cellRect), 8.f);
            CGPathAddArcToPoint(firstRowPath, NULL, CGRectGetMinX(cellRect), CGRectGetMinY(cellRect), 8.f, CGRectGetMinY(cellRect), 8.f);
            CGPathAddLineToPoint(firstRowPath, NULL, CGRectGetMaxX(cellRect) - 8.f, 0.f);
            CGPathAddArcToPoint(firstRowPath, NULL, CGRectGetMaxX(cellRect), CGRectGetMinY(cellRect), CGRectGetMaxX(cellRect), 8.f, 8.f);
            CGPathAddLineToPoint(firstRowPath, NULL, CGRectGetMaxX(cellRect), CGRectGetMaxY(cellRect));
            CGPathCloseSubpath(firstRowPath);
            
            CAShapeLayer *newSharpLayer = [[CAShapeLayer alloc] init];
            newSharpLayer.path = firstRowPath;
            newSharpLayer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor;
            CFRelease(firstRowPath);
            
            cell.contentView.layer.mask = newSharpLayer;
        } else if (indexPath.row == (rowsCount - 1)) {
            CGRect cellRect = cell.contentView.bounds;
            CGMutablePathRef lastRowPath = CGPathCreateMutable();
            CGPathMoveToPoint(lastRowPath, NULL, CGRectGetMinX(cellRect), CGRectGetMinY(cellRect));
            CGPathAddLineToPoint(lastRowPath, NULL, CGRectGetMaxX(cellRect), CGRectGetMinY(cellRect));
            CGPathAddLineToPoint(lastRowPath, NULL, CGRectGetMaxX(cellRect), CGRectGetMaxY(cellRect) - 8.f);
            CGPathAddArcToPoint(lastRowPath, NULL, CGRectGetMaxX(cellRect), CGRectGetMaxY(cellRect), CGRectGetMaxX(cellRect)- 8.f, CGRectGetMaxY(cellRect), 8.f);
            CGPathAddLineToPoint(lastRowPath, NULL, 8.f, CGRectGetMaxY(cellRect));
            CGPathAddArcToPoint(lastRowPath, NULL, CGRectGetMinX(cellRect), CGRectGetMaxY(cellRect), CGRectGetMinX(cellRect), CGRectGetMaxY(cellRect) - 8.f, 8.f);
            CGPathCloseSubpath(lastRowPath);
            
            CAShapeLayer *newSharpLayer = [[CAShapeLayer alloc] init];
            newSharpLayer.path = lastRowPath;
            newSharpLayer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor;
            CFRelease(lastRowPath);
            
            cell.contentView.layer.mask = newSharpLayer;
        }
    }
}

*/
- (IBAction)changeProfilePicture:(id)sender {
    
    if(self.image == nil){
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
        self.imagePicker.videoMaximumDuration = 10;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
        
        
    }
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        // A photo was taken/seleted
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if(self.imagePicker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
            // UIImageWriteToSavedPhotosAlbum(self.image, nil,nil,nil);
            // self.profilePictureField.image = self.image;
            
            
            UIImage *myRoundedImage = [UIImage roundedImageWithImage:self.image];
            
            
            UIImage *small = [UIImage imageWithCGImage:myRoundedImage.CGImage scale:0.05 orientation:myRoundedImage.imageOrientation];
            
            self.image = small;
            [self.imageProfile setImage:self.image];
            NSLog(@" image : %@",self.image);
            
        }
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)finishSetup:(id)sender {
}
@end
