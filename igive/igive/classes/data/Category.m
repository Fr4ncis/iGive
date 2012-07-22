//
//  Category.m
//  igive
//
//  Created by Samuel Colak on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "Category.h"
#import "CharityCategory.h"

#import "DAO+Extensions.h"

@implementation Category

    @dynamic uid;
    @dynamic title;
    @dynamic color;

    + (Category *) new:(NSDictionary *)values
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:context];
        Category *newEntry = [[Category alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        [newEntry setValuesForKeysWithDictionary:values];
        [newEntry commitWithCheckPoint:YES];
        
        return newEntry;
    }

    + (Category *) new:(NSString *)uid title:(NSString *)title
    {
        return [self new:uid title:title color:@""];
    }

    + (Category *) new:(NSString *)uid title:(NSString *)title color:(NSString *)color
    {
        Category *_existing = [self withId:uid];
        if (_existing) {
            _existing.color = color;
            _existing.title = title;
            return _existing;
        }
        return [self new:[[NSDictionary alloc] initWithObjectsAndKeys:uid, @"uid", title, @"title", color, @"color", nil]];
    }


    + (Category *) withId:(NSString*)uid
    {
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"uid == %@", uid];
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Category":filter :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        if ([sectionInfo numberOfObjects] == 1) {
            NSArray *objects = [sectionInfo objects];
            return (Category *) [objects objectAtIndex:0];
        }
        return nil;
    }

    - (NSArray *) getCharities
    {
        return [CharityCategory allForCategory:self.uid];
    }

    + (NSArray *) all
    {
        NSManagedObjectContext *context = [DataController sharedInstance].managedObjectContext;
        if (context == nil) return nil;
        NSFetchedResultsController *find = [[DataController sharedInstance] fetchedResultsControllerWithPredicate:@"Category":nil :@"uid" :FALSE];
        NSError *error;
        [find performFetch:&error];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[find sections] objectAtIndex:0];
        NSArray *objects = [sectionInfo objects];
        return objects;
    }

@end
