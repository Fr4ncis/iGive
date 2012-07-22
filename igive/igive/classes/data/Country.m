//
//  Country.m
//  igive
//
//  Created by Samuel Colak on 7/22/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "Country.h"
#import "DataController.h"
#import "Charity.h"

@implementation Country

    @dynamic uid;
    @dynamic title;
    @dynamic smscode;


    + (Country *) new:(NSDictionary *)values
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:context];
        Country *newEntry = [[Country alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        [newEntry setValuesForKeysWithDictionary:values];
        [newEntry commitWithCheckPoint:YES];
        
        return newEntry;
    }

    + (Country *) new:(NSString *)uid title:(NSString *)title smscode:(NSString *)smscode
    {
        Country *_existing = [self withId:uid];
        if (_existing) {
            _existing.title = title;
            _existing.smscode = smscode;
            return [_existing commitWithCheckPoint:YES];
        }
        return [self new:[[NSDictionary alloc] initWithObjectsAndKeys:uid, @"uid", title, @"title", smscode, @"smscode", nil]];
    }

    - (NSArray *) getCharities
    {
        return [Charity allInCountry:self.uid];
    }

    + (Country *) withId:(NSString*)uid
    {
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid == %@", uid];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Country":filter :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        if ([sectionInfo numberOfObjects] == 1) {
            NSArray *objects = [sectionInfo objects];
            return (Country *) [objects objectAtIndex:0];
        }
        return nil;
    }

    + (NSArray *) all
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Country":nil :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        return objects;
    }

@end
