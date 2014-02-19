//
//  KFDayOfTheWeekViewController.m
//  What to cook
//
//  Created by Виталий Кузьменко on 07/01/14.
//  Copyright (c) 2014 KuzmenkoFamily. All rights reserved.
//

#import "MainViewController.h"

#import "IntroPageVC.h"
#import "AMBlurView.h"


#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

#import "DMAlphaTransition.h"
#import "DMScaleTransition.h"





@interface MainViewController ()


@property (strong, nonatomic) AMBlurView *blurView;

@property (strong, nonatomic) UILabel *dayLabel;
@property (strong, nonatomic) UILabel *monthLabel;

@property (strong, nonatomic) NSMutableArray *daysArray;
@property (strong, nonatomic) UIScrollView *daysScrollView;
@property (strong, nonatomic) UIView *selectedCircle;

@property (nonatomic,assign) NSUInteger previewPageIndex;



//@property (strong, nonatomic) KFDatePicker *datePicker;

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
 //   id delegate = [[UIApplication sharedApplication] delegate];
 //   self.managedObjectContext = [delegate managedObjectContext];
    [self NavigationBarTransparent];
    
    if (!self.currentDate) {
        [self setCurrentDate:[NSDate date]];
    }
    
    self.previewPageIndex=1;
    
    NSDate *weekDay = self.currentDate;
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"EEEE";
    NSString *date = [myDateFormatter stringFromDate:weekDay];
    self.navigationItem.title = date;
    //self.title=@"hello";
   

   // self.navigationItem.title = @"hello";
    [self initTopDay];
    
    
 
}


- (void)NavigationBarTransparent
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


- (UIView *)getTableFoter
{
    CGFloat height = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.blurView.bounds) - 50;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:view.frame];
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"On this day, the menu has not yet been compiled.";
    [view addSubview:textLabel];
    return textLabel;
}


- (void)setCurrentDate:(NSDate *)currentDate
{
    NSCalendar *myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComp = [myCalendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:currentDate];
    NSDate *newDate = [myCalendar dateFromComponents:dateComp];
    _currentDate = newDate;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
 

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Calendar View


- (void)initTopDay
{
    CGFloat barHeight = 64;
    
    AMBlurView *blurView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 180)];
    
    
    
    [self.view addSubview:blurView];
    self.blurView = blurView;
   
    
    UIView *borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(blurView.frame) - 0.5, CGRectGetWidth(self.view.frame), 0.5)];
    borderBottom.backgroundColor = [UIColor lightGrayColor];
    [blurView addSubview:borderBottom];
    
    CGRect frame = self.view.frame;
    frame.size.height = CGRectGetHeight(self.view.frame) - CGRectGetHeight(blurView.frame) + barHeight;
    frame.origin.y = CGRectGetHeight(blurView.frame) - barHeight;
   // self.tableView.frame = frame;
    
    NSDate *weekDay = self.currentDate;
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"d";
    NSString *date = [myDateFormatter stringFromDate:weekDay];
    
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    dayLabel.center = CGPointMake(160, 105);
    dayLabel.text = date;
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:80];
    dayLabel.textColor = self.view.tintColor;
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.userInteractionEnabled = YES;
    self.dayLabel = dayLabel;
  
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [dayLabel addGestureRecognizer:tapGestureRecognizer];
    
    

    myDateFormatter.dateFormat = @"MMMM";
    NSString *month = [myDateFormatter stringFromDate:weekDay];

    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 52, CGRectGetWidth(self.view.frame), 20)];
    monthLabel.text = month;
    monthLabel.font = [UIFont fontWithName:nil size:12];
    monthLabel.textColor = self.view.tintColor;
    monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel = monthLabel;
    
    
    UIButton *prevDayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    prevDayButton.center = CGPointMake(65, 109);
    [prevDayButton addTarget:self action:@selector(prevDay) forControlEvents:UIControlEventTouchUpInside];
    [prevDayButton setBackgroundImage:[UIImage imageNamed:@"Left Chevron"] forState:UIControlStateNormal];
    
    UIButton *nexDayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    nexDayButton.center = CGPointMake(255, prevDayButton.center.y);
    [nexDayButton addTarget:self action:@selector(nextDay) forControlEvents:UIControlEventTouchUpInside];
    [nexDayButton setBackgroundImage:[UIImage imageNamed:@"Right Chevron"] forState:UIControlStateNormal];
    
    [self initMonthDays];
    
    [blurView addSubview:prevDayButton];
    [blurView addSubview:nexDayButton];
    [blurView addSubview:dayLabel];
    [blurView addSubview:monthLabel];
}

