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
    
    self.accountName.text = account.name;
    
    if(account.logo){
        self.logoView.image = [UIImage imageWithData:account.logo];
    }else{
        self.logoView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
}

@end
