//
//  MMXAppDelegate.m
//  MathMatch
//
//  Created by Kyle O'Brien on 2014.1.16.
//  Copyright (c) 2014 Computer Lab. All rights reserved.
//

#import "MMXAppDelegate.h"
#import "HMIAPHelper.h"
#import "MMXDataManager.h"

@implementation MMXAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MathMatch"];
    
    self.navController = (MMXNavigationController *)self.window.rootViewController;
    self.navController.managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    
    
    
    [MMXDataManager initDataBase];
    
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

#pragma mark - Helpers

- (void)saveContext
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        
    }];
}

@end
