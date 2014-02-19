//
//  IntroPageVC.m
//  M13InfiniteTabBar
//
//  Created by Alex on 1/24/14.
//  Copyright (c) 2014 Brandon McQuilkin. All rights reserved.
//

#import "IntroPageVC.h"
#import "InfoPageCell.h"



@interface IntroPageVC ()

@end

@implementation IntroPageVC

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
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.rowHeight = 80;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ForceReload:) name:@"MovieDetail" object:nil];
  //  [_tableview registerClass:[InfoPageCell class] forCellReuseIdentifier:@"cell"];
    

}
-(void)ForceReload:(NSNotification *)notification
{
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    NSArray *imgArray = @[@"AbsTrainer", @"ArmsTrainer", @"ButtTrainer",@"ChestTrainer"];
    NSArray *TitleArray = @[@"Abs", @"Arm", @"Butt",@"Chest"];
   // NSArray *resultArray = @[@"1", @"2", @"1.5",@"4"];
    
  
   // UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    InfoPageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.imageView.image=[UIImage imageNamed:imgArray[indexPath.row]];
    cell.textLabel.text=TitleArray[indexPath.row];
    cell.detailtextLabel.text=[NSString stringWithFormat:@"%d",arc4random()%10];
    
    
    
  
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate chartIt:indexPath.row];
    /*
    switch (indexPath.row) {
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
     */
}


@end
