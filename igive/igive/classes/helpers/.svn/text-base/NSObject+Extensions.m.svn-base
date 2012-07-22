//
//  NSObject+Extensions.m
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import "NSObject+Extensions.h"

static inline double radians (double degrees) { return degrees * M_PI/180; }

@implementation NSObject (Extensions)


	+ (NSString *) documentsDirectory
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		return [paths objectAtIndex:0]; 
	}

	+ (NSString *) append:(id) first, ...
	{
		NSString * result = @"";
		id eachArg;
		va_list alist;
		if(first)
		{
			result = [result stringByAppendingString:first];
			va_start(alist, first);
			while ((eachArg = va_arg(alist, id))) 
				result = [result stringByAppendingString:eachArg];
			va_end(alist);
		}
		return result;
	}

    - (NSString *) localize:(NSString *)localize
    {
        return NSLocalizedString(localize, nil);
    }

	+ (NSString *) apnsId:(NSData *) deviceToken
	{
		NSMutableString *_deviceId = [NSMutableString string];
		unsigned char *ptr = (unsigned char *)[deviceToken bytes];		
		for (NSInteger i=0; i < 32; ++i) {
			[_deviceId appendString:[NSString stringWithFormat:@"%02x", ptr[i]]];
		}
		return _deviceId;
	}

	+ (kDeviceType) deviceType
    {
        
		NSString *model= [[UIDevice currentDevice] model];
		struct utsname u;
		uname(&u);
		
		if (!strcmp(u.machine, "iPhone1,1")) {
			return MODEL_IPHONE;
		} else if (!strcmp(u.machine, "iPhone1,2")){
			return MODEL_IPHONE_3G;
		} else if (!strcmp(u.machine, "iPhone2,1")){
			return MODEL_IPHONE_3GS;
		} else if (!strcmp(u.machine, "iPhone3,1")){ 
			return MODEL_IPHONE_4;
		} else if (!strcmp(u.machine, "iPhone3,2")){ // CDMA Prototype
			return MODEL_IPHONE_4;            
		} else if (!strcmp(u.machine, "iPhone3,3")){ // CDMA
			return MODEL_IPHONE_4;                        
		} else if (!strcmp(u.machine, "iPhone4,1")){
			return MODEL_IPHONE_4S;
		} else if (!strcmp(u.machine, "iPod1,1")){
			return MODEL_IPOD_TOUCH_GEN1;
		} else if (!strcmp(u.machine, "iPod2,1")){
			return MODEL_IPOD_TOUCH_GEN2;
		} else if (!strcmp(u.machine, "iPod3,1")){
			return MODEL_IPOD_TOUCH_GEN3;
		} else if (!strcmp(u.machine, "iPod4,1")){
			return MODEL_IPOD_TOUCH_GEN4;            
		} else if (!strcmp(u.machine, "iPad1,1")){
			return MODEL_IPAD;
		} else if (!strcmp(u.machine, "iPad2,1")){ // WIFI
			return MODEL_IPAD2;			
		} else if (!strcmp(u.machine, "iPad2,2")){ // WIFI+3G
			return MODEL_IPAD2;			
		} else if (!strcmp(u.machine, "iPad2,3")){ // WIFI+CDMA
			return MODEL_IPAD2;			
		} else if (!strcmp(u.machine, "iPad3,1")){ // WIFI 
			return MODEL_IPAD3;			            
		} else if (!strcmp(u.machine, "iPad3,2")){ // WIFI + GSM
			return MODEL_IPAD3;			            
		} else if (!strcmp(u.machine, "iPad3,3")){ // WIFI + CDMA
			return MODEL_IPAD3;			                        
		} else if (!strcmp(u.machine, "i386")){
			//NSString *iPhoneSimulator = @"iPhone Simulator";
			NSString *iPadSimulator = @"iPad Simulator";
			if([model compare:iPadSimulator] == NSOrderedSame)
				return MODEL_IPAD_SIMULATOR;
			else
				return MODEL_IPHONE_SIMULATOR;
		}
        return MODEL_UNKNOWN;
	}

	+ (NSURL *) applicationDocumentsDirectory
	{
		return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	}

	+ (NSString *) uniqueMD5:(NSString *) prefix
	{
		NSString *randomCode = [NSString createUUID];
		NSString *md5Name =[[NSString stringWithFormat:@"%@%@%@", prefix, [NSDate dateToSqlString:[NSDate today]], randomCode] MD5];
		return md5Name;
	}	

	+ (dispatch_source_t) createDispatchTimer:(uint64_t)interval leeway:(uint64_t)leeway queue:(dispatch_queue_t) queue block:(dispatch_block_t)block;
	{
		dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
		if (timer)
		{
			dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
			dispatch_source_set_event_handler(timer, block);
			dispatch_resume(timer);
		}
		return timer;
	}

	#pragma mark - Date stuff

    + (BOOL) getFileFromUrl:(NSString*)url filename:(NSString*)filename
    {
        NSURL  *urlToFile = [NSURL URLWithString:url];
        NSData *urlData = [NSData dataWithContentsOfURL:urlToFile];
        if (urlData)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];              
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"filename.png"];
            [urlData writeToFile:filePath atomically:YES];            
            return YES;
        }        
        return NO;
    }

@end