- (void)initMonthDays
{
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"d";
    NSInteger dayIndex = [[myDateFormatter stringFromDate:self.currentDate] integerValue] - 1;
    
    NSMutableArray *daysArray = [NSMutableArray array];
    NSInteger positionX = 15;
    for (int i = 0; i <= 30; i++) {
        UIButton *dayButton = [[UIButton alloc] initWithFrame:CGRectMake(positionX, 0, 30, 30)];
        [dayButton setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [dayButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    //    [dayButton setBackgroundImage:[UIImage imageWithColor:self.view.tintColor size:dayButton.frame.size] forState:UIControlStateHighlighted];
        dayButton.layer.borderColor = self.view.tintColor.CGColor;
        dayButton.layer.borderWidth = 0;
        dayButton.layer.cornerRadius = 15;
        dayButton.clipsToBounds = YES;
        dayButton.tag = i + 1;
        positionX = positionX + 40;
        
        [dayButton addTarget:self action:@selector(loadDateByButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [daysArray addObject:dayButton];
    }
    self.daysArray = daysArray;
    
    UIScrollView *daysScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 145, CGRectGetWidth(self.view.frame), 30)];
    daysScrollView.showsHorizontalScrollIndicator = NO;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.currentDate];
    NSUInteger numberOfDaysInMonth = rng.length - 1;
    
    UIView *selectedCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    selectedCircle.layer.cornerRadius = 15;
    selectedCircle.clipsToBounds = YES;
    selectedCircle.backgroundColor = self.view.tintColor;
    selectedCircle.hidden = YES;
    self.selectedCircle = selectedCircle;
    [daysScrollView addSubview:selectedCircle];
    
    
    for (int i = 0; i <= numberOfDaysInMonth; i++) {
        UIButton *dayButton = [daysArray objectAtIndex:i];
        [daysScrollView addSubview:dayButton];
        if (dayIndex == dayButton.tag - 1) {
            [self setButton:dayButton active:YES];
        }
    }
    
    daysScrollView.contentSize = CGSizeMake(numberOfDaysInMonth * 40 + 60, 30);
    self.daysScrollView = daysScrollView;
    [self.blurView addSubview:daysScrollView];
   
}

- (void)updateDayButtonActive
{
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"d";
    NSInteger dayIndex = [[myDateFormatter stringFromDate:self.currentDate] integerValue] - 1;
    
    for (UIButton *button in self.daysArray) {
        NSInteger index = [self.daysArray indexOfObject:button];
        if (index == dayIndex) {
            [self setButton:button active:YES];
        } else {
            [self setButton:button active:NO];
        }
    }
}

- (void)setButton:(UIButton *)button active:(BOOL)active
{
    UIColor *textColor;
    UIColor *backgroundColor;
    if (active) {
        textColor = [UIColor whiteColor];
        backgroundColor = self.view.tintColor;
        
        CGFloat positionX = CGRectGetMinX(button.frame) - 160 + 15;
        CGFloat positionXB = button.center.x + 160 - 10;

        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.selectedCircle.center = button.center;
        } completion:^(BOOL finished) {
            if (positionX <= 0) {
                [self.daysScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            } else if (positionXB >= self.daysScrollView.contentSize.width) {
                [self.daysScrollView setContentOffset:CGPointMake(self.daysScrollView.contentSize.width - 320, 0) animated:YES];
            } else {
                [self.daysScrollView setContentOffset:CGPointMake(positionX, 0) animated:YES];
            }
            self.selectedCircle.hidden = NO;
            [button setTitleColor:textColor forState:UIControlStateNormal];
        }];
    } else {
        textColor = self.view.tintColor;
        backgroundColor = [UIColor clearColor];
        
            [button setTitleColor:textColor forState:UIControlStateNormal];

    }
    
}

