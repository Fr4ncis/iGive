//
//  Donation.h
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Charity.h"

#import "DAO+Extensions.h"

@interface Donation : NSManagedObject

    @property (nonatomic, retain) NSString * uid;
    @property (nonatomic, retain) NSDate * date_created;
    @property (nonatomic, retain) NSString * uid_charity;
    @property (nonatomic, retain) NSNumber * amount;
    @property (nonatomic, retain) NSString * reference;
    @property (nonatomic, retain) NSNumber * affected_count;

    @property (nonatomic, readonly, getter = getCharity) Charity *charity;

    + (Donation *) new:(NSDictionary *)values;
    + (Donation *) new:(NSString *)uid uid_charity:(NSString *)uid_charity amount:(CGFloat)amount reference:(NSString *)reference affected:(CGFloat)affected;

    + (Donation *) withId:(NSString*)uid;

    + (NSArray *) all;

    + (CGFloat) totalDonation;
    + (CGFloat) totalDonationForCharity:(NSString *)uid_charity;

@end
