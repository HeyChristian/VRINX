//
//  AccountCell.h
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"


@class EntityAccount;
@interface AccountCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *accountName;

@property (weak, nonatomic) IBOutlet UILabel *accountDescription;

-(void)configureCellForEntry:(EntityAccount *)account;

@property (weak, nonatomic) IBOutlet UIView *TitleView;

@end
