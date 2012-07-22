//
//  Charity.h
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Country.h"

#import "DAO+Extensions.h"

@interface Charity : NSManagedObject

    @property (nonatomic, retain) NSString * uid;
    @property (nonatomic, retain) NSString * title;
    @property (nonatomic, retain) NSString * information;
    @property (nonatomic, retain) NSString * countrycode;
    @property (nonatomic, retain) NSString * weburl;

    @property (nonatomic, retain) NSString * problem;
    @property (nonatomic, retain) NSString * solution;

    @property (nonatomic, retain) NSDate * date_created;
    @property (nonatomic, retain) NSDate * date_updated;

    @property (nonatomic, retain) NSNumber * amount_todate;
    @property (nonatomic, retain) NSNumber * affected_total;
    @property (nonatomic, retain) NSNumber * affected_ratio;
    @property (nonatomic, retain) NSNumber * donators;

    @property (nonatomic, retain) NSNumber * favourite;

    @property (nonatomic, readonly, getter = getCategories) NSArray *categories;
    @property (nonatomic, readonly, getter = getAmountDonated) CGFloat amountDonated;
    @property (nonatomic, readonly, getter = getCountry) Country *country;

    + (Charity *) new:(NSDictionary *)values;
    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio;
    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode;
    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode weburl:(NSString *)weburl;
    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode weburl:(NSString *)weburl problem:(NSString *)problem solution:(NSString *)solution;
    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode weburl:(NSString *)weburl problem:(NSString *)problem solution:(NSString *)solution donators:(NSInteger)donators;


    + (Charity *) withId:(NSString*)uid;

    + (CGFloat) totalDonated;
    + (NSInteger) totalDonators;

    + (NSArray *) all;
    + (NSArray *) allWithTitle:(NSString*)title;
    + (NSArray *) allInCountry:(NSString*)countrycode;

@end
