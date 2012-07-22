//
//  CharityCategory.m
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "CharityCategory.h"
#import "Charity.h"
#import "Category.h"

#import "DataController.h"

@implementation CharityCategory

    @dynamic uid;
    @dynamic uid_charity;
    @dynamic uid_category;
    @dynamic date_created;
    @dynamic primary;


    + (CharityCategory *) new:(NSDictionary *)values
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CharityCategory" inManagedObjectContext:context];
        CharityCategory *newEntry = [[CharityCategory alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        [newEntry setValuesForKeysWithDictionary:values];
        [newEntry commitWithCheckPoint:YES];
        
        return newEntry;
    }

    + (uint64_t) nextId
    {
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsController:@"CharityCategory" :@"uid" :NO];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        if ([sectionInfo numberOfObjects] > 0) {
            NSArray *objects = [sectionInfo objects];
            return [((CharityCategory *) [objects objectAtIndex:0]).uid unsignedLongLongValue] + 1;
        }
        return 1;
    }

    + (CharityCategory *) new:(NSString*)uid_charity uid_category:(NSString*)uid_category is_primary:(BOOL)is_primary
    {
        CharityCategory *_existing = [self withCharity:uid_charity uid_category:uid_category];
        if (_existing) {
            _existing.primary = [NSNumber numberWithBool:is_primary];
            return [_existing commitWithCheckPoint:YES];
        }
        
        NSMutableDictionary *_values = [[NSMutableDictionary alloc] init];
        
        [_values setValue:[NSNumber numberWithUnsignedLongLong:[self nextId]] forKey:@"uid"];
        [_values setValue:uid_category forKey:@"uid_category"];
        [_values setValue:uid_charity forKey:@"uid_charity"];
        [_values setValue:[NSDate today] forKey:@"date_created"];
        [_values setValue:[NSNumber numberWithBool:is_primary] forKey:@"primary"];
        
        return [self new:_values];
    }

    + (CharityCategory *) withCharity:(NSString*)uid_charity uid_category:(NSString*)uid_category
    {
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid_charity == %@ AND uid_category == %@", uid_charity, uid_category];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"CharityCategory":filter :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        if ([sectionInfo numberOfObjects] == 1) {
            NSArray *objects = [sectionInfo objects];
            return (CharityCategory *) [objects objectAtIndex:0];
        }
        return nil;        
    }

    + (CharityCategory *) withId:(uint64_t)uid
    {
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid == %llu", uid];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"CharityCategory":filter :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        if ([sectionInfo numberOfObjects] == 1) {
            NSArray *objects = [sectionInfo objects];
            return (CharityCategory *) [objects objectAtIndex:0];
        }
        return nil;
    }

    + (NSArray *) all
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"CharityCategory":nil :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        return objects;
    }

    + (NSArray *) allForCharity:(NSString *)uid_charity
    {
        
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid_charity == %@", uid_charity];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"CharityCategory":filter :@"uid" :FALSE];
        
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];

        if (objects.count > 0) {

            NSMutableArray *_indexes = [[NSMutableArray alloc] init];
            
            for (CharityCategory *_item in objects) {
                [_indexes addObject:_item.uid_category];
            }
            
            filter = [NSPredicate predicateWithFormat:@"uid IN %@", _indexes];
            find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Category":filter :@"title" :FALSE];
            [find performFetch:&error];

            sectionInfo = [[find sections] objectAtIndex:0];
            objects = [sectionInfo objects];
            
        }
        
        return objects;
    }

    + (NSArray *) allForCategory:(NSString *)uid_category
    {
        
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid_category == %@", uid_category];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"CharityCategory":filter :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        
        if (objects.count > 0) {
            
            NSMutableArray *_indexes = [[NSMutableArray alloc] init];
            
            for (CharityCategory *_item in objects) {
                [_indexes addObject:_item.uid_charity];
            }
            
            filter = [NSPredicate predicateWithFormat:@"uid IN %@", _indexes];
            find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Charity":filter :@"title" :FALSE];
            [find performFetch:&error];
            
            sectionInfo = [[find sections] objectAtIndex:0];
            objects = [sectionInfo objects];
            
        }
        
        return objects;
    }

@end
