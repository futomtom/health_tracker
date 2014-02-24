//
//  MainViewController.m
//  Health
//
//  Created by Alex on 2/14/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "BButton.h"
#import "GiftCardCell.h"
#import "Person.h"
#import "NSString+FontAwesome.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]





@interface LoginViewController ()
{
    NSMutableArray *_objectChanges;
    NSMutableArray *_sectionChanges;
}


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
  //  NSArray *colorArray = @[@0xfb0a2a, @0x02adea, @0x00405d,@0xffcc33,@0xffff00,@0xff0000,@0xfcd20b,@0xe47911,@0xa4c639,@0x1d8dd5,@0x003366];
    
    [super viewDidLoad];
    self.title=@"Exercise Log";
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = appDelegate.managedObjectContext;
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [self configureWalkTroughView];
    }
 //   [_AddBtn addAwesomeIcon:FAIconPlusSign beforeTitle:YES];
//      [_AddBtn addBigAwesomeIcon:FAIconPlusSign beforeTitle:YES Size:18];
//    [_AddBtn setColor:[UIColor bb_facebookColor]];
    
    
 // [_AlexBtn addAwesomeIcon:FAIconUser beforeTitle:YES];
   // NSInteger randcolor=colorArray[arc4random()%11];
    // [_AlexBtn setColor:UIColorFromRGB(randcolor)];
    
    [self.collectionView setContentInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    NSError *error = nil;
    //fetch data
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Error fetching data, %@", error);
        abort();
    }
    
    self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meal_tutorial_dimmer_gallery-568h"]];
    
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



- (IBAction)AddNewUSer:(id)sender {
    Person *newUser = (Person*)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    RMNavStepsViewController *agcvc = [self.storyboard instantiateViewControllerWithIdentifier:@"newuser"];
    agcvc.thenewUser = newUser;
    agcvc.delegate = self;
    [self presentViewController:agcvc
                       animated:YES
                     completion:^(void){
                         NSLog(@"Picker View Controller is presented");
                     }];


}

- (IBAction)doLogin:(id)sender {
    
    [self performSegueWithIdentifier:@"gotoMain" sender:nil];
    
}


-(void)AddRMNavStepsViewControllerDidSave:(Person*)newUser
{

    NSError *error = nil;
    if(![self.managedObjectContext save:&error]){
        NSLog(@"Error Saving %@", error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];
}

-(void)AddRMNavStepsViewControllerDidCancel:(Person*)newUser
{
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:newUser];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"adduser"]){
        Person *newUser = (Person*)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
        RMNavStepsViewController *agcvc = (RMNavStepsViewController*) segue.destinationViewController;
        agcvc.thenewUser = newUser;
        agcvc.delegate = self;
      //  agcvc.managedObjectContext = self.managedObjectContext;
     
    }
    else if([[segue identifier] isEqualToString:@"gotoMain"]){
        MainViewController *mainvc = (MainViewController*)[segue destinationViewController];
        Person *user = [self.fetchedResultsController objectAtIndexPath:_selectedIndex];
        mainvc.currentUser = user;
       // mainvc.managedObjectContext = (NSManagedObjectContext*)self.managedObjectContext;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath;
    [self performSegueWithIdentifier:@"gotoMain" sender:nil];
}



-(NSFetchedResultsController *)fetchedResultsController{
    if(_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}



#pragma mark - Fetched Results Delegate
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    
}



#pragma mark - Get and deal with changed content
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_objectChanges addObject:change];
}


-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSMutableDictionary *change = [NSMutableDictionary new];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = @[@(sectionIndex)];
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = @[@(sectionIndex)];
            break;
    }
    
    [_sectionChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([_sectionChanges count] > 0)
    {
        [self.collectionView performBatchUpdates:^{
            for (NSDictionary *change in _sectionChanges)
            {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    [self.collectionView reloadData];
    [_sectionChanges removeAllObjects];
}


//basic

#pragma mark - Colection view customization functions

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"%lu",(unsigned long)[[self.fetchedResultsController sections] count]);
    
    return [[self.fetchedResultsController sections] count];
    
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    NSLog(@"ItemsInSection %d",(unsigned long)[secInfo numberOfObjects]);

    if([secInfo numberOfObjects]==0)
    {
        int y=self.collectionView.frame.size.height/2;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, y, 320, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        
        
        NSString *title = [NSString stringWithFormat:@"%@  Add User to Start", @"\uf007"];
        titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:32];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text=title;
        titleLabel.tag =100;
       
        [self.collectionView.backgroundView addSubview:titleLabel];
       
    }
    else
    {   UIView *viewToRemove = [self.collectionView viewWithTag:100];
        if(viewToRemove)
            [viewToRemove removeFromSuperview];
       
    }
  

    return [secInfo numberOfObjects];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(140, 140);
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GiftCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    NSLog(@"%@",person.image);
    if([person.image length]==0)
        cell.ImageV.image=[UIImage imageNamed:@"defaultHeadSmall@2x.png"];
    else
        cell.ImageV.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:person.image]];
    
    cell.Title.text = person.name;
    return cell;
}




@end
