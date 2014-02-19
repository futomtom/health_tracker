//
//  MainViewController.m
//  Health
//
//  Created by Alex on 2/14/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]





@interface LoginViewController ()

//Walkthrough
@property (nonatomic, strong) NSArray *walkthroughViewDescriptions;
@property (nonatomic, strong) GHWalkThroughView *walkthroughView;
@property (nonatomic, strong) NSArray *walkthroughViewTitles;
@property (nonatomic, strong) UILabel *walkthroughLabel;


@end

@implementation LoginViewController

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
    NSArray *colorArray = @[@0xfb0a2a, @0x02adea, @0x00405d,@0xffcc33,@0xffff00,@0xff0000,
                            @0xfcd20b,@0xe47911,@0xa4c639,@0x1d8dd5,@0x003366];
    
    [super viewDidLoad];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [self configureWalkTroughView];
    }
 //   [_AddBtn addAwesomeIcon:FAIconPlusSign beforeTitle:YES];
      [_AddBtn addBigAwesomeIcon:FAIconPlusSign beforeTitle:YES Size:18];
    [_AddBtn setColor:[UIColor bb_facebookColor]];
    
    
    [_AlexBtn addAwesomeIcon:FAIconUser beforeTitle:YES];
    NSInteger randcolor=colorArray[arc4random()%11];
     [_AlexBtn setColor:UIColorFromRGB(randcolor)];
    
    [_Kevin addAwesomeIcon:FAIconUser beforeTitle:YES];
     randcolor=colorArray[arc4random()%11];
    [_Kevin setColor:UIColorFromRGB(randcolor)];
    
    [_JeanBtn addAwesomeIcon:FAIconUser beforeTitle:YES];
     randcolor=colorArray[arc4random()%11];
    [_JeanBtn setColor:UIColorFromRGB(randcolor)];
    
    
   
    
	
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
  
    NSString *myString = [prefs stringForKey:@"User"];
  //  NSString *myString = @"Alex";
    
    if(myString)
    {
        CGRect frame=CGRectMake(40, 230, 108, 108);
       
        BButton *button = [[BButton alloc] initWithFrame:frame type:BButtonTypeSuccess style:BButtonStyleBootstrapV3];
       
        [button setTitle:myString forState:UIControlStateNormal];
        [button addTarget:self action:@selector(doLogin:)forControlEvents:UIControlEventTouchUpInside];
       
        
        //[button sizeToFit];
       // button.backgroundColor = [UIColor blueColor];
       // button.center = self.view.center;
        [self.view addSubview:button];
        
    }

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureWalkTroughView
{
    NSString *title1 = @"Easy to track activity";
    NSString *title2 = @"Track your sleep";
    NSString *title3 = @"Skin Sensitivity Notice";
    NSString *title4 = @"Ciclovías y rutas seguras";
    NSString *title5 = @"Disfruta";
    
    NSString *description1 = @"Forcebit makes it easy to track activity, sync stats, see trends and reach goals.";
    
    NSString *description2 = @"A powerful Force for everyday fitness, this sleek wristband is with you all the time. Stay motivated to keep moving with real-time stats right on your wrist. Track steps taken, distance traveled, calories burned, stairs climbed and active minutes throughout the day. At night, track your sleep and wake up silently with a vibrating alarm.";
    
    NSString *description3 = @" small percentage of Forcebi users have reported skin redness, swelling, itchiness or other skin irritations. If you experience these symptoms, please discontinue use. If symptoms persist, see a physician.";
    
    NSString *description4 = @"Ya no te arriesgues, utiliza las principales ciclovías y rutas seguras. disfruta de la ciudad.";
    
    NSString *description5 = @"Nada es comparable al sencillo placer de dar un paseo en bicicleta...";
    
    _walkthroughView = [[GHWalkThroughView alloc] initWithFrame:self.navigationController.view.bounds];
    [_walkthroughView setDataSource:self];
    //   [_walkthroughView setDelegate:self];
    [_walkthroughView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    //   [_walkthroughView setCloseTitle:@"Saltar"];
    _walkthroughLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    _walkthroughLabel.text = @"Force";
    _walkthroughLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40];
    _walkthroughLabel.textColor = [UIColor whiteColor];
    _walkthroughLabel.textAlignment = NSTextAlignmentCenter;
    [_walkthroughView setFloatingHeaderView:_walkthroughLabel];
    
    
    _walkthroughViewTitles = @[title1, title2, title3, title4, title5];
    _walkthroughViewDescriptions = @[description1, description2, description3, description4, description5];
    _walkthroughView.isfixedBackground = YES;
    _walkthroughView.bgImage = [UIImage imageNamed:@"bg_01.jpg"];
    [_walkthroughView showInView:self.navigationController.view animateDuration:0.3];
}

#pragma mark - GHDataSource

-(NSInteger) numberOfPages
{
    return 3;
}

- (void) configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index
{
    cell.title = _walkthroughViewTitles[index];
    switch(index)
    {
        case 0:
            cell.titleImage = [UIImage imageNamed:@"Forcebit"]; break;
        case 1:
        cell.titleImage = [UIImage imageNamed:@"oobe_wireless_band_arm_black"]; break;
        case 2:
            cell.titleImage = [UIImage imageNamed:@"heart-beat-chart.jpg"]; break;
    };
    cell.desc = _walkthroughViewDescriptions[index];
}



- (IBAction)doLogin:(id)sender {
    
    [self performSegueWithIdentifier:@"gotoMain" sender:nil];
    
}
@end
