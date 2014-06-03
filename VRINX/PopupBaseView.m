//****************************************************************************//
//  [ PopupBaseView.m ]                                                       //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import "PopupBaseView.h"
#import "PopupController.h"

//============================================================================//
//  <PopupBaseView> externsion                                                //
//============================================================================//
@interface PopupBaseView()

@property(nonatomic) BOOL popupControl;

@end

//============================================================================//
//  <PopupBaseView>                                                           //
//============================================================================//
@implementation PopupBaseView

@synthesize touchedBackgroundDisappear;

// -----------------------------------------------------------------------
//	[initWithSize]
//	  in  @ (CGSize)size
//	  out @ id
- (id)initWithSize:(CGSize)size{
    return ( self = [self initWithFrame:CGRectMake( 0, 0, size.width, size.height )] );
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
        self.backgroundColor = [UIColor whiteColor];
        self.hidden = YES;
        self.opaque = YES;
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
