//
//  OrderProductCell.h
//  VRINX
//
//  Created by Christian Vazquez on 5/17/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIButton+uuid.h"

@class EntityProduct;

@interface OrderProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemLogo;
@property (weak, nonatomic) IBOutlet UILabel *itemNameField;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionField;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceField;
@property (weak, nonatomic) IBOutlet UITextField *itemCountField;


-(void)configureCellForEntry:(EntityProduct *)product andItemCount:(int) itemCount;


@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;


@end
