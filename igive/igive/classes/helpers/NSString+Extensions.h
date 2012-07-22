//
//  NSString+Extensions.h
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Extensions)

	- (NSString *) MD5;

    + (NSString *) urlEncode:(NSString *)stringIn;
	+ (NSString *) createUUID;

@end
