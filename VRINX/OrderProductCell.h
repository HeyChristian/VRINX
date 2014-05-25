//
//  OrderProductCell.h
//  VRINX
//
//  Created by Christian Vazquez on 5/17/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EntityProduct;

@interface OrderProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemLogo;
@property (weak, nonatomic) IBOutlet UILabel *itemNameField;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionField;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceField;
@property (weak, nonatomic) IBOutlet UITextField *itemCountField;

@property (weak, nonatomic) IBOutlet UIStepper *itemStepper;

- (IBAction)addToCart:(id)sender;

-(void)configureCellForEntry:(EntityProduct *)product andItemCount:(int) itemCount;
@end
