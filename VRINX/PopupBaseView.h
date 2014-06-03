//****************************************************************************//
//  [ PopupBaseView.h ]                                                       //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import <UIKit/UIKit.h>
#import "PopupProtocol.h"

//============================================================================//
//  <PopupBaseView>                                                           //
//============================================================================//
@interface PopupBaseView : UIView<PopupView>

- (id)initWithSize:(CGSize)size;
- (void)show;
- (void)dismiss;

@end
