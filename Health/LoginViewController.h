//
//  MainViewController.h
//  Health
//
//  Created by Alex on 2/14/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHWalkThroughView.h"
#import "BButton.h"

@interface LoginViewController : UIViewController<GHWalkThroughViewDataSource>
@property (strong, nonatomic) IBOutlet BButton *AddBtn;

@property (strong, nonatomic) IBOutlet BButton *AlexBtn;
@property (strong, nonatomic) IBOutlet BButton *Kevin;
@property (strong, nonatomic) IBOutlet BButton *JeanBtn;
- (IBAction)doLogin:(id)sender;

@end
