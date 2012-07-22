//
//  Charity.m
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "Charity.h"
#import "CharityCategory.h"
#import "Donation.h"
#import "DataController.h"

@implementation Charity

    @dynamic uid;
    @dynamic title;
    @dynamic information;
    @dynamic date_created;
    @dynamic date_updated;
    @dynamic amount_todate;
    @dynamic affected_total;
    @dynamic affected_ratio;
    @dynamic favourite;
    @dynamic weburl;
    @dynamic countrycode;

    + (Charity *) new:(NSDictionary *)values
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Charity" inManagedObjectContext:context];
        Charity *newEntry = [[Charity alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        [newEntry setValuesForKeysWithDictionary:values];
        [newEntry commitWithCheckPoint:YES];
        
        return newEntry;
    }

    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio
    {
        return [self new:uid title:title information:information amount_todate:amount_todate affected_total:affected_total affected_ratio:affected_ratio countrycode:@"WW" weburl:@"" problem:@"" solution:@""];
    }

    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode
    {
        return [self new:uid title:title information:information amount_todate:amount_todate affected_total:affected_total affected_ratio:affected_ratio countrycode:countrycode weburl:@"" problem:@"" solution:@""];
    }

    + (Charity *) new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode weburl:(NSString *)weburl
    {
        return [self new:uid title:title information:information amount_todate:amount_todate affected_total:affected_total affected_ratio:affected_ratio countrycode:countrycode weburl:weburl problem:@"" solution:@""];
    }

    + (Charity *)new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode weburl:(NSString *)weburl problem:(NSString *)problem solution:(NSString *)solution
    {
        return [self new:uid title:title information:information amount_todate:amount_todate affected_total:affected_total affected_ratio:affected_ratio countrycode:countrycode weburl:weburl problem:problem solution:solution donators:0];
    }

    + (Charity *)new:(NSString *)uid title:(NSString *)title information:(NSString *)information amount_todate:(CGFloat)amount_todate affected_total:(CGFloat)affected_total affected_ratio:(CGFloat)affected_ratio countrycode:(NSString *)countrycode weburl:(NSString *)weburl problem:(NSString *)problem solution:(NSString *)solution donators:(NSInteger)donators
    {
        Charity *_existing = [self withId:uid];

        if (_existing) {
            _existing.title = title;
            _existing.information = information;
            _existing.amount_todate = [NSNumber numberWithFloat:amount_todate];
            _existing.affected_ratio = [NSNumber numberWithFloat:affected_ratio];
            _existing.affected_total = [NSNumber numberWithFloat:affected_total];
            _existing.date_updated = [NSDate today];
            _existing.countrycode = countrycode;
            _existing.problem = problem;
            _existing.solution = solution;
            _existing.weburl = weburl;
            _existing.donators = [NSNumber numberWithInt:donators];
            return [_existing commitWithCheckPoint:YES];
        }
        
        NSMutableDictionary *_values = [[NSMutableDictionary alloc] init];
        
        [_values setValue:uid forKey:@"uid"];
        [_values setValue:title forKey:@"title"];
        [_values setValue:information forKey:@"information"];
        [_values setValue:[NSNumber numberWithFloat:amount_todate] forKey:@"amount_todate"];
        [_values setValue:[NSNumber numberWithFloat:affected_total] forKey:@"affected_total"];
        [_values setValue:[NSNumber numberWithFloat:affected_ratio] forKey:@"affected_ratio"];
        [_values setValue:[NSDate today] forKey:@"date_created"];
        [_values setValue:[NSDate today] forKey:@"date_updated"];
        [_values setValue:countrycode forKey:@"countrycode"];
        [_values setValue:weburl forKey:@"weburl"];
        [_values setValue:solution forKey:@"solution"];
        [_values setValue:weburl forKey:@"weburl"];
        [_values setValue:[NSNumber numberWithInt:donators] forKey:@"donators"];
        [_values setValue:[NSNumber numberWithBool:NO] forKey:@"favourite"];

        return [self new:_values];
    }
    
    + (Charity *) withId:(NSString*)uid
    {
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid == %@", uid];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Charity":filter :@"date_created" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        if ([sectionInfo numberOfObjects] == 1) {
            NSArray *objects = [sectionInfo objects];
            return (Charity *) [objects objectAtIndex:0];
        }
        return nil;
    }

    - (Country *) getCountry
    {
        return [Country withId:self.countrycode];
    }

    - (NSArray *) getCategories
    {
        return [CharityCategory allForCharity:self.uid];
    }

    - (CGFloat) getAmountDonated
    {
        return [Donation totalDonationForCharity:self.uid];
    }

    + (CGFloat) totalDonated
    {
        NSArray *_charities = [self all];
        CGFloat _total = 0.0f;
        if (_charities > 0) {
            for (Charity *_charity in _charities) {
                _total += _charity.amount_todate.floatValue;
            }
        }
        return _total;
    }

    + (NSInteger) totalDonators
    {
        NSArray *_charities = [self all];
        int _total = 0;
        if (_charities > 0) {
            for (Charity *_charity in _charities) {
                _total += _charity.donators.intValue;
            }
        }
        return _total;
    }

    + (NSArray *) all
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Charity":nil :@"title" :YES];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        return objects;
    }

    + (NSArray *) allWithTitle:(NSString*)title
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", title];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Charity":filter :@"title" :YES];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        return objects;
    }

    + (NSArray *)allInCountry:(NSString *)countrycode
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"countrycode == %@", countrycode];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Charity":filter :@"title" :YES];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        return objects;        
    }

@end
