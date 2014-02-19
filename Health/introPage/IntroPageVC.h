//
//  IntroPageVC.h
//  M13InfiniteTabBar
//
//  Created by Alex on 1/24/14.
//  Copyright (c) 2014 Brandon McQuilkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroPageVCDelegate <NSObject>

@optional
-(void)chartIt:(NSInteger *)item;

@end

@interface IntroPageVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) id<IntroPageVCDelegate> delegate;


@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end
