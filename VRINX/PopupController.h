//****************************************************************************//
//  [ PopupController.h ]                                                     //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import <QuartzCore/QuartzCore.h>
#import "PopupProtocol.h"

//============================================================================//
//  <PopupController>                                                         //
//============================================================================//
@interface PopupController : NSObject<PopupBackgroundViewDelegate>

@property(nonatomic,readonly)   NSUInteger count;

+(PopupController*)sharedPopupController;

-(BOOL)pushView:(UIView<PopupView>*)view;
-(BOOL)popView:(UIView<PopupView>*)view;

-(BOOL)popAllViews;

-(BOOL)tryUnloadBackgroundView;

@end
