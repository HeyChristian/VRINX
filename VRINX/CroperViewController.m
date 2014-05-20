//
//  CroperViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/19/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "CroperViewController.h"
#import "PSCropToolView.h"

@interface CroperViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGRect normalOutputFrame;
}

@property (strong,nonatomic) PSCropToolView *croppingTool;
@property (strong,nonatomic) UIImageView *outputImageView;

@end

@implementation CroperViewController

@synthesize sourceImage;
@synthesize delegate; //synthesizing the delegate

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setToolbarHidden:NO];
    
    [self.navigationController setTitle:@"resize account logo"];
    
   
      // self.navigationController.rightBarButtonItem = btnSave;
    
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cropBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItem)UIBarButtonSystemItemDone target:self action:@selector(cropImage:)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:flexibleSpace,cropBtn ,flexibleSpace, nil];
    self.toolbarItems = toolbarItems;
    
    
    
    
    UIBarButtonItem *camBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(getInputImage:)];
    
    
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:camBarButtonItem, nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //crop tool initialization
    self.croppingTool = [[PSCropToolView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    [self.croppingTool imageToCrop:[self sourceImage]];
    self.croppingTool.outputSize = CGSizeMake(640, 240);
    self.croppingTool.cropAreaFillFactor = 1;
  //  self.croppingTool.requiredFillFactor = 1;
    
    self.croppingTool.backgroundColor = [UIColor whiteColor];
    
    //[self.croppingTool setRequiredFillFactor:1.0];
    [self.croppingTool setCropAreaBorderWidth:2.0];
    [self.croppingTool setCropAreaBorderColor:[UIColor yellowColor]];
    [self.view addSubview:self.croppingTool];
    
    
    
   /*
    UIButton *sourceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sourceButton setTitle:@"SOURCE" forState:UIControlStateNormal];
    [sourceButton addTarget:self action:@selector(getInputImage:) forControlEvents:UIControlEventTouchUpInside];
    sourceButton.frame = CGRectMake(0, CGRectGetHeight(self.croppingTool.frame)+2, 320, 33);
    [self.view addSubview:sourceButton];
    */
    
    /*
    UIButton *croopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [croopButton setTitle:@"CROP IMAGE" forState:UIControlStateNormal];
    [croopButton addTarget:self action:@selector(getOutputImage:) forControlEvents:UIControlEventTouchUpInside];
    croopButton.frame = CGRectMake(160, CGRectGetHeight(self.croppingTool.frame)+2, 160, 33);
    [self.view addSubview:croopButton];
    */
    UITapGestureRecognizer *outputTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outputImageTap:)];
    
    /*
    normalOutputFrame = croopButton.frame;
    normalOutputFrame.origin.x = 0;
    normalOutputFrame.origin.y += croopButton.frame.size.height+2;
    normalOutputFrame.size.width = 320;
    normalOutputFrame.size.height =  CGRectGetHeight(self.view.frame)-normalOutputFrame.origin.y;
   */
    
    
    self.outputImageView = [[UIImageView alloc] initWithFrame:normalOutputFrame];
    _outputImageView.gestureRecognizers = @[outputTapGesture];
    _outputImageView.userInteractionEnabled = YES;
    _outputImageView.backgroundColor = [UIColor blackColor];
    _outputImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_outputImageView];
}

- (void)getInputImage:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        //
    }];
}

- (void)getOutputImage:(id)sender
{
    [self.croppingTool getOutputImageAsync:^(UIImage *outputImage) {
        _outputImageView.image = outputImage;
        NSLog(@"croop complete image size:%@",CGSizeCreateDictionaryRepresentation(outputImage.size));
       
        
       
        
        [self.delegate setCroppedImage:outputImage]; //call the delegate method hear
    
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
  //  [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)outputImageTap:(id)sender
{
    [UIView animateWithDuration:.4f animations:^{
        CGRect fsFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        if (CGRectEqualToRect(fsFrame, _outputImageView.frame)) {
            _outputImageView.frame = normalOutputFrame;
        }else
        {
            _outputImageView.frame = fsFrame;
        }
    }];
}

-(void) cropImage:(id) sender{
    
    [self.delegate setCroppedImage:self.croppingTool.getOutputImage]; //call the delegate method hear
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.croppingTool imageToCrop:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (IBAction)cropAction:(id)sender {
}

- (IBAction)retakeAction:(id)sender {
}
@end
