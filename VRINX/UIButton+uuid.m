//
//  UIButton+uuid.m
//  VRINX
//
//  Created by Christian Vazquez on 5/25/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "UIButton+uuid.h"

@implementation UIButton (uuid)



//@dynamic identifier;


-(void) setIdentifier:(NSString *)identifier{
    self.identifier=identifier;
}
-(NSString *) identifier{
    return self.identifier;
}

@end
