//
//  AccountCell.h
//  VRINX
//
//  Created by Christian Vazquez on 5/12/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EntityAccount;
@interface AccountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *accountName;


-(void)configureCellForEntry:(EntityAccount *)account;


@end