- (void)loadDateByButton:(UIButton *)button
{

    NSDate *currentDate = self.currentDate;
    NSCalendar *myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [myCalendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                   fromDate:currentDate];
    
    [currentComps setDay:button.tag];
    NSDate *compDate = [myCalendar dateFromComponents:currentComps];

    [self loadDate:compDate];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"MovieDetail" object:nil];
}

#pragma mark - Calendar Actions

- (void)loadDate:(NSDate *)date
{
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    
    NSCalendar *myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentDateComps = [myCalendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                   fromDate:self.currentDate];

    NSDateComponents *newDateComps = [myCalendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                       fromDate:date];

    self.currentDate = date;
    
   //    [self.tableView reloadData];
    
    myDateFormatter.dateFormat = @"d";
    NSString *newDay = [myDateFormatter stringFromDate:date];
    myDateFormatter.dateFormat = @"EEEE";
    NSString *dayName = [myDateFormatter stringFromDate:date];
    self.dayLabel.text = newDay;
    myDateFormatter.dateFormat = @"MMMM";
    NSString *month = [myDateFormatter stringFromDate:date];
    self.monthLabel.text = month;
    
    {
        self.navigationItem.title = dayName;
    }
    if (currentDateComps.month != newDateComps.month) {
        [self reloadDaysScrollView];
    }
    [self updateDayButtonActive];
}

- (void)reloadDaysScrollView
{
    for (UIButton *button in self.daysArray) {
        [button removeFromSuperview];
    }
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.currentDate];
    NSUInteger numberOfDaysInMonth = rng.length - 1;
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"d";
    NSInteger dayIndex = [[myDateFormatter stringFromDate:self.currentDate] integerValue] - 1;
    
    for (int i = 0; i <= numberOfDaysInMonth; i++) {
        UIButton *dayButton = [self.daysArray objectAtIndex:i];
        [self.daysScrollView addSubview:dayButton];
        if (dayIndex == dayButton.tag - 1) {
            [self setButton:dayButton active:YES];
        }
    }
    
   
    
    self.daysScrollView.contentSize = CGSizeMake(numberOfDaysInMonth * 40 + 60, 30);
}

- (void)nextDay
{
    NSDate *newDay = [self.currentDate dateByAddingTimeInterval:86400];
    [self loadDate:newDay];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"MovieDetail" object:nil];
    

}

- (void)prevDay
{
    NSDate *newDay = [NSDate dateWithTimeInterval:-86400 sinceDate:self.currentDate];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MovieDetail" object:nil];
    
    [self loadDate:newDay];
}

- (void)showDatePicker:(UITapGestureRecognizer *)tap
{
  
}

- (void)applyDatePickerDate
{
//    [self loadDate:self.datePicker.datePicker.date];
//    [self.datePicker hide];
}


#pragma mark - GRKPageViewControllerDataSource

- (NSUInteger)pageCount
{
    
    return 3;
}

- (UIViewController *)viewControllerForIndex:(NSUInteger)index
{
    
   
    IntroPageVC *PageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
    PageVC.delegate=self;
    
   // PageVC.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood"]];
    
    
//    UIImage *image=[UIImage imageNamed:Item.image_filepath];
    //  NSLog(@"%@",Item.image_filepath);
    
    //   NSLog(@"%@",Item.description);
  /*
    dispatch_async(dispatch_get_main_queue(), ^{
        [PageVC.IntroTxt setText:Item.description];
        [PageVC.IntroimageV setImage:image];
    });
   */
    
    
    return PageVC;
}

#pragma mark - GRKPageViewControllerDelegate

- (void)changedIndexOffset:(CGFloat)indexOffset forPageViewController:(GRKPageViewController *)controller
{
  //  NSLog(@"Index Offset: %f", indexOffset);
}

- (void)changedIndex:(NSUInteger)index forPageViewController:(GRKPageViewController *)controller
{
    
    NSLog(@"index=%d",index);
    if (index==2)
    {
        [self nextDay];
        [self.pageViewController adjustCurrentIndex:1];
    }
    if (index==0)
    {
        [self prevDay];
        [self.pageViewController adjustCurrentIndex:1];
    }
    
    
    NSLog(@"current=%d",self.pageViewController.currentIndex);
   
  
}




