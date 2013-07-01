//
//  LITPersonalFileViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 6/25/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPersonalFileViewController.h"


@interface LITPersonalFileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end


@implementation LITPersonalFileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Personal File", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"personal_file.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
            return 5;
            break;
        case 3:
            return 3;
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
        cell.detailTextLabel.text = @"Alina";
    } else if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"personalInfoCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"personalInfoCell"];
        }
        
        if (0 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Sex", @"");
            cell.detailTextLabel.text = NSLocalizedString(@"Female", @"");
        } else if (1 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Height", @"");
            cell.detailTextLabel.text = @"168 cm";
        } else if (2 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Weight", @"");
            cell.detailTextLabel.text = @"48 kg";
        } else if (3 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Age", @"");
            cell.detailTextLabel.text = NSLocalizedString(@"20 years", @"");
        }
    } else if (2 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"computedInfoCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"computedInfoCell"];
        }
        
        if (0 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Body mass index", @"");
        } else if (1 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Ruffier index", @"");
        } else if (2 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Basal metabolism", @"");
        } else if (3 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Daltonism test", @"");
        } else if (4 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Heart rate", @"");
        } else if (5 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Ideal weight calculator", @"");
        }
    } else if (3 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"historyCell"];
            cell.detailTextLabel.minimumScaleFactor = 0.25;
        }
        
        if (0 == indexPath.row) {
            cell.textLabel.text = @"Meal";
            cell.detailTextLabel.text = @"Total of 948 calories on 6/30/2013";
        } else if (1 == indexPath.row) {
            cell.textLabel.text = @"Alcohol entry";
            cell.detailTextLabel.text = @"You had 0.4 mg of alcohol in your blood on 6/30/2013. You weren't able to drive for 4 hours.";
        } else if (2 == indexPath.row) {
            cell.textLabel.text = @"Workout";
            cell.detailTextLabel.text = @"600 calories burnt on 6/30/2013";
        }
    }
    
    return cell;
}

@end
