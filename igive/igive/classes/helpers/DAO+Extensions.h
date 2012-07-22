//
//  DAO+Extensions.h
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NSString uid;

typedef enum {
	kSyncdObjectPersonStat = 0	
} kSyncdObjects;

@interface NSManagedObject (Extensions)

	@property (nonatomic, readonly, getter = getKeys) NSArray* keys;
	@property (nonatomic, readonly, getter = getSync) BOOL sync;
	@property (nonatomic, readonly, getter = getEntityName) NSString* entityName;

	- (id) commit;
	- (id) commitWithCheckPoint:(BOOL)checkpoint;

@end
