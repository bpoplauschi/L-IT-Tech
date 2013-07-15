//
//  LITAddWorkoutViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITAddWorkoutViewController.h"
#import "LITPersonManager.h"
#import "LITPerson.h"

@interface LITAddWorkoutViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *activities;
@property (nonatomic, strong) NSArray *activitiesArray;
@property (nonatomic, assign) int selectedIndex;

@end

@implementation LITAddWorkoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Workout", @"");
        
        _activities = @{@"Sleeping" : @0.9,
                        @"Watching TV" : @1.0,
                        @"Writing, desk work, typing" : @1.8,
                        @"Walking slowly" : @2.0,
                        @"General house cleaning" : @3.0,
                        @"Volleyball" : @3.0,
                        @"Walking briskly" : @3.3,
                        @"Climbing stairs" : @4.0,
                        @"Bicycling, casual" : @4.0,
                        @"Dancing" : @4.8,
                        @"Weightlifting (vigorous)" : @6.0,
                        @"Shoveling snow" : @6.0,
                        @"Skiing, downhill" : @7.0,
                        @"Backpacking" : @7.0,
                        @"Bicycling" : @8.0,
                        @"Aerobic calisthenics" : @8.0,
                        @"Basketball" : @8.0,
                        @"Swimming, crawl, slow" : @8.0,
                        @"Singles tennis" : @9.5,
                        @"Soccer" : @10.0,
                        @"Running" : @11.0};
        _activitiesArray = [_activities keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [(NSNumber*)obj1 compare:(NSNumber*)obj2];
        }];
        _selectedIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activitiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *activityName = [_activitiesArray objectAtIndex:indexPath.row];
    
    NSString *imageName = nil;
    switch (indexPath.row) {
        case 0:
            imageName = @"sleep";
            break;
        case 1:
            imageName = @"tv";
            break;
        case 2:
            imageName = @"desk";
            break;
        case 3:
            imageName = @"walk";
            break;
        case 4:
            imageName = @"houseclean";
            break;
        case 5:
            imageName = @"volleyball";
            break;
        case 6:
            imageName = @"walk";
            break;
        case 7:
            imageName = @"stairs";
            break;
        case 8:
            imageName = @"bike";
            break;
        case 9:
            imageName = @"dance";
            break;
        case 10:
            imageName = @"shovel";
            break;
        case 11:
            imageName = @"weightlift";
            break;
        case 12:
            imageName = @"ski";
            break;
        case 13:
            imageName = @"bagpack";
            break;
        case 14:
            imageName = @"basketball";
            break;
        case 15:
            imageName = @"bike";
            break;
        case 16:
            imageName = @"swim";
            break;
        case 17:
            imageName = @"aerobic";
            break;
        case 18:
            imageName = @"tennis";
            break;
        case 19:
            imageName = @"football";
            break;
        case 20:
            imageName = @"run";
            break;
        default:
            break;
    }
    if (imageName.length) {
        imageName = [imageName stringByAppendingPathExtension:@"png"];
        cell.imageView.image = [UIImage imageNamed:imageName];
    } else {
        cell.imageView.image = nil;
    }
    
    cell.textLabel.text = activityName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text
                                                        message:@"Add duration (minutes)"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Continue", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertView.tag = 1;
    [alertView show];
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    if (alertView.tag == 1) {
        [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeDecimalPad;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0 && alertView.tag == 1) {
        double MET = [[self.activities valueForKey:[self.activitiesArray objectAtIndex:self.selectedIndex]] doubleValue];
        
        double calories = [LITPersonManager sharedInstance].currentPerson.bmr * [[alertView textFieldAtIndex:0].text intValue] / 60 * MET;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Workout added!"
                                                        message:[NSString stringWithFormat:@"You just burned %.2f calories. Check your history in Personal file to see all your workouts.", calories]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        alert.tag = 2;
        [alert show];
        
        [[LITPersonManager sharedInstance].currentPerson addWorkoutEventWithInfo:[NSString stringWithFormat:@"%@ - burned %.2f calories", [self.activitiesArray objectAtIndex:self.selectedIndex], calories]];
    } else if (alertView.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
