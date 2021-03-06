//
//  LITAppDelegate.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 6/25/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITAppDelegate.h"
#import "LITPersonalFileViewController.h"
#import "LITAlcoholTesterViewController.h"
#import "LITCalorieCalculatorViewController.h"
#import "LITSettingsViewController.h"
#import "LITEditPersonViewController.h"
#import "LITMedicalDictionaryViewController.h"
#import "LITConstants.h"

#import "LITDataManager.h"
#import "LITPersonManager.h"

@implementation LITAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    LITPersonalFileViewController *personalFileViewController = [[LITPersonalFileViewController alloc] initWithNibName:@"LITPersonalFileViewController" bundle:nil];
    UINavigationController *personalFileViewNavCtlr = [[UINavigationController alloc] initWithRootViewController:personalFileViewController];
    personalFileViewNavCtlr.navigationBar.barStyle = UIBarStyleBlack;
    
    LITAlcoholTesterViewController *alcoholTesterViewController = [[LITAlcoholTesterViewController alloc] initWithNibName:@"LITAlcoholTesterViewController" bundle:nil];
    UINavigationController *alcoholTesterNavCtlr = [[UINavigationController alloc] initWithRootViewController:alcoholTesterViewController];
    alcoholTesterNavCtlr.navigationBar.barStyle = UIBarStyleBlack;
    
    LITCalorieCalculatorViewController *calorieCalculatorViewController = [[LITCalorieCalculatorViewController alloc] initWithNibName:@"LITCalorieCalculatorViewController" bundle:nil];
    UINavigationController *calorieCalculatorNavCtlr = [[UINavigationController alloc] initWithRootViewController:calorieCalculatorViewController];
    calorieCalculatorNavCtlr.navigationBar.barStyle = UIBarStyleBlack;
    
    LITMedicalDictionaryViewController *medDictViewController = [[LITMedicalDictionaryViewController alloc] initWithNibName:@"LITMedicalDictionaryViewController" bundle:nil];
    UINavigationController *medDictNavCtlr = [[UINavigationController alloc] initWithRootViewController:medDictViewController];
    medDictNavCtlr.navigationBar.barStyle = UIBarStyleBlack;
    
    UIViewController *settingsViewController = [[LITSettingsViewController alloc] initWithNibName:@"LITSettingsViewController" bundle:nil];
    UINavigationController *settingsNavCtlr = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    settingsNavCtlr.navigationBar.barStyle = UIBarStyleBlack;
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[personalFileViewNavCtlr, calorieCalculatorNavCtlr, alcoholTesterNavCtlr, medDictNavCtlr, settingsNavCtlr];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    NSArray *persons = [[LITDataManager sharedInstance] loadPersons];
    if (persons.count == 0) {
        LITEditPersonViewController *addPersonViewController = [[LITEditPersonViewController alloc] initWithNibName:@"LITEditPersonViewController" bundle:nil];
        addPersonViewController.modal = YES;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addPersonViewController];
        [self.tabBarController presentViewController:navigationController animated:NO completion:nil];
    } else {
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
