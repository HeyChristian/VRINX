//
//  CusAlertView.h
//  VRINX
//
//  Created by Christian Vazquez on 5/7/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusAlertView : UIView{
    CGPoint lastTouchLocation;
    CGRect originalFrame;
    BOOL isShown;
}

@property (nonatomic) BOOL isShown;

- (void)show;
- (void)hide;

@end