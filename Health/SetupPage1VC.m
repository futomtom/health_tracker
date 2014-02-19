//
//  SetupPage1VC.m
//  Health
//
//  Created by Alex on 2/18/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "SetupPage1VC.h"
#import "RMStepsController.h"




@interface SetupPage1VC ()




@end

@implementation SetupPage1VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [_NameTextField  setRequired:YES];
    [_birthField setDateField:YES];
    [_feetField setRequired:YES];
    [_inchField setRequired:YES];
    [_weightFiled setRequired:YES];
   
 
  
       
	
    

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)validateInputInView:(UIView*)view
{
    for(UIView *subView in view.subviews){
        if ([subView isKindOfClass:[UIScrollView class]])
            return [self validateInputInView:subView];
        
        if ([subView isKindOfClass:[DemoTextField   class]])
        {
            if (![(MHTextField*)subView validate]){
                return NO;
            }
        }
    }
    
    return YES;
}


#pragma mark - Actions
- (IBAction)nextStepTapped:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"autologin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (![self validateInputInView:self.view]){
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:_NameTextField.text forKey:@"User"];
/*
    if ([_HeightField.text isEqualToString:@""])
    { _HeightField.backgroundColor=[UIColor redColor];
        return;
    }
 */
    
       [self.stepsController showNextStep];
}


- (IBAction)previousStepTapped:(id)sender {
    [self.stepsController showPreviousStep];
}




@end
