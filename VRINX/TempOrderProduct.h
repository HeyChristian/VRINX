//
//  TempOrderProduct.h
//  VRINX
//
//  Created by Christian Vazquez on 5/19/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TempProduct.h"

@interface TempOrderProduct : NSObject

    @property (nonatomic, retain) NSNumber * itemCount;
    @property (nonatomic, retain) TempProduct *product;

@end