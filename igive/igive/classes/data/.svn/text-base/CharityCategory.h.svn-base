//
//  CharityCategory.h
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "DAO+Extensions.h"

@interface CharityCategory : NSManagedObject

    @property (nonatomic, retain) NSNumber * uid;
    @property (nonatomic, retain) NSString * uid_charity;
    @property (nonatomic, retain) NSString * uid_category;
    @property (nonatomic, retain) NSDate * date_created;
    @property (nonatomic, retain) NSNumber * primary;

    + (CharityCategory *) new:(NSDictionary *)values;
    + (CharityCategory *) new:(NSString*)uid_charity uid_category:(NSString*)uid_category is_primary:(BOOL)is_primary;

    + (CharityCategory *) withId:(uint64_t)uid;
    + (CharityCategory *) withCharity:(NSString*)uid_charity uid_category:(NSString*)uid_category;

    + (NSArray *) all;
    + (NSArray *) allForCategory:(NSString *)uid_category;
    + (NSArray *) allForCharity:(NSString *)uid_charity;

@end
