//
//  EmptyOrderProductCell.h
//  VRINX
//
//  Created by Christian Vazquez on 5/17/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyOrderProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *EmptyMessagelabel;

- (IBAction)AddProductAction:(id)sender;

@end
