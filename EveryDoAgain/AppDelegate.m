//
//  AppDelegate.m
//  EveryDoAgain
//
//  Created by RS on 2015-01-01.
//  Copyright (c) 2015 RS. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "DetailViewController.h"


#
# pragma mark - Interface
#


@interface AppDelegate () <UISplitViewControllerDelegate>

#
# pragma mark Core Data Properties
#

// NOTE: Private accessors are read-write
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@end


#
# pragma mark - Implementation
#


@implementation AppDelegate


#
# pragma mark <UIApplicationDelegate>
#


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// Override point for customization after application launch.
	
	// Set up delegates
	UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
	splitViewController.delegate = self;
	
	UINavigationController *detailNavigationController = splitViewController.viewControllers.lastObject;
	DetailViewController *detailViewController = (DetailViewController *)detailNavigationController.topViewController;
	detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;

	// Inject Core Data Managed Object Context (MOC) into Master View Controller
	MainTabBarController* mainTabBarController = splitViewController.viewControllers.firstObject;
	mainTabBarController.managedObjectContext = self.managedObjectContext;
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	
	// Saves changes in the application's managed object context before the application terminates.
	[self saveManagedObjectContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

	// Saves changes in the application's managed object context before the application terminates.
	[self saveManagedObjectContext];
}


#
# pragma mark <UISplitViewControllerDelegate>
#


- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
	
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] &&
		[[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] &&
		([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] todo] == nil)) {
		
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    }
	
	return NO;
}


#
# pragma mark - Core Data Stack
#


#
# pragma mark Core Data Accessors
#


//
// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
//
- (NSManagedObjectContext *)managedObjectContext {
	
	if (_managedObjectContext) return _managedObjectContext;
	
	NSPersistentStoreCoordinator *psc = self.persistentStoreCoordinator;
	if (!psc) return nil;
	
	_managedObjectContext = [[NSManagedObjectContext alloc] init]; // Init call makes this thread default owner
	_managedObjectContext.persistentStoreCoordinator = psc;
	
	return _managedObjectContext;
}


//
// The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
//
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (_persistentStoreCoordinator) return _persistentStoreCoordinator;
    
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [[AppDelegate applicationDocumentsDirectoryURL] URLByAppendingPathComponent:@"EveryDoAgain.sqlite"];
    NSError *error = nil;
    if ([_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) return _persistentStoreCoordinator;

	// TODO: Replace this with code to handle the error appropriately.
	// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	error = [AppDelegate persistentStoreError:error];
	NSLog(@"Unresolved error %@, %@", error, error.userInfo);
	abort();
	
    return _persistentStoreCoordinator;
}


//
// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
//
- (NSManagedObjectModel *)managedObjectModel {

	if (_managedObjectModel) return _managedObjectModel;
	
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EveryDoAgain" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	
	return _managedObjectModel;
}


#
# pragma mark Core Data Helpers
#


- (void)saveManagedObjectContext {
	
    NSManagedObjectContext *moc = self.managedObjectContext;
	if (!moc || !moc.hasChanges) return;
	
	NSError *error = nil;
	if ([moc save:&error]) return;
		
	// TODO: Replace this with code to handle the error appropriately.
	// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	NSLog(@"Unresolved error %@, %@", error, error.userInfo);
	abort();
}


+ (NSError *)persistentStoreError:(NSError*)error {

	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
	
	dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
	dict[NSLocalizedFailureReasonErrorKey] = @"There was an error creating or loading the application's saved data.";
	dict[NSUnderlyingErrorKey] = error;
	
	error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
	
	return error;
}



#
# pragma mark - Helpers
#


//
// This code uses a directory named "-johnny.EveryDoAgain" in the application's documents directory.
//
+ (NSURL *)applicationDocumentsDirectoryURL {
	
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
