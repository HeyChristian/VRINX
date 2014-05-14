//
//  ProductCell.m
//  VRINX
//
//  Created by Christian Vazquez on 5/14/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "ProductCell.h"
#import "EntityProduct.h"
@implementation ProductCell

-(void)configureCellForEntry:(EntityProduct *)product{
    
    NSLog(@" product: %@",product);
    
    
    if(product.itemPhoto){
        
        //self.logoView.image = [UIImage imageWithData:account.logo];
        //self.accountName.text = nil;
    }else{
        //self.accountName.text = account.name;
        
        //self.logoView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
}

@end
