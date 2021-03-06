//
//  LITPersonalFileViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 6/25/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPersonalFileViewController.h"
#import "LITPerson.h"
#import "LITConstants.h"
#import "LITDataManager.h"
#import "LITEvent.h"
#import "LITRuffierViewController.h"
#import "LITDaltonismTestViewController.h"
#import "LITPulseCalculatorViewController.h"
#import "LITPersonManager.h"


@interface LITPersonalFileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImage *alcoholImage;
@property (nonatomic, strong) UIImage *mealImage;
@property (nonatomic, strong) UIImage *workoutImage;
@property (nonatomic, strong) UIImage *heartRateImage;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (void)personUpdated:(NSNotification *)inNotification;

@end


@implementation LITPersonalFileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Personal File", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"personal_file.png"];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"MM/dd/YYYY";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(personUpdated:) name:kLITPersonUpdatedNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    
    self.alcoholImage = [UIImage imageNamed:@"alcohol.png"];
    self.mealImage = [UIImage imageNamed:@"meal.png"];
    self.workoutImage = [UIImage imageNamed:@"workout.png"];
    self.heartRateImage = [UIImage imageNamed:@"heartRate.png"];
}

- (void)personUpdated:(NSNotification *)inNotification {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"";
            break;
        case 1:
            return NSLocalizedString(@"Personal info", @"");
            break;
        case 2:
            return NSLocalizedString(@"Computed values", @"");
            break;
        case 3:
            return NSLocalizedString(@"History", @"");
            break;
        default:
            break;
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 8;
            break;
        case 3:
            return [LITPersonManager sharedInstance].currentPerson.events.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (0 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"nameCell"];
        }
        
        cell.textLabel.text = NSLocalizedString(@"Name", @"");
        cell.detailTextLabel.text = [LITPersonManager sharedInstance].currentPerson.name;
    } else if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"personalInfoCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"personalInfoCell"];
        }
        
        if (0 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Sex", @"");
            cell.detailTextLabel.text = [LITPersonManager sharedInstance].currentPerson.isMale ? NSLocalizedString(@"Male", @"") : NSLocalizedString(@"Female", @"");
        } else if (1 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Height", @"");
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d cm", [LITPersonManager sharedInstance].currentPerson.height];
        } else if (2 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Weight", @"");
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kg", [LITPersonManager sharedInstance].currentPerson.weight];
        } else if (3 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Age", @"");
            if ([LITPersonManager sharedInstance].currentPerson.birthDate) {
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[LITPersonManager sharedInstance].currentPerson.birthDate toDate:[NSDate date] options:0];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d years", components.year];
            }
        }
    } else if (2 == indexPath.section) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"IMCCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"IMCCell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        } else if (indexPath.row < 5) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"computedInfoCellSubtitle"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"computedInfoCellSubtitle"];
            }
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"computedInfoCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"computedInfoCell"];
            }
        }
        
        if (0 == indexPath.row) {
            double imc = [[LITPersonManager sharedInstance].currentPerson imc];
            cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Body mass index: %.2f kg / m^2", @""), imc];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            
            NSString *detail = @"";
            if (imc > 40) {
                detail = @"You are diagnosed with super obesity. At the BMI your body undergoes the risk of many diseases, including diabetes, hypertension or heart disease. We recommend following the advice of a physician to arrive at an optimal weight and changing eating habits and sports.";
            } else if (imc > 35) {
                detail = @"You are diagnosed with morbid obesity. Obesity is a medical condition in which excess body fat has accumulated so that may have an adverse effect on health, leading to reduced life expectancy and / or health problems.";
            } else if (imc > 30) {
                detail = @"You are diagnosed with severe obesity. Obesity is a medical condition in which excess body fat has accumulated so that may have an adverse effect on health, leading to reduced life expectancy and / or health problems.";
            } else if (imc > 25) {
                detail = @"You are considered overweight. Doctors usually define overweight as a condition in which a person's weight is 10% -20% higher than normal.";
            } else if (imc > 18.5) {
                detail = @"You BMI ideal amount of body fat sufficient to ensure optimal health.";
            } else if (imc > 0) {
                detail = @"The amount of body fat is very low. If you are a performance athlete, achieving a low BMI may be a short-term goal. If you're not an athlete, a low BMI may indicate that you are underweight, which can lead to decreased immunity of the body. If both weight and BMI are low, it is recommended to gain weight using diet and exercise designed to increase your muscle mass.";
            }
            cell.detailTextLabel.text = detail;
        } else if (1 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Ruffier index", @"");
        } else if (2 == indexPath.row) {
            cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Basal metabolic rate: %.2f", @""), [LITPersonManager sharedInstance].currentPerson.bmr];
            cell.detailTextLabel.text = @"BMR represents the minimum amount of energy (kcal / kJ) used by the body to keep us alive, when in a state of complete rest, normal mental activity, a neutral temperature and inactivity of the digestive system.";
        } else if (3 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Daltonism test", @"");
        } else if (4 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Heart rate", @"");
        } else if (5 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Ideal weight (normal):", @"");
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kg", [LITPersonManager sharedInstance].currentPerson.idealWeightNormal];
        } else if (6 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Ideal weight (slender):", @"");
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kg", [LITPersonManager sharedInstance].currentPerson.idealWeightSlender];
        } else if (7 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Ideal weight (robust):", @"");
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kg", [LITPersonManager sharedInstance].currentPerson.idealWeightRobust];
        }
    } else if (3 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"historyCell"];
            cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        }
        LITEvent *event = [[LITPersonManager sharedInstance].currentPerson.events objectAtIndex:indexPath.row];
        
        if (LITEventTypeWorkout == event.type) {
            cell.imageView.image = self.workoutImage;
            cell.textLabel.text = [NSString stringWithFormat:@"Workout - %@", [self.dateFormatter stringFromDate:event.date]];
            cell.detailTextLabel.text = event.info;
        } else if (LITEventTypeMeal == event.type) {
            cell.imageView.image = self.mealImage;
            cell.textLabel.text = [NSString stringWithFormat:@"Meal - %@", [self.dateFormatter stringFromDate:event.date]];
            cell.detailTextLabel.text = event.info;
        } else if (LITEventTypeAlcohol == event.type) {
            cell.imageView.image = self.alcoholImage;
            cell.textLabel.text = [NSString stringWithFormat:@"Alcohol - %@", [self.dateFormatter stringFromDate:event.date]];
            cell.detailTextLabel.text = event.info;
        } else if (LITEventTypeHeartRate == event.type) {
            cell.imageView.image = self.heartRateImage;
            cell.textLabel.text = [NSString stringWithFormat:@"Heart Rate - %@", [self.dateFormatter stringFromDate:event.date]];
            cell.detailTextLabel.text = event.info;
        }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (2 == indexPath.section) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ( ( (2 == indexPath.section) && (0 == indexPath.row) ) || ( (2 == indexPath.section) && (2 == indexPath.row) ) ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cell.textLabel.text message:cell.detailTextLabel.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if ( (2 == indexPath.section) && (1 == indexPath.row) ) {
        LITRuffierViewController *ruffierViewController = [[LITRuffierViewController alloc] initWithNibName:@"LITRuffierViewController" bundle:nil];
        [self.navigationController pushViewController:ruffierViewController animated:YES];
    } else if ( (2 == indexPath.section) && (3 == indexPath.row) ) {
        LITDaltonismTestViewController *daltonismTestViewController = [[LITDaltonismTestViewController alloc] initWithNibName:@"LITDaltonismTestViewController" bundle:nil];
        [self.navigationController pushViewController:daltonismTestViewController animated:YES];
    } else if ( (2 == indexPath.section) && (4 == indexPath.row) ) {
        LITPulseCalculatorViewController *pulseCalculatorViewController = [[LITPulseCalculatorViewController alloc] initWithNibName:@"LITPulseCalculatorViewController" bundle:nil];
        [self.navigationController pushViewController:pulseCalculatorViewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
