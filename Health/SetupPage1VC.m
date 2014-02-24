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

    if (![self validateInputInView:self.view]){
        
        return;
    }
    
    if ([_inchField.text intValue]>11)
    {_inchField.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:_NameTextField.text forKey:@"name"];
    [prefs setObject:_birthField.text forKey:@"birth"];
    [prefs setInteger:[_feetField.text intValue] forKey:@"feet"];
    [prefs setInteger:[_inchField.text intValue]forKey:@"inch"];
    [prefs setInteger:[_weightFiled.text intValue] forKey:@"weight"];
    [prefs synchronize];
    
       [self.stepsController showNextStep];
}


- (IBAction)previousStepTapped:(id)sender {
    [self.stepsController showPreviousStep];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.stepsController showPreviousStep];
}


@end
