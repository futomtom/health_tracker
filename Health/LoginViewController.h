//
//  MainViewController.h
//  Health
//
//  Created by Alex on 2/14/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHWalkThroughView.h"
#import "RMNavStepsViewController.h"
#import "AppDelegate.h"
#import "BButton.h"

@interface LoginViewController : UIViewController<GHWalkThroughViewDataSource,NSFetchedResultsControllerDelegate,RMNavStepsViewControllerDelegate>
//@property (strong, nonatomic) IBOutlet BButton *AddBtn;
//
//@property (strong, nonatomic) IBOutlet BButton *AlexBtn;

- (IBAction)AddNewUSer:(id)sender;

- (IBAction)doLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSIndexPath *selectedIndex;


@end
