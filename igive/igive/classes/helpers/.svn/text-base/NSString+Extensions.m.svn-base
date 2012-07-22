//
//  NSString+Extensions.m
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

	- (NSString*) MD5
	{
		
		// Create pointer to the string as UTF8
		const char *ptr = [self UTF8String];
		
		// Create byte array of unsigned chars
		unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
		
		// Create 16 bytes MD5 hash value, store in buffer
		CC_MD5(ptr, strlen(ptr), md5Buffer);
		
		// Convert unsigned char buffer to NSString of hex values
		NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
		
		for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) 
			[output appendFormat:@"%02x",md5Buffer[i]];
		
		return output;
		
	}

    + (NSString *) urlEncode:(NSString *)stringIn;
    {
        return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes( NULL,
                            (__bridge CFStringRef) stringIn, NULL,
                            (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
    }

	+ (NSString *) createUUID
	{
		// Create universally unique identifier (object)
		CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
		
		// Get the string representation of CFUUID object.
		NSString *uuidStr = (__bridge NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);        
        NSString *cleanedupVersion = [[uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
                
		return cleanedupVersion;
	}

@end
