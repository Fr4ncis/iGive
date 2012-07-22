//
//  dataController.m
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright 2011 Im-At-Home BV. All rights reserved.
//

#import "DataController.h"
#import "NSObject+Extensions.h"

#import "Category.h"
#import "Donation.h"
#import "Charity.h"
#import "CharityCategory.h"
#import "Country.h"

static const NSUInteger _currentMajor = 1;
static const NSUInteger _currentMinor = 0;

@implementation DataController

	static DataController *_sharedSingleton = nil;
    
	@synthesize allProfileOptions=_allProfileOptions;
	@synthesize managedObjectContext=_managedObjectContext;
	@synthesize managedObjectModel=_managedObjectModel;	
	@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;
	
	#pragma mark - Data communication layer for document information 

	- (NSFetchedResultsController *) fetchedResultsController:(NSString *) entityName:(NSString *) sortOn :(BOOL) ascending
	{
		return [self fetchedResultsControllerWithPredicate:entityName :nil :sortOn :ascending prefetchRelationships:nil];
	}    

	- (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *)entityName :(NSPredicate *) filter :(NSString *) sortOn:(BOOL) ascending
	{
		return [self fetchedResultsControllerWithPredicate:entityName :filter :sortOn :ascending prefetchRelationships:nil quantity:-1];
	}

    - (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *)entityName :(NSPredicate *) filter :(NSString *) sortOn:(BOOL) ascending quantity:(NSInteger)quantity
    {
        return [self fetchedResultsControllerWithPredicate:entityName :filter :sortOn :ascending prefetchRelationships:nil quantity:quantity];        
    }

    - (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *) entityName :(NSPredicate *) filter:(NSString *) sortOn:(BOOL)ascending prefetchRelationships:(NSArray*)prefetch
    {
        return [self fetchedResultsControllerWithPredicate:entityName :filter :sortOn :ascending prefetchRelationships:prefetch quantity:-1];
    }

    - (NSFetchedResultsController *) fetchedResultsControllerWithPredicate:(NSString *) entityName :(NSPredicate *) filter:(NSString *) sortOn:(BOOL)ascending prefetchRelationships:(NSArray*)prefetch quantity:(NSInteger)quantity
	{
		
		NSAssert( entityName != nil, @"Entity undefined");
		
		NSManagedObjectContext *context = self.managedObjectContext;
		
		// Edit the entity name as appropriate.
		NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
		
		// Create the fetch request for the entity.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		
		// Edit the sort key as appropriate.
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortOn ascending:ascending];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		
		[fetchRequest setSortDescriptors:sortDescriptors];

        if (filter != nil) {
			[fetchRequest setPredicate:filter];
		}

        [fetchRequest setFetchLimit:((quantity != -1) ? quantity : 0)];
        		
		if (sortOn == nil) {
			NSPropertyDescription *firstproperty = [entity.properties objectAtIndex:0];
			sortOn = firstproperty.name;
		}
		
		[fetchRequest setEntity:entity];
				
		if (prefetch != nil) {
            fetchRequest.includesSubentities = YES;                                
			[fetchRequest setRelationshipKeyPathsForPrefetching: prefetch]; //[NSArray arrayWithObject:@"department"]];
		}
				
		// Edit the section name key path and cache name if appropriate.
		// nil for section name key path means "no sections".
		NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
		
		aFetchedResultsController.delegate = self;
				
		return aFetchedResultsController;
		
	}    

	- (void) checkpoint
	{

        NSError *error;
        NSManagedObjectContext *_context = self.managedObjectContext;

        if ([[NSThread currentThread] isEqual:[NSThread mainThread]]) {            
            if (![_context save:&error]) {
#if DEBUG            
                NSLog(@"Commit failed to persistent store");
#endif                
            }
        } else {            
            // we arent on the main thread (at all!)            
            [_context performSelectorOnMainThread:@selector(save:) withObject:error waitUntilDone:YES];                        
        }
        
	}

	- (BOOL) syncDataObject:(NSString *)entityName properties:(NSDictionary *)values
	{
		
		if ([_syncdEntities indexOfObject:entityName] == NSNotFound) return NO;
		
		NSString *_dataOut = [_sbWriter stringWithObject:values];
        
#if DEBUG        
		NSLog(@"encoded data = %@", _dataOut);
#endif
						
		return YES;
	}

	#pragma mark - Datamodel creation process

	- (NSManagedObjectContext *) getManagedObjectContext
	{
		if (_managedObjectContext != nil)
		{
			return _managedObjectContext;
		}
		
		NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
		if (coordinator != nil)
		{
			_managedObjectContext = [[NSManagedObjectContext alloc] init];
			[_managedObjectContext setPersistentStoreCoordinator:coordinator];
		}
		return _managedObjectContext;
	}

	- (NSManagedObjectModel *) loadModel:(NSString *)modelname
	{
		NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelname withExtension:@"momd"];						
		return [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]; 
	}

	- (NSManagedObjectModel *) managedObjectModel
	{
		if (_managedObjectModel != nil) return _managedObjectModel;
			
		NSMutableArray *_modelsIn = [[NSMutableArray alloc] init];
		[_modelsIn addObject:[self loadModel:@"coremodel"]];
				
		_managedObjectModel = [NSManagedObjectModel modelByMergingModels:_modelsIn];
		
		return _managedObjectModel;
	}

	- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
	{
        
		if (_persistentStoreCoordinator != nil) {
			return _persistentStoreCoordinator;
		}
		
		NSURL *storeURL = [[NSObject applicationDocumentsDirectory] URLByAppendingPathComponent:@"datastore.sqlite"];
		
		NSError *error = nil;
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],
                                 NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES],
                                 NSInferMappingModelAutomaticallyOption, nil];
        
		_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
		if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
		{
#if DEBUG            
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#endif            
			abort();
		} 
				
		return _persistentStoreCoordinator;
	}


	#pragma mark - Fetched results controller delegate

	- (BOOL) getUpgradeModelRequired
	{
		return _upgradeModel;
	}

	- (NSUInteger) getModelMajor
	{
		if ([[_appController.usersettings allKeys] indexOfObject:@"dbmodelmajor"] != NSNotFound) {
			return [[_appController.usersettings valueForKey:@"dbmodelmajor"] intValue];
		}
		return _currentMajor;
	}

	- (void) setModelMajor:(NSUInteger)modelMajor
	{
		[_appController.usersettings setValue:[NSNumber numberWithInt:modelMajor] forKey:@"dbmodelmajor"];		
		[_appController commitUserSettings];
	}

	- (void) setModelMinor:(NSUInteger)modelMinor
	{
		[_appController.usersettings setValue:[NSNumber numberWithInt:modelMinor] forKey:@"dbmodelminor"];		
		[_appController commitUserSettings];
	}

	- (NSUInteger) getModelMinor
	{
		if ([[_appController.usersettings allKeys] indexOfObject:@"dbmodelminor"] != NSNotFound) {
			return [[_appController.usersettings valueForKey:@"dbmodelminor"] intValue];
		}
		return _currentMinor;
	}	

	- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller
	{
	}

	- (void) controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
				atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
	{
		switch(type) {
			case NSFetchedResultsChangeInsert:
				break;
				
			case NSFetchedResultsChangeDelete:
				break;
		}
	}

	- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
			atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
		   newIndexPath:(NSIndexPath *)newIndexPath
	{
		
		switch(type) {
				
			case NSFetchedResultsChangeInsert:
//                NSLog(@"Entry inserted");
				break;
				
			case NSFetchedResultsChangeDelete:
//                NSLog(@"Entry deleted");
				break;
				
			case NSFetchedResultsChangeUpdate: {
//                NSLog(@"Entry updated");
				break;
            }
			case NSFetchedResultsChangeMove:
//                NSLog(@"Entry moved");
				break;
		}
	}

	- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
	{
		// dont do anything here at the moment...
	}

	- (void) setupOptions
	{
		
        // setup information etc...
        
        [Category new:@"environmental" title:@"Environmental" color:@"0x6892fb"];
        [Category new:@"support" title:@"Support Groups" color:@"0xffae00"];
        [Category new:@"children" title:@"Children" color:@"0xffe052"];
        [Category new:@"health" title:@"Health" color:@"0xff6a52"];
        [Category new:@"community" title:@"Community" color:@"0x46ceb0"];
        [Category new:@"culture" title:@"Cultural" color:@"0xa668fb"];
        [Category new:@"nature" title:@"Nature" color:@"0x76ce46"];
        
        [Country new:@"UK" title:@"United Kingdom" smscode:@"+31643285922"];
        [Country new:@"WW" title:@"The World" smscode:@"+31643285922"];
        [Country new:@"NL" title:@"The Netherlands" smscode:@"+31643285922"];
        [Country new:@"AN" title:@"Dutch Antilles" smscode:@"+31643285922"];
        [Country new:@"AU" title:@"Australia" smscode:@"+31643285922"];
        [Country new:@"US" title:@"United States" smscode:@"+31643285922"];
        [Country new:@"IL" title:@"Israel" smscode:@"+31643285922"];
        
        [Charity new:@"aidsfonds" title:@"The Elton John AIDS Foundation" information:@"We help to have research to aids, and hiv, and to create a medicine for it." amount_todate:12.99f affected_total:5.0f affected_ratio:0.20f countrycode:@"UK" weburl:@"http://www.ejaf.com/" problem:@"Hiv, Aids" solution:@"Helping for research" donators:5.00f];
        [Charity new:@"dance4life" title:@"Dance 4 Life" information:@"Aids , Hiv. We INSPIRES, EDUCATE, EDUCATE and CELEBRATE" amount_todate:15.99f affected_total:60.00f affected_ratio:50.55f countrycode:@"WW" weburl:@"http://www.dance4life.nl/" problem:@"Aids, Hiv" solution:@"Inspire, educate pepole, and celebrate it" donators:5.00f];
        [Charity new:@"redcross" title:@"The Red Cross" information:@"The Red Cross is where people mobilize to help their neighbors—across the street, across the country, and across the world—in emergencies." amount_todate:90.00f affected_total:60.20f affected_ratio:45.45f countrycode:@"WW" weburl:@"http://www.redcross.org/" problem:@"Sick And Wounded Pepole" solution:@"get doctors in the country's where it's needed to give help." donators:90.00f];
        [Charity new:@"natuurmonumenten" title:@"Natuurmonumenten" information:@"Beschermd en behoud bossen en parken" amount_todate:20.00f affected_total:5.00f affected_ratio:0.50f countrycode:@"NL" weburl:@"http://www.natuurmonumenten.nl/" problem:@"parks, and forests will not be get the attention they needed" solution:@"Give forest's, and park's the attention they needed, to keep them clear, safe and good." donators:20.00f];
        [Charity new:@"wwf" title:@"World Wildlife Fund" information:@"protects and helps animals world wide." amount_todate:90.50f affected_total:45.00f affected_ratio:25.01f countrycode:@"WW" weburl:@"http://www.wwf.org/" problem:@"Animals lose there habitats" solution:@"Protect habitats, make habitats for the animals" donators:50.00f];
        [Charity new:@"naturefoundations" title:@"Nature Foundations" information:@"Nature Foundation St. Maarten is a non-governmental/non-profit organization, working to promote conservation of St. Maarten’s environment. The Foundation was established in January 1997 as an Island Government initiative and is guided by the laws of the Netherlands Antilles. Nature Foundation is fully registered on St. Maarten at the Chamber of Commerce in Philipsburg (registration number 80439)." amount_todate:120.00f affected_total:10.00f affected_ratio:0.10f countrycode:@"AN" weburl:@"http://www.naturefoundationsxm.org/" problem:@"parks, and forests will not be get the attention they needed" solution:@"Give forest's, and park's the attention they needed, to keep them clear, safe and good." donators:100.00f];
        [Charity new:@"hendrik" title:@"Hendrik Muller Fonds" information:@"community founds by Hendrik Muller." amount_todate:0.50f affected_total:0.01 affected_ratio:2.01 countrycode:@"NL" weburl:@"http://www.mullerfonds.nl/" problem:@"To few Publications" solution:@"Give impressive piblications" donators:1.00f];
        [Charity new:@"co-operative" title:@"Co-Operative" information:@"Co Operative" amount_todate:350.00f affected_total:120.00f affected_ratio:80.00f countrycode:@"UK" weburl:@"http://www.co-operative.coop/" problem:@"to much pepole are alone" solution:@"Help pepole connect each other" donators:200.00f];
        [Charity new:@"ourcommunity" title:@"OurCommunity" information:@"The Community Funding Centre provides free help sheets, services, newsletters, books and training to help community groups improve their fundraising abilities and become healthier and more viable." amount_todate:209.00f affected_total:30.03f affected_ratio:12.00f countrycode:@"AU" weburl:@"http://www.ourcommunity.com.au/funding/" problem:@"Low healthy and viable." solution:@"provides free help sheets, services, newsletters, books and training" donators:12.00f];
        [Charity new:@"appsterdam" title:@"Appsterdam" information:@"Our goal is to bring app makers together, and our mission is to support their interests worldwide. We established Amsterdam as the capital of Appsterdam - the world capital of apps - to establish a centre of gravity for our industry, to provide a place where all app makers can gather, and to create a framework for people to give back and support the community." amount_todate:960.00 affected_total:100.00f affected_ratio:90.00f countrycode:@"NL" weburl:@"http://www.appsterdam.rs/" problem:@"all the developers are on there own" solution:@"help to connect the pepole and then they can share knowledges" donators:50.00f];
        [Charity new:@"itfund" title:@"IT Fund for Kids" information:@"Improving the quality of life of children living with serious illness or disability" amount_todate:6.00f affected_total:0.90 affected_ratio:0.15f countrycode:@"AU" weburl:@"http://www.itfundforkids.org.au/" problem:@"Children's living with illnes or disability" solution:@"Improving the quality of life of children living with serious illness or disability" donators:2.00f];
        [Charity new:@"childfund" title:@"ChildFund International" information:@"ChildFund International is inspired and driven by the potential that is inherent in all children; the potential not only to survive but to thrive, to become leaders who bring positive change for those around them." amount_todate:20.00f affected_total:10.00f affected_ratio:5.00f countrycode:@"US" weburl:@"http://www.childfund.org/" problem:@"children in bad neightbours" solution:@"Make the neightbour's more kid's safe" donators:50.00f];
        [Charity new:@"savethechildren" title:@"Save the children" information:@"Save the american children" amount_todate:170.00f affected_total:80.00f affected_ratio:75.00f countrycode:@"US" weburl:@"http://www.savethechildren.org/" problem:@"children in bad neightbours" solution:@"make the neightbour more kids safe" donators:90.00f];
        [Charity new:@"prinsbernhard" title:@"Prins Bernhard Cultuur Fonds" information:@"Gives Nature a chance." amount_todate:2.00f affected_total:0.01f affected_ratio:0.00f countrycode:@"NL" weburl:@"http://www.prinsbernhardcultuurfonds.nl/" problem:@"to few nature" solution:@"make place for the nature, and helping to get the parks good" donators:1.00f];
        [Charity new:@"euroculture" title:@"EU Culture programme" information:@"The CCP’s main role is to help promote awareness and understanding of this programme, to provide advice and to encourage cultural organisations from their country to become involved in successful applications." amount_todate:500.34f affected_total:200.00f affected_ratio:150.00f countrycode:@"UK" weburl:@"http://www.culturefund.eu/" problem:@"awareness and understanding" solution:@"Provide advice about understanding the Euro Culture Programme" donators:320.00f];
        [Charity new:@"ecf" title:@"Euro Culture Foundation" information:@"We are an independent foundation based in the Netherlands that has been operating across Europe for nearly 60 years. All our activities are connected to our guiding principles. Many of these activities are connected to our current theme, Narratives for Europe (2009 to 2012)." amount_todate:350.00f affected_total:200.00f affected_ratio:175.00f countrycode:@"NL" weburl:@"http://www.eurocult.org/" problem:@"awareness and understanding" solution:@"Provide advice about understanding the Euro Culture Programme" donators:178.00f];
        [Charity new:@"gef" title:@"Global Environment Fund" information:@"Established in 1990, the Global Environment Fund (GEF) invests in businesses around the world that provide cost-effective solutions to environmental and energy challenges.  The firm manages private equity dedicated to clean technology, emerging markets, and sustainable forestry, with approximately $1 billion in aggregate capital under management.  GEF’s investors include prominent endowments, foundations, family offices, and pension funds." amount_todate:3.00f affected_total:0.20f affected_ratio:3.05f countrycode:@"US" weburl:@"http://www.globalenvironmentfund.com/" problem:@"engergy what is not clean" solution:@"help busnesses to get cleaner energy" donators:1.00f];
        [Charity new:@"edf" title:@"Environmental Defense Fund" information:@"We take on the most urgent environmental threats to the climate, oceans, ecosystems and people's health." amount_todate:7.50f affected_total:1.00f affected_ratio:0.01f countrycode:@"US" weburl:@"http://www.edf.org/" problem:@"dumping stuff in oceans" solution:@"help to hold them clean" donators:3.00f];
        [Charity new:@"negef" title:@"New England Grassroots Environment Fund" information:@"''for the New England environmental movement to succeed, the New England environmental movement must project a broad and compelling vision that will persuade large numbers of people that they are stakeholders in the formidable effort to build a sustainable future. This effort must begin at the local level. If environmental protection is imposed upon people, we will surely fail. But if it is accomplished with, for, and because of people, we may succeed…''." amount_todate:270.50f affected_total:40.00f affected_ratio:8.00f countrycode:@"UK" weburl:@"http://grassrootsfund.org/" problem:@"nature will be abused" solution:@"protect the nature" donators:200.00f];
        [Charity new:@"nidirect" title:@"NIDirect" information:@"Further Education Support Funds -- The intention of Support Funds is to help students who are inhibited by financial considerations from accessing and participating in further education. They may also give financial help to those who, for whatever reason including physical or other disabilities, face financial difficulties." amount_todate:50.00f affected_total:25.00f affected_ratio:10.00f countrycode:@"UK" weburl:@"http://www.nidirect.gov.uk/" problem:@"pepole are stucked up with there money" solution:@"Help the pepole with there financial busnisses" donators:39.00f];
        [Charity new:@"directgov" title:@"Direct Gov" information:@"Public Services" amount_todate:17.50f affected_total:20.00f affected_ratio:5.00f countrycode:@"UK" weburl:@"http://www.direct.gov.uk/" problem:@"to few public servives" solution:@"Give anyboady the public services they needed" donators:9.00f];
        [Charity new:@"isf" title:@"Israel Support Found" information:@"Israel Support Fund is unique. Those in need do not have to seek us out; we go to them. Through our network of 'front-line' volunteers with Hatzolah, Zaka, members of various communities and word of mouth, we find our way to those who need us." amount_todate:403.00f affected_total:200.00f affected_ratio:199.90f countrycode:@"IL" weburl:@"http://www.israelsupportfund.org/" problem:@"Unsafe living in Israel" solution:@"Make it more Safe in Israel" donators:350.00f];
        [Charity new:@"maxhavelaar" title:@"Max Havelaar" information:@"Stichting Max Havelaar (or the Max Havelaar Foundation in English) is the Dutch member of FLO International, which unites 23 Fairtrade producer and labelling initiatives across Europe, Asia, Latin America, North America, Africa, Australia and New Zealand. Several of these corresponding organizations in other European countries also use the Max Havelaar name. The name comes from Max Havelaar, which is both the title and the main character of a Dutch 19th-century novel (written by Multatuli) critical of Dutch colonialism in the Dutch East Indies." amount_todate:500.78f affected_total:44.44f affected_ratio:33.33f countrycode:@"WW" weburl:@"http://www.maxhavelaar.nl/" problem:@"pepole in 3rd world country's dont get the money they needed." solution:@"A good price of the product, so the farmer gets also their money they needed" donators:468.00f];
        
        [CharityCategory new:@"aidsfonds" uid_category:@"health" is_primary:YES];
        [CharityCategory new:@"dance4life" uid_category:@"health" is_primary:YES];
        [CharityCategory new:@"redcross" uid_category:@"health" is_primary:YES];
        [CharityCategory new:@"natuurmonumenten" uid_category:@"nature" is_primary:YES];
        [CharityCategory new:@"wwf" uid_category:@"nature" is_primary:YES];
        [CharityCategory new:@"naturefoundations" uid_category:@"nature" is_primary:YES];
        [CharityCategory new:@"hendrik" uid_category:@"community" is_primary:YES];
        [CharityCategory new:@"co-operative" uid_category:@"community" is_primary:YES];
        [CharityCategory new:@"ourcommunity" uid_category:@"community" is_primary:YES];
        [CharityCategory new:@"appsterdam" uid_category:@"community" is_primary:YES];
        [CharityCategory new:@"itfund" uid_category:@"children" is_primary:YES];
        [CharityCategory new:@"childfund" uid_category:@"children" is_primary:YES];
        [CharityCategory new:@"savethechildren" uid_category:@"children" is_primary:YES];
        [CharityCategory new:@"prinsbernhard" uid_category:@"culture" is_primary:YES];
        [CharityCategory new:@"euroculture" uid_category:@"culture" is_primary:YES];
        [CharityCategory new:@"ecf" uid_category:@"culture" is_primary:YES];
        [CharityCategory new:@"gef" uid_category:@"environmental" is_primary:YES]; 
        [CharityCategory new:@"edf" uid_category:@"environmental" is_primary:YES];
        [CharityCategory new:@"negef" uid_category:@"environmental" is_primary:YES];
        [CharityCategory new:@"maxhavelaar" uid_category:@"environmental" is_primary:YES];
        [CharityCategory new:@"nidirect" uid_category:@"support" is_primary:YES];
        [CharityCategory new:@"directgov" uid_category:@"support" is_primary:YES];
        [CharityCategory new:@"isf" uid_category:@"support" is_primary:YES];
	}

	- (void) setupDatabase
	{

#if DEBUG        
		NSLog(@"Configuring Database for first time");
#endif
        
		self.modelMajor = _currentMajor;
		self.modelMinor = _currentMinor;



        [self.managedObjectContext save:nil];
        
	}    

	#pragma mark - Singleton stuff... Don't mess with this other than proxyInit!

	- (void) proxyInit
	{						
		
		_appController = [AppController sharedInstance];	        
		        
		_upgradeModel = !((_currentMajor == self.modelMajor) && (_currentMinor == self.modelMinor));
		
		_syncdEntities = [[NSArray alloc] initWithObjects:nil];
		_sbWriter = [[SBJsonWriter alloc] init];

		if (_upgradeModel) {			
#if DEBUG            
			NSLog(@"Need to upgrade the database model to the latest version...");			
#endif            
		}
						
		NSManagedObjectContext *context = self.managedObjectContext;
		if (context == nil) {
#if DEBUG             
			NSLog(@"Theres an issue creating the default data context");
#endif            
		}
		
		if (!_appController.setupComplete) {
			[self setupDatabase];
			_appController.setupComplete = YES;
		}
		
		[self setupOptions];
		
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

	+ (DataController *) sharedInstance
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
