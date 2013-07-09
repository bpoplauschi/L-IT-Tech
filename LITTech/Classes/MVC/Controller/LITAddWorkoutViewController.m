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
                        @"Shoveling snow" : @6.5,
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
    cell.textLabel.text = [_activitiesArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0 && alertView.tag == 1) {
        double MET = [[self.activities valueForKey:[self.activitiesArray objectAtIndex:self.selectedIndex]] doubleValue];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Workout added!"
                                                        message:[NSString stringWithFormat:@"You just burned %.2f calories. Check your history in Personal file to see all your workouts.", [LITPersonManager sharedInstance].currentPerson.bmr * [[alertView textFieldAtIndex:0].text intValue] / 60 * MET]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        alert.tag = 2;
        [alert show];
    } else if (alertView.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
