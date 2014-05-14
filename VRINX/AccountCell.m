//
//  AccountCell.m
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "AccountCell.h"
#import "EntityAccount.h"
@implementation AccountCell




-(void)configureCellForEntry:(EntityAccount *)account{
    
    NSLog(@" Account: %@",account);
    
    
    if(account.logo){
        self.logoView.image = [UIImage imageWithData:account.logo];
        self.accountName.text = nil;
    }else{
        self.accountName.text = account.name;
        
        //self.logoView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
}

@end
