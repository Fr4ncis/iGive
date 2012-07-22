//
//  NSObject+Extensions.h
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import <sys/utsname.h>

#import <Foundation/Foundation.h>

#import "NSString+Extensions.h"
#import "NSDate+Extensions.h"

// Global override to help out throughout the applicaton space...

typedef enum {
    MODEL_UNKNOWN=0,/**< unknown model */
    MODEL_IPHONE_SIMULATOR,/**< iphone simulator */
    MODEL_IPAD_SIMULATOR,/**< ipad simulator */
    MODEL_IPOD_TOUCH_GEN1,/**< ipod touch 1st Gen */
    MODEL_IPOD_TOUCH_GEN2,/**< ipod touch 2nd Gen */
    MODEL_IPOD_TOUCH_GEN3,/**< ipod touch 3th Gen */
    MODEL_IPOD_TOUCH_GEN4,/**< ipod touch 3th Gen */    
    MODEL_IPHONE,/**< iphone  */
    MODEL_IPHONE_3G,/**< iphone 3G */
    MODEL_IPHONE_3GS,/**< iphone 3GS */
    MODEL_IPHONE_4,	/**< iphone 4 */
	MODEL_IPHONE_4S,
	MODEL_IPAD, /** ipad */
	MODEL_IPAD2, /** ipad 2 */
    MODEL_IPAD3 /** ipad 3 */
} kDeviceType;

@interface NSObject (Extensions)

    #define OneTimeCall(x) \
    { static BOOL UniqueTokenMacro = NO; \
    if (!UniqueTokenMacro) {x; UniqueTokenMacro = YES; }}


	+ (NSString *) documentsDirectory;

	+ (NSString *) apnsId:(NSData *) deviceToken;

    - (NSString *) localize:(NSString *) localize;

	+ (kDeviceType) deviceType;

	+ (NSURL *) applicationDocumentsDirectory;
	+ (NSString *) append:(id) first, ...;

	+ (NSString *) uniqueMD5:(NSString *) prefix;

	+ (dispatch_source_t) createDispatchTimer:(uint64_t)interval leeway:(uint64_t)leeway queue:(dispatch_queue_t) queue block:(dispatch_block_t)block;

    + (BOOL) getFileFromUrl:(NSString*)url filename:(NSString*)filename;


@end
