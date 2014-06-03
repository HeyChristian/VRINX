//****************************************************************************//
//  [ PopupBackgroundView.m ]                                                 //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import "PopupBackgroundView.h"

//============================================================================//
//  <PopupBackgroundView>                                                     //
//============================================================================//
@implementation PopupBackgroundView

@synthesize delegate;

// -----------------------------------------------------------------------
//	[initWithFrame]
//	  in  @ (CGRect)frame
//	  out @ id
- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if( self ){
        self.opaque = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.alpha = 0.0;
    }
    return self;
}

// -----------------------------------------------------------------------
//	[drawRect]
//	  in  @ (CGRect)rect
//	  out @ none
- (void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake( self.bounds.size.width*0.5, self.bounds.size.height*0.5 );
    float radius = MIN( self.bounds.size.width , self.bounds.size.height );

    CGFloat locations[2] = { 0.0f, 1.0f };
    CGFloat colors[8] = {
        0.0f,0.0f,0.0f,0.0f,
        0.0f,0.0f,0.0f,0.8f
    };

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents( colorSpace, colors, locations, sizeof(locations)/sizeof(CGFloat) );
    CGColorSpaceRelease(colorSpace);
    CGContextDrawRadialGradient( context, gradient, center, 0, center, radius, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation );
    CGGradientRelease( gradient );
}

// -----------------------------------------------------------------------
//	[touchesBegan]
//	  in  @ (NSSet*)touches
//        @ withEvent:(UIEvent*)event
//	  out @ none
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    [self.delegate popupBackgroundView:self touches:touches withEvent:event];
}

// -----------------------------------------------------------------------
//	[show]
//	  in  @ none
//	  out @ none
- (void)show{
    id animations = ^{
        self.alpha = 1.0;
    };
    
    [UIView animateWithDuration:0.2 animations:animations];
}

// -----------------------------------------------------------------------
//	[dismiss]
//	  in  @ none
//	  out @ none
- (void)dismiss{
    
    id animations = ^{
        self.alpha = 0.0;
    };
    
    id completion = ^( BOOL finished ){
        if( finished )  [self removeFromSuperview];
    };
    
    [UIView animateWithDuration:0.2 animations:animations completion:completion];
}

@end
