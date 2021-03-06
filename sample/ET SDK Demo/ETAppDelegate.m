//
//  ETAppDelegate.m
//  ET SDK Demo
//
//  Created by Eddie Roger on 9/5/12.
//  Copyright (c) 2012 ExactTarget, Inc. All rights reserved.
//

#import "ETAppDelegate.h"

#import "ETViewController.h"
#import "OpenDirectDemoViewController.h"

@implementation ETAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"Launch Options: %@", launchOptions);
    
    [[ETPush pushManager] configureSDKWithAppID:@"" andAccessToken:@""];
    [[ETPush pushManager] setOpenDirectDelegate:self];
    [[ETPush pushManager] setDisplayLocalNotificationsTo:YES];    
    
    [[ETPush pushManager] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    [[ETPush pushManager] resetBadgeCount]; 
    [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions]; 
    
    
    // Normal app launch info below.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ETViewController alloc] initWithNibName:@"ETViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ETViewController alloc] initWithNibName:@"ETViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[ETPush pushManager] applicationTerminated];
}

#pragma mark - Push Notification Delegate Calls

// Called when the device receives a token from Apple.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // The device should also register with ET here, and developers' system if they track as well.
    [[ETPush pushManager] registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Received a push! %d", application.applicationState);
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
}

#pragma mark - ET OpenDirect Delegate
-(void)didReceiveOpenDirectMessageWithContents:(NSString *)payload
{

    OpenDirectDemoViewController *odvc = [[OpenDirectDemoViewController alloc] init];
    [odvc setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self.viewController presentModalViewController:odvc animated:YES];
    
}

-(BOOL)shouldDeliverOpenDirectMessageIfAppIsRunning
{
    return YES;
}


@end
