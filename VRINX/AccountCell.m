//
//  AccountCell.m
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//
#import "UIImage+RoundedImage.h"
#import "AccountCell.h"
#import "EntityAccount.h"
@implementation AccountCell




-(void)configureCellForEntry:(EntityAccount *)account{
    
   // NSLog(@" Account: %@",account);
    
    //Check Options for Table Cell
    //https://github.com/CEWendel/SWTableViewCell
    
    
    
    if(account.logo){
        UIImage *logo = [UIImage imageWithData:account.logo];
   
        CGSize size= CGSizeMake(320,100);
        logo = [UIImage imageWithImage:logo scaledToSize:size];
     
        if([account.showLogo intValue]==1){
            self.logoView.image = logo;
            
        }else{
           self.logoView.image=nil;
        }
        
    }else{
        self.logoView.image=nil;
        
    }
    bool showName=false;
    bool showDesc=false;
    
    
    if([account.showName intValue]==1 || account.showName == nil){
        showName=true;
        self.accountName.text = account.name;
        
    }else{
        self.accountName.text=nil;
    }
    
    if([account.showDescription intValue] ==1 || account.showDescription==nil ){
        showDesc=true;
        self.accountDescription.text = account.shortDesc;
        
    }else{
        self.accountDescription.text=nil;
    }
    if(showName || showDesc){
        self.TitleView.hidden=false;
    }else{
        self.TitleView.hidden=true;
    }
    
    
    if(showName || showDesc){
        self.TitleView.hidden=false;
    }else{
        self.TitleView.hidden=true;
    }
    
    
}

@end
