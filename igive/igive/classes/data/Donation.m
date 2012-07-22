//
//  Donation.m
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "Donation.h"

#import "DataController.h"

@implementation Donation

    @dynamic uid;
    @dynamic date_created;
    @dynamic uid_charity;
    @dynamic amount;
    @dynamic reference;
    @dynamic affected_count;

    + (Donation *) new:(NSDictionary *)values
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Donation" inManagedObjectContext:context];
        Donation *newEntry = [[Donation alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        [newEntry setValuesForKeysWithDictionary:values];
        [newEntry commitWithCheckPoint:YES];
        
        return newEntry;
    }

    - (Charity *) getCharity
    {
        return [Charity withId:self.uid_charity];
    }

    + (Donation *) new:(NSString *)uid uid_charity:(NSString *)uid_charity amount:(CGFloat)amount reference:(NSString *)reference affected:(CGFloat)affected
    {
        Donation *_existing = [self withId:uid];
        if (_existing) {
            return _existing;
        }
        
        NSMutableDictionary *_values = [[NSMutableDictionary alloc] init];
        
        [_values setValue:uid forKey:@"uid"];
        [_values setValue:[NSDate today] forKey:@"date_created"];
        [_values setValue:[NSNumber numberWithFloat:amount] forKey:@"amount"];
        [_values setValue:[NSNumber numberWithFloat:affected] forKey:@"affected_count"];
        [_values setValue:uid_charity forKey:@"uid_charity"];
        [_values setValue:reference forKey:@"reference"];
        
        return [self new:_values];
    }

    + (Donation *) withId:(NSString*)uid
    {
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid == %@", uid];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Donation":filter :@"date_created" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        if ([sectionInfo numberOfObjects] == 1) {
            NSArray *objects = [sectionInfo objects];
            return (Donation *) [objects objectAtIndex:0];
        }
        return nil;
    }

    + (NSArray *) all
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Donation":nil :@"date_created" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        return objects;
    }

    + (CGFloat) totalDonation
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return 0.0f;
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Donation":nil :@"date_created" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        CGFloat _total = 0.0f;
        for (Donation *_donation in objects) {
            _total += _donation.amount.floatValue;
        }
        return _total;
    }

    + (CGFloat) totalDonationForCharity:(NSString *)uid_charity
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return 0.0f;
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid_charity == %@", uid_charity];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Donation":filter :@"date_created" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        CGFloat _total = 0.0f;
        for (Donation *_donation in objects) {
            _total += _donation.amount.floatValue;
        }
        return _total;
    }

@end
