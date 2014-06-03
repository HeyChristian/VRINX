//****************************************************************************//
//  [ PopupExtension.m ]                                                      //
//****************************************************************************//
//
//  Copyright (c) 2013 Kaoru Sakurazaka
//   https://github.com/kaoru-sakurazaka
//

#include "PopupExtension.h"

// -----------------------------------------------------------------------
//	[PopupRotationTransformWithOrientation]
//	  in  @ UIInterfaceOrientation orientation
//	  out @ CGAffineTransform
CGAffineTransform PopupRotationTransformWithOrientation( UIInterfaceOrientation orientation ){
    switch( orientation ){
        case UIInterfaceOrientationPortrait:
            return CGAffineTransformMakeRotation(M_PI*0.0);
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGAffineTransformMakeRotation(M_PI*1.0);
        case UIInterfaceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(M_PI*1.5);
        case UIInterfaceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(M_PI*0.5);
    }
}
