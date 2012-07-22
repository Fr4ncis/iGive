//
//  dataController.h
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright 2011 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "AppController.h"

#import "NSObject+Extensions.h"

#import "SBJson.h"

@interface DataController : NSObject <NSFetchedResultsControllerDelegate> {
		    
	SBJsonWriter		*_sbWriter;
	NSArray				*_syncdEntities;
	
@private
	BOOL				_upgradeModel;
	AppController		*_appController;
	
}

	@property (nonatomic, retain, readonly, getter = getManagedObjectContext) NSManagedObjectContext *managedObjectContext;
	@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
	@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

	@property (nonatomic, assign, setter = setModelMajor:, getter = getModelMajor) NSUInteger modelMajor;
	@property (nonatomic, assign, setter = setModelMinor:, getter = getModelMinor) NSUInteger modelMinor;

	@property (nonatomic, readonly, getter = getUpgradeModelRequired) BOOL upgradeModelRequired;

	@property (nonatomic, retain) NSMutableDictionary *allProfileOptions;
	
	+ (DataController *) sharedInstance;

	- (void) checkpoint;
	
	- (NSFetchedResultsController *) fetchedResultsController:(NSString *) entityName :(NSString *) sortOn :(BOOL) ascending;
	- (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *) entityName :(NSPredicate *) filter :(NSString *) sortOn:(BOOL) ascending;
    - (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *)entityName :(NSPredicate *) filter :(NSString *) sortOn:(BOOL) ascending quantity:(NSInteger)quantity;
    - (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *) entityName :(NSPredicate *) filter :(NSString *) sortOn:(BOOL) ascending prefetchRelationships:(NSArray*)prefetch;
    - (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *) entityName :(NSPredicate *) filter:(NSString *) sortOn:(BOOL)ascending prefetchRelationships:(NSArray*)prefetch quantity:(NSInteger)quantity;

	- (BOOL) syncDataObject:(NSString *)entityName properties:(NSDictionary*)values;

@end
