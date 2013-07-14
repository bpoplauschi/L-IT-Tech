//
//  LITSettingsViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/1/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITSettingsViewController.h"
#import "LITAboutViewController.h"
#import "LITPersonManager.h"
#import "LITPerson.h"
#import "LITEditPersonViewController.h"

@interface LITSettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation LITSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"settings.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Users";
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1)
        return 1;
    return 1 + [LITPersonManager sharedInstance].persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = @"About";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else  {
        if (indexPath.row != 0) {
            cell.textLabel.text = ((LITPerson *)[[LITPersonManager sharedInstance].persons objectAtIndex:(indexPath.row - 1)]).name;
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        } else {
            cell.textLabel.text = @"Add user";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        LITAboutViewController *aboutVC = [[LITAboutViewController alloc] initWithNibName:@"LITAboutViewController" bundle:nil];
        [self.navigationController pushViewController:aboutVC animated:YES];
    } else if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LITEditPersonViewController *addPersonVC = [[LITEditPersonViewController alloc] initWithNibName:@"LITEditPersonViewController" bundle:nil];
            [self.navigationController pushViewController:addPersonVC animated:YES];
        } else {
            [[LITPersonManager sharedInstance] selectPersonAtIndex:(indexPath.row - 1)];
        }
    }
}

@end
