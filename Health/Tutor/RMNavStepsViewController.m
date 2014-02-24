//
//  RMAnotherDemoStepsViewController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RMNavStepsViewController.h"

@interface RMNavStepsViewController ()

@end

@implementation RMNavStepsViewController

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.stepsBar.hideCancelButton = YES;
}

#pragma mark - Actions
- (void)finishedAllSteps {
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _thenewUser.name =   [prefs objectForKey:@"name"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YYYY"];
    NSLog(@"%@",[prefs objectForKey:@"birth"]);
    NSDate *date = [dateFormatter dateFromString:[prefs objectForKey:@"birth"]];
    NSLog(@"%@", date);
    
    
    _thenewUser.birth =   date;
    _thenewUser.feet =   [prefs objectForKey:@"feet"];
    _thenewUser.inch =   [prefs objectForKey:@"inch"];
    _thenewUser.weight =   [prefs objectForKey:@"weight"];
    _thenewUser.image =   [prefs objectForKey:@"imagePath"];
    
    [self.delegate AddRMNavStepsViewControllerDidSave:_thenewUser];
    [self.navigationController popViewControllerAnimated:YES];
  //   [self performSegueWithIdentifier:@"gotomain2" sender:nil];
    
}

- (void)canceled {
    [self.delegate AddRMNavStepsViewControllerDidCancel:_thenewUser];
    [self.navigationController popViewControllerAnimated:YES];
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"adduser"]){
      [self.delegate AddRMNavStepsViewControllerDidCancel:_thenewUser];        
    }
   }

@end
