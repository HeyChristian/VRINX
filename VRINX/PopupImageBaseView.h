//****************************************************************************//
//  [ PopupImageView.h ]                                                      //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import <UIKit/UIKit.h>
#import "PopupProtocol.h"

//============================================================================//
//  <PopupImageBaseView>                                                      //
//============================================================================//
@interface PopupImageBaseView : UIImageView<PopupView>

- (id)initWithImage:(UIImage *)image;
- (void)show;
- (void)dismiss;

@end
