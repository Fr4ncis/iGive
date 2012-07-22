//
//  Country.h
//  igive
//
//  Created by Samuel Colak on 7/22/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "DAO+Extensions.h"

@interface Country : NSManagedObject

    @property (nonatomic, retain) NSString * uid;
    @property (nonatomic, retain) NSString * title;
    @property (nonatomic, retain) NSString * smscode;

    @property (nonatomic, readonly, getter = getCharities) NSArray *charities;

    + (Country *) new:(NSDictionary *)values;
    + (Country *) new:(NSString *)uid title:(NSString *)title smscode:(NSString *)smscode;

    + (Country *) withId:(NSString*)uid;

    + (NSArray *) all;

@end
