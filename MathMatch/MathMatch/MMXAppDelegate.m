//
//  MMXAppDelegate.m
//  MathMatch
//
//  Created by Kyle O'Brien on 2014.1.16.
//  Copyright (c) 2014 Computer Lab. All rights reserved.
//

#import "MMXAppDelegate.h"
#import "HMIAPHelper.h"

@implementation MMXAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.navController = (MMXNavigationController *)self.window.rootViewController;
    self.navController.managedObjectContext = self.managedObjectContext;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    NSDictionary *attricbutes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-DemiBold" size:18.0],
                                  NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [[UINavigationBar appearanceWhenContainedIn:[MMXNavigationController class], nil] setTitleTextAttributes:attricbutes];
    [[UINavigationBar appearanceWhenContainedIn:[MMXNavigationController class], nil] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn:[MMXNavigationController class], nil] setTitleTextAttributes:attricbutes
                                                                                                    forState:UIControlStateNormal];
    
    attricbutes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-DemiBold" size:18.0]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:attricbutes];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attricbutes forState:UIControlStateNormal];
    
    [MMXAudioManager sharedManager].track = MMXAudioTrackMenus;
    [[MMXAudioManager sharedManager] playTrack];
    
    [SharedIAP prepare];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

#pragma mark - Core Data

- (NSManagedObjectContext *)managedObjectContext
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

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MathMatch" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MathMatch.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Helpers

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
