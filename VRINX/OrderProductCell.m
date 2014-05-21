//
//  OrderProductCell.m
//  VRINX
//
//  Created by Christian Vazquez on 5/17/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "OrderProductCell.h"
#import "EntityProduct.h"


@implementation OrderProductCell



- (IBAction)addToCart:(id)sender {
    
    
   // NSLog(@" add to cart!!");
   // UIStepper *stepper = (UIStepper *) sender;
    
   // stepper.maximumValue = 100;
   // stepper.minimumValue = 0;
    int count=  self.itemStepper.value; //[self.itemCountField.text intValue];
    
    
    if (self.itemStepper){
        count++;
        [self.itemCountField setText:[NSString stringWithFormat:@"x %d",count]];
    }
    else{
        count--;
        [self.itemCountField setText:[NSString stringWithFormat:@"x %d",count]];
        
    }
    
    /*
    UIView *view = [sender superview]; //to recover the superview
    self = (UITableViewCell *) [[view superview] superview]; //this is making a cast to get the cell of the stepper (the one that was pressed)
    NSIndexPath *indexPath = [self.tableView indexPathForCell:self.selectedCell ]; // to get the index path and help me refresh that cell in specific
    
    self.selectedRow = [[NSArray alloc]initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:self.selectedRow withRowAnimation:UITableViewRowAnimationAutomatic]; // to refresh the selected cell
*/
    
   // NSLog(@"item count: %d", count);
    
}

-(void)configureCellForEntry:(EntityProduct *)product{
    
   // NSLog(@" product: %@",product);
    
    self.itemNameField.text = product.name;
    self.itemDescriptionField.text =  product.shortDesc;
    self.itemPriceField.text = [self formatCurrency:product.price];
    
    if(product.itemPhoto){
        self.itemLogo.image = [UIImage imageWithData:product.itemPhoto];
        
        
    }else{
        
        self.itemLogo.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
    [self setSquaredConernersToImageView];
    
}

- (void)setSquaredConernersToImageView {
    self.itemLogo.layer.cornerRadius = self.itemLogo.frame.size.width / 2;
    self.itemLogo.clipsToBounds = YES;
    
    self.itemLogo.layer.cornerRadius = 5.0f;
    
    self.itemLogo.layer.borderWidth = 2.0f;
    self.itemLogo.layer.borderColor = [UIColor lightTextColor].CGColor;
}


#pragma mark - Helpers

-(NSString *)formatCurrency:(NSNumber *)number{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:number];
}
@end
