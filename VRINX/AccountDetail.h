//
//  AccountDetail.h
//  VRINX
//
//  Created by Christian Vazquez on 5/13/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EntityAccount;

@interface AccountDetail : UITableViewController


@property (nonatomic,strong)EntityAccount *account;

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *earningsLabel;
@property (weak, nonatomic) IBOutlet UILabel *missingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@end
