//
//  LITAppDelegate.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 6/25/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITAppDelegate.h"
#import "LITPersonalFileViewController.h"
#import "LITMedicalDictionaryViewController.h"
#import "LITAlcoholTestViewController.h"
#import "LITCalorieCalculatorViewController.h"
#import "LITSettingsViewController.h"
#import "LITEditPersonViewController.h"
#import "LITConstants.h"


#import "LITDataManager.h"
//#import "LITPerson.h"

@implementation LITAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    LITPersonalFileViewController *personalFileViewController = [[LITPersonalFileViewController alloc] initWithNibName:@"LITPersonalFileViewController" bundle:nil];
    UIViewController *medicalDictionaryViewController = [[LITMedicalDictionaryViewController alloc] initWithNibName:@"LITMedicalDictionaryViewController" bundle:nil];
    UIViewController *alcoholTesterViewController = [[LITAlcoholTestViewController alloc] initWithNibName:@"LITAlcoholTestViewController" bundle:nil];
    UIViewController *calorieCalculatorViewController = [[LITCalorieCalculatorViewController alloc] initWithNibName:@"LITCalorieCalculatorViewController" bundle:nil];
    UIViewController *settingsViewController = [[LITSettingsViewController alloc] initWithNibName:@"LITSettingsViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[personalFileViewController, medicalDictionaryViewController, alcoholTesterViewController, calorieCalculatorViewController, settingsViewController];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    NSArray *persons = [[LITDataManager sharedInstance] loadPersons];
    if (persons.count == 0) {
        LITEditPersonViewController *addPersonViewController = [[LITEditPersonViewController alloc] initWithNibName:@"LITEditPersonViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addPersonViewController];
        [self.tabBarController presentModalViewController:navigationController animated:NO];
    } else {
        personalFileViewController.person = [persons objectAtIndex:0];
    }
    
//    if (persons.count > 0) {
//        LITPerson *currentPerson = [persons objectAtIndex:0];
//        currentPerson.height += 10;
//        [[LITDataManager sharedInstance] savePerson:currentPerson];
//    } else {
//        LITPerson *person = [[LITPerson alloc] init];
//        person.name = @"Bogdan";
//        person.male = YES;
//        person.height = 178;
//        person.weight = 80.0;
//        
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:4];
//        [comps setMonth:6];
//        [comps setYear:1985];
//        person.birthDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
//        [[LITDataManager sharedInstance] savePerson:person];
//    }
    
    
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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
