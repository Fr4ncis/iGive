//
//  NSDate+Extensions.m
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import "NSDate+Extensions.h"

static const NSString* monthNames[12] = { @"january", @"february", @"march", @"april", @"may", @"june", @"july", @"august", @"september", @"october", @"november", @"december" };
static const NSString* monthShortNames[12] = { @"jan", @"feb", @"mar", @"apr", @"may", @"jun", @"jul", @"aug", @"sep", @"oct", @"nov", @"dec" };

static const NSString* dayNames[7] = { @"mon", @"tue", @"wed", @"thu", @"fri", @"sat", @"sun" };

static const uint daysPerMonth[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

@implementation NSDate (Extensions)


	- (NSInteger) numberOfDaysUntil:(NSDate *) date 
	{		
		NSAssert( date != nil, @"date should be set");		
		NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];		
		NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:date options:0];				
		return [components day];
	}

	- (NSInteger) numberOfMonthsUntil:(NSDate *) date 
	{
		NSAssert( date != nil, @"date should be set");		
		NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];		
		NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit+NSMonthCalendarUnit fromDate:self toDate:date options:0];				
		return [components month];
	}

	- (NSInteger) numberOfHoursUntil:(NSDate *) date 
	{
		NSAssert( date != nil, @"date should be set");		
		NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];		
		NSDateComponents *components = [gregorianCalendar components:NSHourCalendarUnit fromDate:self toDate:date options:0];				
		return [components hour];
	}

	- (NSInteger) numberOfMinutesUntil:(NSDate *) date 
	{
		NSAssert( date != nil, @"date should be set");		
		NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];		
		NSDateComponents *components = [gregorianCalendar components:NSMinuteCalendarUnit fromDate:self toDate:date options:0];				
		return [components minute];
	}

    - (NSInteger) numberOfSecondsUntil:(NSDate *) date 
    {
        NSAssert( date != nil, @"date should be set");		
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];		
        NSDateComponents *components = [gregorianCalendar components:NSSecondCalendarUnit fromDate:self toDate:date options:0];				
        return [components second];
    }

    + (NSDate *) dateFromParts:(NSUInteger)year month:(kMonths)month day:(NSUInteger)day
    {
        NSDateComponents* comp = [[NSDateComponents alloc] init];		
        
        [comp setDay: day];
        [comp setMonth: month];
        [comp setYear: year];
        
        NSDate * sourceDate = [[NSCalendar currentCalendar] dateFromComponents:comp];
        
        NSTimeZone* sourceTimeZone = [comp timeZone]; // use the source timezone that comes from the Calendar ! 
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        return destinationDate;
    }

    + (NSDateComponents *) dateComponents:(NSDate *) sourceDate
    {
        NSAssert( sourceDate != nil, @"sourcedate must be set");
        NSDateComponents *comp = [[NSCalendar currentCalendar] 
                                  components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)
                                  fromDate:sourceDate];		
        return comp;
    }

    + (NSDate *) today
    {		
        return [NSDate date];
    }

    + (NSDate *) toLocalTime:(NSDate *) sourceDate
    {
        
        NSAssert( sourceDate != nil, @"sourcedate must be set");
        
        NSDateComponents *comp = [self dateComponents: sourceDate];	
        
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];		
        NSInteger sourceGMTOffset = [[comp timeZone] secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        return destinationDate;
    }

    + (NSString *) getMonthNameLong:(kMonths) month
    {
        return (NSString *) monthNames[month-1];
    }

    + (NSString *) getMonthNameShort:(kMonths) month
    {
        return (NSString *) monthShortNames[month-1];
    }

    + (NSInteger) getDaysInMonth:(NSInteger)year :(kMonths)month
    {
        int _daysInMonth = daysPerMonth[(int) (month)-1];
        if (month == kMonthFebruary) {
            if ([self isLeapYear:year]) _daysInMonth++;
        }
        return _daysInMonth;
    }

    + (NSString *) dateToSqlString:(NSDate *) datein
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        return [dateFormat stringFromDate:datein];
    }

    + (NSDate *) sqlStringToDate:(NSString *) datein
    {
        
        if ([datein isKindOfClass:[NSNull class]]) {
            return [self today];
        }
        
        NSString *_part1 = [datein substringToIndex:10];
        NSString *_part2 = [datein substringFromIndex:11];
        
        NSString *_actualDate = [NSString stringWithFormat:@"%@T%@", _part1, _part2];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
        
        return [dateFormat dateFromString:_actualDate];		
    }

    // if year is divisable by 4 or by 400 then is a leap year !
    + (BOOL) isLeapYear:(NSInteger)year
    {
        return (((year % 4) == 0) ||
                ((year % 400) == 0));
    }

    + (NSString *) getDayOfWeek:(NSDate *)dayOfMonth
    {		
        NSInteger _dayOfWeek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:dayOfMonth] weekday];		
        if (_dayOfWeek == 1) {
            _dayOfWeek = 6;
        } else {
            _dayOfWeek = _dayOfWeek-2;
        }
        
        return (NSString *) dayNames[_dayOfWeek];		
    }

    + (NSString *) getDayOfWeek:(NSUInteger)year :(kMonths)month :(NSUInteger)day
    {
        NSDate *_dayOfMonth = [self dateFromParts:year month:month day:day];
        return [self getDayOfWeek:_dayOfMonth];
    }

@end
