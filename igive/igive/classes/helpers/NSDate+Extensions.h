//
//  NSDate+Extensions.h
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	kMonthJanuary = 1, kMonthFebruary = 2, kMonthMarch = 3, kMonthApril = 4, kMonthMay = 5, kMonthJune = 6, kMonthJuly = 7, kMonthAugust = 8, kMonthSeptember = 9,
	kMonthOctober = 10, kMonthNovember = 11, kMonthDecember = 12	
} kMonths;

typedef enum {
	kDaysOfTheWeekMonday = 1, kDaysOfTheWeekTuesday = 2, kDaysOfTheWeekWednesday = 3, kDaysOfTheWeekThursday = 4, kDaysOfTheWeekFriday = 5, kDaysOfTheWeekSaturday = 6, kDaysOfTheWeekSunday = 7
} kDaysOfTheWeek;

@interface NSDate (Extensions)

    + (NSDate *) today;

	- (NSInteger) numberOfMonthsUntil:(NSDate *) date;
	- (NSInteger) numberOfDaysUntil:(NSDate *) date;
	- (NSInteger) numberOfHoursUntil:(NSDate *) date;
	- (NSInteger) numberOfMinutesUntil:(NSDate *) date;
    - (NSInteger) numberOfSecondsUntil:(NSDate *) date;

    + (NSDate *) dateFromParts:(NSUInteger)year month:(kMonths)month day:(NSUInteger)day;
    + (NSDateComponents *) dateComponents:(NSDate *)sourceDate;

    + (NSDate *) toLocalTime:(NSDate *) sourceDate;

    + (NSString *) getMonthNameShort:(kMonths)month;
    + (NSString *) getMonthNameLong:(kMonths)month;

    + (NSString *) getDayOfWeek:(NSDate *)dayOfMonth;
    + (NSString *) getDayOfWeek:(NSUInteger)year :(kMonths)month :(NSUInteger)day;

    + (NSString *) dateToSqlString:(NSDate *) datein;
    + (NSDate *) sqlStringToDate:(NSString *) datein;

    + (BOOL) isLeapYear:(NSInteger)year;
    + (NSInteger) getDaysInMonth:(NSInteger)year :(kMonths)month;

@end
