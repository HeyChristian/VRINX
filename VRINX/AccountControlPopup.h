//
//  AccountControlPopup.h
//  VRINX
//
//  Created by Christian Vazquez on 6/2/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "PopupBaseView.h"
#import "JDCarouselControl.h"

@interface AccountControlPopup : PopupBaseView


@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet JDCarouselControl *carousel;

@property (strong, nonatomic) NSArray *elementsToInsert;
@property (strong, nonatomic) NSArray *titlesArray;

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UIButton *disableButton;

- (IBAction)removeAll:(id)sender;
- (IBAction)stepperValueChanged:(id)sender;
- (IBAction)carouselValueChanged:(id)sender;
- (IBAction)disableButtonPress:(id)sender;

@end
