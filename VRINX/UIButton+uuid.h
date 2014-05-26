//
//  UIButton+uuid.h
//  VRINX
//
//  Created by Christian Vazquez on 5/25/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (uuid)

@property(nonatomic,assign) NSString *identifier;

-(void) setIdentifier:(NSString *)identifier;
-(NSString *) identifier;
@end
