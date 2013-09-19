//
//  LITAlcoholTesterViewController.m
//  LITTech
//
//  Created by John McLane on 7/14/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITAlcoholTesterViewController.h"
#import "LITPersonManager.h"
#import "LITPerson.h"

@interface LITAlcoholTesterViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *alcoholEntries;
@property (nonatomic, strong) UILabel *totalLabel;

- (void)addAction:(id)sender;
- (void)addToHistory:(id)sender;

@end

@implementation LITAlcoholTesterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Alcohol Tester", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"alcohol.png"];
        _alcoholEntries = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    
    UIBarButtonItem *addToHistoryBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Add to History" style:UIBarButtonItemStylePlain target:self action:@selector(addToHistory:)];
    self.navigationItem.rightBarButtonItem = addToHistoryBarButton;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, 200.0, 29.0)];
    titleLabel.text = @"Press + to add new entry";
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, addButton.frame.size.height + 8)];
    CGRect frame = addButton.frame;
    frame.origin.x = 216;//round((self.view.frame.size.width - frame.size.width) / 2);
    frame.origin.y = 8;
    addButton.frame = frame;
    [view addSubview:addButton];
    [view addSubview:titleLabel];
    self.tableView.tableHeaderView = view;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 48.0)];
    self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, self.view.frame.size.width - 16, 40)];
    self.totalLabel.font = [UIFont boldSystemFontOfSize:17];
    self.totalLabel.text = @"Total: 0 mg/L\nYou will be able to drive in 0 hours.";
    self.totalLabel.numberOfLines = 2;
    [footerView addSubview:self.totalLabel];
    self.tableView.tableFooterView = footerView;
}

- (void)viewWillAppear:(BOOL)animated {
    self.alcoholEntries = [NSMutableArray array];
    
    [self.tableView reloadData];
    [self recalculateTotal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.alcoholEntries.count == 0)
        return 1;
    return self.alcoholEntries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.indentationWidth = 20.0;
    cell.indentationLevel = 1;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    if (self.alcoholEntries.count == 0) {
        cell.textLabel.text = @"---";
        cell.detailTextLabel.text = @"";
    } else {
        NSDictionary *dict = [self.alcoholEntries objectAtIndex:indexPath.row];
        
        double quantity = [[dict valueForKey:@"quantity"] doubleValue];
        double concentration = [[dict valueForKey:@"concentration"] doubleValue];
        
        LITPerson *currentPerson = [LITPersonManager sharedInstance].currentPerson;
        double coefficient = (currentPerson.isMale) ? 0.7 : 0.6;
        double bloodAlcohol = ( (concentration * coefficient * quantity / 100) / (currentPerson.weight * 1000 * currentPerson.weight / 100) ) * 1000;
        
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f mg/L", bloodAlcohol];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f ml | %.2f%% alcohol", quantity, concentration];
    }
    
    return cell;
}

- (void)addAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter alcohol data"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Continue", nil];
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField *concentrationTextField = [alertView textFieldAtIndex:0];
    concentrationTextField.secureTextEntry = NO;
    concentrationTextField.placeholder = @"Concentration (C%)";
    concentrationTextField.text = @"";
    concentrationTextField.keyboardType = UIKeyboardTypeDecimalPad;

    UITextField *quantityTextField = [alertView textFieldAtIndex:1];
    quantityTextField.secureTextEntry = NO;
    quantityTextField.placeholder = @"Quantity (ml)";
    quantityTextField.text = @"";
    quantityTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        double concentration = [[alertView textFieldAtIndex:0].text doubleValue];
        double quantity = [[alertView textFieldAtIndex:1].text doubleValue];
        
        [self.alcoholEntries addObject:@{@"concentration": [NSNumber numberWithDouble:concentration], @"quantity": [NSNumber numberWithDouble:quantity]}];
        
        [self.tableView reloadData];
        [self recalculateTotal];
    }
}

- (void)recalculateTotal {
    double totalAlcohol = 0.0;
    if (self.alcoholEntries.count) {
        for (NSDictionary *dict in self.alcoholEntries) {
            double quantity = [[dict valueForKey:@"quantity"] doubleValue];
            double concentration = [[dict valueForKey:@"concentration"] doubleValue];
            
            LITPerson *currentPerson = [LITPersonManager sharedInstance].currentPerson;
            double coefficient = (currentPerson.isMale) ? 0.7 : 0.6;
            double bloodAlcohol = ( (concentration * coefficient * quantity / 100) / (currentPerson.weight * 1000 * currentPerson.weight / 100) ) * 1000;
            totalAlcohol += bloodAlcohol;
        }
    }
    self.totalLabel.text = [NSString stringWithFormat:@"Total: %.2f mg/L\nYou will be able to drive in %d hours.", totalAlcohol, (int)round(totalAlcohol * 10)];
}

- (void)addToHistory:(id)sender {
    double totalAlcohol = 0.0;
    if (self.alcoholEntries.count) {
        for (NSDictionary *dict in self.alcoholEntries) {
            double quantity = [[dict valueForKey:@"quantity"] doubleValue];
            double concentration = [[dict valueForKey:@"concentration"] doubleValue];
            
            LITPerson *currentPerson = [LITPersonManager sharedInstance].currentPerson;
            double coefficient = (currentPerson.isMale) ? 0.7 : 0.6;
            double bloodAlcohol = ( (concentration * coefficient * quantity / 100) / (currentPerson.weight * 1000 * currentPerson.weight / 100) ) * 1000;
            totalAlcohol += bloodAlcohol;
        }
        
        [[LITPersonManager sharedInstance].currentPerson addAlcholEventWithInfo:[NSString stringWithFormat:@"You have %.2f mg/L of alcohol in your blood.", totalAlcohol]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alcohol entry added" message:@"Check your history" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
