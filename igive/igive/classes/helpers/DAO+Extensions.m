//
//  DAO+Extensions.m
//  gocial
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import "DAO+Extensions.h"
#import "DataController.h"

@implementation NSManagedObject (Extensions)

	- (NSArray *) getKeys
	{
		return nil;
	}

	- (BOOL) getSync
	{
		return NO;
	}

	- (NSString*) getEntityName
	{
		return @"";
	}

	- (id) commit
	{
		return [self commitWithCheckPoint:NO];
	}

	- (id) commitWithCheckPoint:(BOOL)checkpoint
	{
		
		if (self.sync) {

			NSMutableDictionary *_changedValues = [[NSMutableDictionary alloc] initWithDictionary:[self changedValues]];
					
			if (self.keys != nil) {
				for (NSString *_key in self.keys) {
					if ([[_changedValues allKeys] indexOfObject:_key] == NSNotFound) {
						[_changedValues setObject:[self valueForKey:_key] forKey:_key];
					} else {
						// A key is being updated - This is really WRONG but this could be an insert...
					}
				}
			}
			
			if (_changedValues != nil) {
				[[DataController sharedInstance] syncDataObject:self.entity.name properties:_changedValues];
			}
		
            _changedValues = nil;
            
		}
		
		if (checkpoint) {		
            [[DataController sharedInstance] checkpoint];
		}
			
        return self;
        
	}

@end