#pragma mark - UINavigationController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *dest = segue.destinationViewController;
    if ([dest isKindOfClass:GRKPageViewController.class])
    {
        self.pageViewController = (GRKPageViewController *)dest;
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        [self.pageViewController setCurrentIndex:1 animated:NO];
        //  self.pageControl.numberOfPages = 5;   //[self pageCount];  BUG
      //  self.pageControl.currentPage = self.pageViewController.currentIndex;
    }
}

#pragma mark - IntroDelegate 

-(void)chartIt:(NSInteger)item
{
    NSLog(@"LineChart");
    switch (item) {
        case 0:
            [self LineChart];
            break;
        case 1:
            [self BarChart];
            break;
        case 2:
            [self LineChart];
            break;
        case 3:
            [self BarChart];
            break;
            
        default:
            break;
    }


}

#pragma mark - Chart
-(void)LineChart
{
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pnchart"];
    
    
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
    lineChartLabel.text = @"Line Chart";
    lineChartLabel.textColor = PNFreshGreen;
    lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    lineChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    
    NSDate *weekDay = self.currentDate;
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"LL/d";
    NSMutableArray * DateAry = [NSMutableArray new];
    
    
    for (int i=0; i<7; i++)
    {
          NSDate *newDay = [self.currentDate dateByAddingTimeInterval:-86400*(7-i)];
         NSString *date = [myDateFormatter stringFromDate:newDay];
        [DateAry addObject:date];
    }

    [lineChart setXLabels:DateAry];
    
    // Line Chart Nr.1
    NSMutableArray * value1Ary = [NSMutableArray new];
    
    for (int i=0; i<7; i++)
    {
        int value = arc4random()%8;
       
        [value1Ary addObject: [NSString stringWithFormat:@"%d",value]];
    }
    
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data01Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    
    //lineChart.delegate = self;
    
    [viewController.view addSubview:lineChartLabel];
    [viewController.view addSubview:lineChart];
    
    viewController.title = @"Exercise Time Chart";
    
    //    DMBaseTransition *Transition = [[DMBaseTransition alloc]init];
    DMAlphaTransition *Transition = [[DMAlphaTransition alloc]init];
    //     DMScaleTransition *Transition= [[DMScaleTransition alloc]init];
    [viewController setTransitioningDelegate:Transition];
  //  [self presentViewController:viewController animated:YES completion:nil];
    
    [self.navigationController pushViewController:viewController animated:NO];
    

    
    
}

-(void)BarChart
{
    
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pnchart"];
    
    //Add BarChart
    
    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
    barChartLabel.text = @"Bar Chart";
    barChartLabel.textColor = PNFreshGreen;
    barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    barChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    barChart.backgroundColor = [UIColor clearColor];
    
    NSDate *weekDay = self.currentDate;
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"LL/d";
    NSMutableArray * DateAry = [NSMutableArray new];
    
    
    for (int i=0; i<7; i++)
    {
        NSDate *newDay = [self.currentDate dateByAddingTimeInterval:-86400*(7-i)];
        NSString *date = [myDateFormatter stringFromDate:newDay];
        [DateAry addObject:date];
    }

    
    [barChart setXLabels:DateAry];
    
     NSMutableArray * value1Ary = [NSMutableArray new];
    for (int i=0; i<7; i++)
    {
        int value = arc4random()%8;
        
        [value1Ary addObject: [NSString stringWithFormat:@"%d",value]];
    }
    
    [barChart setYValues:value1Ary];
    [barChart setStrokeColors:@[PNGreen,PNMauve,PNRed,PNWeiboColor,PNBrown,PNYellow,PNRed]];
    [barChart strokeChart];
    
    [viewController.view addSubview:barChartLabel];
    [viewController.view addSubview:barChart];
    
    viewController.title = @"Exercise Time Chart";
    //    DMBaseTransition *Transition = [[DMBaseTransition alloc]init];
    //DMAlphaTransition *Transition = [[DMAlphaTransition alloc]init];
    DMScaleTransition *Transition= [[DMScaleTransition alloc]init];
    [viewController setTransitioningDelegate:Transition];
   // [self presentViewController:viewController animated:YES completion:nil];
     [self.navigationController pushViewController:viewController animated:NO];
    
}





#pragma mark - UIScroppViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    
}

@end
