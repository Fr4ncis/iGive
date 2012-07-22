//
//  Category.h
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "DataController.h"

@interface Category : NSManagedObject

    @property (nonatomic, retain) NSString * uid;
    @property (nonatomic, retain) NSString * title;
    @property (nonatomic, retain) NSString * color;

    @property (nonatomic, readonly, getter = getCharities) NSArray *charities;

    + (Category *) new:(NSDictionary *)values;
    + (Category *) new:(NSString *)uid title:(NSString *)title;
    + (Category *) new:(NSString *)uid title:(NSString *)title color:(NSString *)color;

    + (Category *) withId:(NSString*)uid;

    + (NSArray *) all;

@end
