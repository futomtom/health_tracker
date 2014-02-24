//
//  KFDayOfTheWeekViewController.h
//  What to cook
//
//  Created by Виталий Кузьменко on 07/01/14.
//  Copyright (c) 2014 KuzmenkoFamily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRKPageViewController.h"
#import "IntroPageVC.h"
#import "Person.h"


typedef enum {
    KFDayOfTheWeekViewControllerSectionBreakfast,
    KFDayOfTheWeekViewControllerSectionLunch,
    KFDayOfTheWeekViewControllerSectionDinner
} KFDayOfTheWeekViewControllerSection;

//@class KFMyMenuViewController, KFDayOfTheWeek, KFDayOfTheWeekNavigationController;

@interface MainViewController : UIViewController <UIScrollViewDelegate, GRKPageViewControllerDataSource, GRKPageViewControllerDelegate,IntroPageVCDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,weak) GRKPageViewController *pageViewController;


@property (strong, nonatomic) NSDate *currentDate;
//@property (weak, nonatomic) KFMyMenuViewController *myMenuViewController;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButton;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *eventsBarButton;
@property (weak, nonatomic) Person *currentUser;


- (void)loadDate:(NSDate *)date;

@end
