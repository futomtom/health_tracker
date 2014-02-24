//
//  Person.h
//  Health
//
//  Created by Alex on 2/21/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSDate * birth;
@property (nonatomic, retain) NSNumber * feet;
@property (nonatomic, retain) NSNumber * inch;

@end
