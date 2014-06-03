//****************************************************************************//
//  [ PopupImageBaseView.m ]                                                  //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import "PopupImageBaseView.h"
#import "PopupController.h"
#import <QuartzCore/QuartzCore.h>

//============================================================================//
//  <PopupImageBaseView> extension                                            //
//============================================================================//
@interface PopupImageBaseView()

@property(nonatomic) BOOL popupControl;

@end

//============================================================================//
//  <PopupImageBaseView>                                                      //
//============================================================================//
@implementation PopupImageBaseView

@synthesize touchedBackgroundDisappear;

// -----------------------------------------------------------------------
//	[initWithFrame]
//	  in  @ (CGRect)frame
//	  out @ id
- (id)initWithImage:(UIImage *)image{

    self = [super initWithImage:image];
    if( self ){
        self.touchedBackgroundDisappear = YES;
        self.popupControl = NO;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.opaque = NO;
        self.alpha = 0.0;
    }
    return self;
}

// -----------------------------------------------------------------------
//	[initWithFrame]
//	  in  @ (CGRect)frame
//	  out @ id
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.touchedBackgroundDisappear = YES;
        self.popupControl = NO;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.opaque = NO;
        self.alpha = 0.0;
    }
    return self;
}

// -----------------------------------------------------------------------
//	[show]
//	  in  @ none
//	  out @ none
- (void)show{
    if( !self.popupControl ){
        self.popupControl = YES;
        [[PopupController sharedPopupController] pushView:self];
    }
}


// -----------------------------------------------------------------------
//	[dismiss]
//	  in  @ none
//	  out @ none
- (void)dismiss{
    if( self.popupControl ){
        self.popupControl = NO;
        [[PopupController sharedPopupController] popView:self];
    }
}

#pragma mark - PopupView
// -----------------------------------------------------------------------
//	[doShow]
//	  in  @ none
//	  out @ none
-(void)doShow{
    self.hidden = NO;
    self.alpha = 1.0;
}

// -----------------------------------------------------------------------
//	[doRemoveFromSuperView]
//	  in  @ (BOOL)animated
//	  out @ none
-(void)doRemoveFromSuperView:(BOOL)animated{
    [self removeFromSuperview];
}

// -----------------------------------------------------------------------
//	[willChangeOrientation]
//	  in  @ (UIInterfaceOrientation)newOrientation
//        @ animated:(BOOL)animated
//	  out @ none
-(void)willChangeOrientation:(UIInterfaceOrientation)newOrientation animated:(BOOL)animated{

}

// -----------------------------------------------------------------------
//	[didChangeOrientation]
//	  in  @ (UIInterfaceOrientation)orientation
//	  out @ none
-(void)didChangeOrientation:(UIInterfaceOrientation)orientation{
    
}

@end
