//
//  LITCalorieCalculatorViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/1/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITCalorieCalculatorViewController.h"
#import "LITAddWorkoutViewController.h"
#import "LITAddMealViewController.h"

@interface LITCalorieCalculatorViewController ()

- (IBAction)workoutAction:(id)sender;
- (IBAction)mealAction:(id)sender;

@end

@implementation LITCalorieCalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Calories Log", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"caloric_scale.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)workoutAction:(id)sender {
    LITAddWorkoutViewController *addWorkoutViewController = [[LITAddWorkoutViewController alloc] initWithNibName:@"LITAddWorkoutViewController" bundle:nil];
    [self.navigationController pushViewController:addWorkoutViewController animated:YES];
}

- (IBAction)mealAction:(id)sender {
    LITAddMealViewController *addMealViewController = [[LITAddMealViewController alloc] initWithNibName:@"LITAddMealViewController" bundle:nil];
    [self.navigationController pushViewController:addMealViewController animated:YES];
}

@end
