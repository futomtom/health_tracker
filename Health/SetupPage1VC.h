//
//  SetupPage1VC.h
//  Health
//
//  Created by Alex on 2/18/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "DemoTextField.h"
#import "Person.h"


@interface SetupPage1VC : UIViewController <UITextFieldDelegate>

- (IBAction)nextStepTapped:(id)sender;
- (IBAction)previousStepTapped:(id)sender;

@property (strong, nonatomic) IBOutlet DemoTextField *NameTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *inchField;

@property (strong, nonatomic) IBOutlet DemoTextField *birthField;
@property (strong, nonatomic) IBOutlet DemoTextField  *feetField;
@property (strong, nonatomic) IBOutlet DemoTextField *weightFiled;
@property (strong, nonatomic) Person *thenewUser;

@end
