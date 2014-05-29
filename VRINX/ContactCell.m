//
//  ContactCell.m
//  VRINX
//
//  Created by Christian Vazquez on 5/27/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellForEntry:(APContact *)contact{
    
    
    
    
    self.firstName.text = [[NSString alloc] initWithFormat:@"%@ %@",contact.firstName,(contact.lastName != nil?contact.lastName:@"")];
    
    self.phoneNumber.text = [contact.phones objectAtIndex:0];
    
    if(contact.emails.count >0){
        self.emailAddress.text = [contact.emails objectAtIndex:0];
    }else{
        self.emailAddress.text =@"";
    }
    
    if(contact.photo!=nil){
        self.thumbnail.image = contact.photo;
    }
    
    
}


@end
