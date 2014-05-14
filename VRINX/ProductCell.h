//
//  ProductCell.h
//  VRINX
//
//  Created by Christian Vazquez on 5/14/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EntityProduct;


@interface ProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemLogo;
@property (weak, nonatomic) IBOutlet UILabel *itemNameField;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionField;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceField;


-(void)configureCellForEntry:(EntityProduct *)product;

@end
