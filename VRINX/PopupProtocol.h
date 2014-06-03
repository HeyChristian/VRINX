//****************************************************************************//
//  [ PopupProtocol.h ]                                                       //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#import <Foundation/Foundation.h>
#import "PopupExtension.h"

@protocol PopupBackgroundView;

//============================================================================//
//  <PopupBackgroundViewDelegate> protocol                                    //
//============================================================================//
@protocol PopupBackgroundViewDelegate <NSObject>
@required

-(void)popupBackgroundView:(UIView<PopupBackgroundView>*)view touches:(NSSet*)touches withEvent:(UIEvent*)event;

@end

//============================================================================//
//  <PopupBackgroundView> protocol                                            //
//============================================================================//
@protocol PopupBackgroundView <NSObject>
@required

@property(nonatomic,assign) id<PopupBackgroundViewDelegate> delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)show;
- (void)dismiss;

@end

//============================================================================//
//  <PopupView> protocol                                                      //
//============================================================================//
@protocol PopupView <NSObject>
@required

@property(nonatomic) BOOL touchedBackgroundDisappear;

-(void)doShow;
-(void)doRemoveFromSuperView:(BOOL)animated;
-(void)willChangeOrientation:(UIInterfaceOrientation)newOrientation animated:(BOOL)animated;
-(void)didChangeOrientation:(UIInterfaceOrientation)orientation;

@end
