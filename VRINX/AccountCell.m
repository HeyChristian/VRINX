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
#import "Tools.h"

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
    
    
   
    self.leftUtilityButtons = [self leftButtons];
   self.rightUtilityButtons = [self rightButtons];
    
}
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];

    /*
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    */
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
      [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                               icon:[UIImage imageNamed:@"list.png"]];
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    //334d5c
   
    UIColor *colorOrder = [Tools colorWithHexString:@"2399FF"];
    
    UIColor *colorProduct = [Tools colorWithHexString:@"FFAE63"];
  // CGSize size = CGSizeMake(52,52);
    
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:colorOrder title:@"Orders"];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:colorProduct title:@"Products"];
    /*
     
     [leftUtilityButtons sw_addUtilityButtonWithColor:colorOrder icon:[UIImage imageWithImage:[UIImage imageNamed:@"bag.png"] scaledToSize:size]];
     [leftUtilityButtons sw_addUtilityButtonWithColor:colorProduct icon:[UIImage imageWithImage:[UIImage imageNamed:@"tagprice.png"] scaledToSize:size]];
     
     
     */
    
    
   // [leftUtilityButtons sw_addUtilityButtonWithColor:colorOrder icon:[UIImage imageNamed:@"tag48W.png"]];
   // [leftUtilityButtons sw_addUtilityButtonWithColor:colorProduct icon:[UIImage imageNamed:@"tagprice.png"]];
    
   // [leftUtilityButtons sw_addUtilityButtonWithColor:colorProduct icon:[UIImage imageWithImage:[UIImage imageNamed:@"tag2.png"] scaledToSize:size]];
    
    
   // [leftUtilityButtons sw_addUtilityButtonWithColor:
   //  [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
      //                                          icon:[UIImage imageNamed:@"cross.png"]];
   // [leftUtilityButtons sw_addUtilityButtonWithColor:
    // [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
      //                                          icon:[UIImage imageNamed:@"list.png"]];
    
    return leftUtilityButtons;
}

@end
