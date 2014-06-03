//****************************************************************************//
//  [ PopupController.m ]                                                     //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import "PopupController.h"
#import "PopupBackgroundView.h"

//============================================================================//
//  <PopupController> extension                                               //
//============================================================================//
@interface PopupController()

@property(nonatomic,retain) NSMutableArray* popupViews;
@property(nonatomic,assign) UIView<PopupBackgroundView>* backgroundView;
@property(nonatomic,retain) UIView<PopupBackgroundView>* retainBackgroundView;

@end

//============================================================================//
//  <PopupController>                                                         //
//============================================================================//
@implementation PopupController

static PopupController* _sharedObject;

// -----------------------------------------------------------------------
//	[sharedPopupController]
//	  in  @ none
//	  out @ (PopupController*)
+(PopupController*)sharedPopupController{
    
    static dispatch_once_t onceToken;
    
    dispatch_once( &onceToken, ^{
        _sharedObject = [[PopupController alloc] init];
    } );
    
    return _sharedObject;
}

// -----------------------------------------------------------------------
//	[init]
//	  in  @ none
//	  out @ id
-(id)init{

    self = [super init];
    if( self ){
        self.popupViews = [NSMutableArray array];
        
        NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
        
        [notificationCenter addObserver:self selector:@selector(notifyWillChangeStatusBarOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
        [notificationCenter addObserver:self selector:@selector(notifyDidChangeStatusBarOrientation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        [notificationCenter addObserver:self selector:@selector(notifyDidReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}

// -----------------------------------------------------------------------
//	[dealloc]
//	  in  @ none
//	  out @ none
-(void)dealloc{
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];

    self.popupViews = nil;
    [self.backgroundView removeFromSuperview];
    self.retainBackgroundView = nil;
  //  [super dealloc];
}

// -----------------------------------------------------------------------
//	[pushView]
//	  in  @ (UIView<PopupView>*)view
//	  out @ BOOL
-(BOOL)pushView:(UIView<PopupView>*)view{

    UIWindow* window = [UIApplication sharedApplication].keyWindow;

    if( self.backgroundView ){
        UIView<PopupView>* popupView = [self.popupViews lastObject];
        [popupView doRemoveFromSuperView:YES];
    }else{
        CGRect frame = window.bounds;
        if( !self.retainBackgroundView ){
            self.retainBackgroundView = [[PopupBackgroundView alloc] initWithFrame:frame];
        }
        self.backgroundView = self.retainBackgroundView;
        self.backgroundView.delegate = self;
        [window addSubview:self.backgroundView];
        
        [self.backgroundView show];
    }
    
    [self.popupViews addObject:view];
    [self setPopupView:view window:window];

    return YES;
}

// -----------------------------------------------------------------------
//	[popView]
//	  in  @ (UIView<PopupView>*)view
//	  out @ BOOL
-(BOOL)popView:(UIView<PopupView>*)view{
    
    NSUInteger idx = [self.popupViews indexOfObject:view];
    if( idx == NSNotFound ) return NO;
    
    BOOL top = (self.popupViews.count == (idx+1));
    
    [view doRemoveFromSuperView:top];
    [self.popupViews removeObjectAtIndex:idx];

    if( top ){
        if( self.popupViews.count > 0 ){
            [self setPopupView:[self.popupViews lastObject] window:[UIApplication sharedApplication].keyWindow];
        }else{
            [self.backgroundView dismiss];
            self.backgroundView = nil;
        }
    }

    return YES;
}

// -----------------------------------------------------------------------
//	[popAllViews]
//	  in  @ none
//	  out @ BOOL
-(BOOL)popAllViews{
    if( self.popupViews.count == 0 )    return NO;
    UIView<PopupView>* view = [self.popupViews lastObject];
    
    [view doRemoveFromSuperView:YES];
    [self.popupViews removeAllObjects];

    [self.backgroundView dismiss];
    self.backgroundView = nil;

    return YES;
}

// -----------------------------------------------------------------------
//	[tryUnloadBackgroundView]
//	  in  @ (UIView<PopupView>*)view
//	  out @ BOOL
-(BOOL)tryUnloadBackgroundView{
    if( !self.retainBackgroundView.superview ){
        self.retainBackgroundView = nil;
        return YES;
    }
    return NO;
}

#pragma mark - Internal
// -----------------------------------------------------------------------
//	[setPopupView]
//	  in  @ (UIView<PopupView>*)view
//        @ (UIWindow*)window
//	  out @ none
-(void)setPopupView:(UIView<PopupView>*)view window:(UIWindow*)window{
    
    view.transform = CGAffineTransformIdentity;
    
    CGRect frame = view.frame;
    
    frame.origin.x = (window.bounds.size.width - frame.size.width ) * 0.5;
    frame.origin.y = (window.bounds.size.height - frame.size.height ) * 0.5;
    
    view.frame = frame;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    [view willChangeOrientation:orientation animated:NO];
    [view didChangeOrientation:orientation];
    
    [window addSubview:view];
    
    [view doShow];
}

#pragma mark - Notify
// -----------------------------------------------------------------------
//	[notifyWillChangeStatusBarOrientation]
//	  in  @ (NSNotification*)notify
//	  out @ none
-(void)notifyWillChangeStatusBarOrientation:(NSNotification*)notify{
    UIInterfaceOrientation orientation = [[notify.userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue];
    UIView<PopupView>* popupView = [self.popupViews lastObject];
    [popupView willChangeOrientation:orientation animated:YES];

}

// -----------------------------------------------------------------------
//	[notifyDidChangeStatusBarOrientation]
//	  in  @ (NSNotification*)notify
//	  out @ none
-(void)notifyDidChangeStatusBarOrientation:(NSNotification*)notify{
    UIInterfaceOrientation orientation = [[notify.userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue];
    UIView<PopupView>* popupView = [self.popupViews lastObject];
    [popupView didChangeOrientation:orientation];
}

// -----------------------------------------------------------------------
//	[notifyDidReceiveMemoryWarning]
//	  in  @ (NSNotification*)notify
//	  out @ none
-(void)notifyDidReceiveMemoryWarning:(NSNotification*)notify{
    [self tryUnloadBackgroundView];
}

#pragma mark - PopupBackgroundViewDelegate
// -----------------------------------------------------------------------
//	[popupBackgroundView]
//	  in  @ (UIView<PopupBackgroundView>*)view
//        @ (NSSet*)touches
//        @ (UIEvent*)event
//	  out @ none
-(void)popupBackgroundView:(UIView<PopupBackgroundView>*)view touches:(NSSet*)touches withEvent:(UIEvent*)event{
    
    UIView<PopupView>* popupView = [self.popupViews lastObject];
    if( popupView.touchedBackgroundDisappear ){
        for( UITouch* touch in touches ) {
            if( [popupView pointInside:[touch locationInView:popupView] withEvent:event] ){
                return;
            }
        }
        
        [self popView:popupView];
    }
}

#pragma mark - Property
// -----------------------------------------------------------------------
//	[count]
//	  in  @ none
//	  out @ NSUInteger
-(NSUInteger)count{
    return self.popupViews.count;
}

@end
