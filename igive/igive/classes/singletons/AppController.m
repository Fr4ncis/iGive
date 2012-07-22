//
//  appController.m
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright 2011 Im-At-Home BV. All rights reserved.
//

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import "AppController.h"

@implementation AppController

	static AppController *_sharedSingleton = nil;
    
	@synthesize appsettings=_appsettings;
	@synthesize usersettings=_usersettings;
	@synthesize setupComplete=_setupComplete;
	@synthesize notifications=_notifications;

	@synthesize myId=_myId;
    @synthesize userid=_userid;
    @synthesize version=_version;
    @synthesize countryCode=_countryCode;

	// This is to deal with apples desire to shutdown the deviceId object !

	- (NSString *) getMyId { return _myId; }

	- (void) setMyId:(NSString *)myId
	{
        
		if ((myId == _myId) || [myId isEqualToString:@""]) return;
		
        _myId = myId;
        
        [_defaults setObject:_myId forKey:@"myid"];
		[_defaults synchronize];
        
	}

    - (void) setUserId:(NSString *)userid
    {
		if ((userid == _userid) || [userid isEqualToString:@""]) return;
        _userid = userid;
		[_usersettings setValue:_userid forKey:@"userid"];
        [self commitUserSettings];
    }

    - (void) setVersion:(NSString *)version
    {
        if ([version isEqualToString:_version]) return;
        _version = version;
        [_usersettings setValue:_version forKey:@"version"];
        [self commitUserSettings];
    }

	#pragma mark - Event Management

	- (void) eventLogoutOccurred:(NSNotification*)notification
	{
							
	}

	- (void) eventLoginSuccess:(NSNotification*)notification
	{
	
		
	}


	#pragma mark - Singleton stuff... Don't mess with this other than proxyInit!

	- (void) proxyInit
	{

        CTTelephonyNetworkInfo *_networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *_carrierInfo = [_networkInfo subscriberCellularProvider];
        
        _defaults = [NSUserDefaults standardUserDefaults];		

        if (_carrierInfo) {
            _carrier = _carrierInfo.carrierName;
        } else {
            _carrier = @"";
        }

        _myId = @"";
        _userid = @"";
        _serverAddress = @"";
		_setupComplete = NO;
        _version = @"";
        _countryCode = 0;
		
        self.myId = @"1234567890";
        
		NSURL *userSettingsPath = [[NSObject applicationDocumentsDirectory] URLByAppendingPathComponent:@"appsettings.plist"];
				
		NSDictionary *_tappSettings = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"appsettings" withExtension:@"plist"]];
		NSDictionary *_tuserSettings = [[NSDictionary alloc] initWithContentsOfURL:userSettingsPath];
				
		_appsettings = [[NSMutableDictionary alloc] init];
		_usersettings = [[NSMutableDictionary alloc] init];
		
		if (_tappSettings != nil) {
		
			[_appsettings addEntriesFromDictionary:_tappSettings];
			
            if ([[_appsettings allKeys] indexOfObject:@"server"] != NSNotFound) {
                _serverAddress = [_appsettings valueForKey:@"server"];
            }
            
		}
		
		if (_tuserSettings != nil) {
			
			[_usersettings addEntriesFromDictionary:_tuserSettings];			

            if ([[_usersettings allKeys] indexOfObject:@"version"] != NSNotFound) {
				_version = [_usersettings valueForKey:@"version"];
			}

            if ([_defaults objectForKey:@"myid"]) {
                self.myId = [_defaults objectForKey:@"myid"];
            }
            
            if ([[_usersettings allKeys] indexOfObject:@"userid"] != NSNotFound) {
				_userid = [_usersettings valueForKey:@"userid"];
			}

            if ([[_usersettings allKeys] indexOfObject:@"countrycode"] != NSNotFound) {
				_countryCode = [[_usersettings valueForKey:@"countrycode"] intValue];
			}

			_setupComplete = YES;
			
		} else {
						
		}

        NSString *_actualVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];

        if (![_version isEqualToString:_actualVersion]) {
                        
            self.version = _actualVersion;
            
        }
				
	}

	- (void) commitUserSettings
	{
		NSURL *userSettingsPath = [[NSObject applicationDocumentsDirectory] URLByAppendingPathComponent:@"appsettings.plist"];	
		[_usersettings writeToURL:userSettingsPath atomically: YES];		
	}

	- (void) setSetupComplete:(BOOL)setupComplete
	{
		if (_setupComplete == setupComplete) return;
		_setupComplete = setupComplete;
        [_usersettings setValue:[NSDate today] forKey:@"installed"];
		[self commitUserSettings];
	}

    - (void) setCountryCode:(NSInteger)countryCode
    {
        if (countryCode == _countryCode) return; // still the same...
        _countryCode = countryCode;
        [_usersettings setValue:[NSNumber numberWithInt:_countryCode] forKey:@"countrycode"];
        [self commitUserSettings];
    }

    - (NSDate *) getInstallationDate
    {
        if ([[_usersettings allKeys] indexOfObject:@"installed"] != NSNotFound) {
            return (NSDate *) [_usersettings valueForKey:@"installed"];
        }
        return [NSDate today];
    }

    - (NSString *) getCarrier
    {
        return _carrier;
    }
    
	- (NSString *) getServerAddress
	{
        return _serverAddress;		
	}

	- (id) init
	{
		Class myClass = [self class];
		@synchronized(myClass) {
			if (_sharedSingleton == nil) {
				if (self = [super init]) {
					_sharedSingleton = self;
					[self proxyInit];
				}
			}
		}
		return _sharedSingleton;
	}

	+ (AppController *) sharedInstance
	{
		@synchronized(self) {
			if (_sharedSingleton == nil) {
				_sharedSingleton = [[self alloc] init];
			}
		}
		return _sharedSingleton;        
	}

	+ (id) allocWithZone:(NSZone *)zone
	{		
		@synchronized(self) {
			if (_sharedSingleton == nil) {
				return [super allocWithZone:zone];
			}
		}
		return _sharedSingleton;
	}

	+ (id) copyWithZone:(NSZone *)zone
	{
		return self;
	}

@end
