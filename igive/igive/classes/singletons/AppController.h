//
//  AppController.h
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Extensions.h"

static NSString * MSG_CHANGE_PAGE = @"MSG_CHANGE_PAGE";

@interface AppController : NSObject {
	
    NSString *_serverAddress;
    NSString *_carrier;
    NSUserDefaults *_defaults;
    
}

	@property (nonatomic, retain, getter = getMyId, setter = setMyId:) NSString *myId;

	@property (nonatomic, retain) NSMutableDictionary *appsettings;
	@property (nonatomic, retain) NSMutableDictionary *usersettings;

    @property (nonatomic, assign, setter = setCountryCode:) NSInteger countryCode;

	@property (nonatomic, assign) BOOL notifications;

	@property (nonatomic, assign, setter = setSetupComplete:) BOOL setupComplete;    

    @property (nonatomic, readonly, getter = getInstallationDate) NSDate *installationDate;
    @property (nonatomic, readonly, getter = getCarrier) NSString *carrier;
	@property (nonatomic, readonly, getter = getServerAddress) NSString *serverAddress;

    @property (nonatomic, retain, setter = setUserId:) NSString *userid;
    @property (nonatomic, retain, setter = setVersion:) NSString *version;

	+ (AppController *) sharedInstance;

	- (void) commitUserSettings;


@end
