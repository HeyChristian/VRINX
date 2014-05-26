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




-(void)configureCellForEntry:(EntityProduct *)product andItemCount:(int) itemCount{
    
   // NSLog(@" product: %@",product);
    
    self.itemNameField.text = product.name;
    self.itemDescriptionField.text =  product.shortDesc;
    self.itemPriceField.text = [self formatCurrency:product.price];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *pk = [f numberFromString:product.uuid];
    
    self.itemCountField.text = [[NSString alloc] initWithFormat:@"X %d",itemCount];
    self.addBtn.tag = pk.integerValue;
    self.removeBtn.tag = pk.integerValue;
    
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
