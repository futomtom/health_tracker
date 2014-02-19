//
//  SetupPage2VC.h
//  Health
//
//  Created by Alex on 2/19/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CTCheckbox.h"
#import "VPImageCropperViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface SetupPage2VC : UIViewController<VPImageCropperDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet CTCheckbox *MaleCheckBox;
@property (strong, nonatomic) IBOutlet CTCheckbox *FemaleCheckBox;

@property (strong, nonatomic) IBOutlet UIImageView *portraitImageView;
- (IBAction)editPortrait:(id)sender;

- (IBAction)nextStepTapped:(id)sender;
- (IBAction)previousStepTapped:(id)sender;
- (IBAction)CheckValueChange:(id)sender;

@end
