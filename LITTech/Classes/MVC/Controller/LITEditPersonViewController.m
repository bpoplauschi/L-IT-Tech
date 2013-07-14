//
//  LITEditPersonViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITEditPersonViewController.h"
#import "LITInputTableViewCell.h"
#import "LITPerson.h"
#import "LITDataManager.h"
#import "LITConstants.h"
#import "LITPersonManager.h"
#import "LITPerson.h"


@interface LITEditPersonViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *cells;

@property (nonatomic, strong) LITInputTableViewCell *nameCell;
@property (nonatomic, strong) LITInputTableViewCell *sexCell;
@property (nonatomic, strong) LITInputTableViewCell *heightCell;
@property (nonatomic, strong) LITInputTableViewCell *weightCell;
@property (nonatomic, strong) LITInputTableViewCell *birthdateCell;

- (void)save:(id)sender;

@end


@implementation LITEditPersonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.title = NSLocalizedString(@"Enter your data", @"");
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Save", @"")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.tableView.allowsSelection = NO;
}

- (NSArray *)cells {
    if (!_cells) {
        _cells = @[self.nameCell, self.sexCell, self.heightCell, self.weightCell, self.birthdateCell];
    }
    return _cells;
}

- (LITInputTableViewCell *)nameCell {
    if (!_nameCell) {
        _nameCell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"name"];
        _nameCell.textLabel.text = NSLocalizedString(@"Name", @"");
		_nameCell.textField.keyboardType = UIKeyboardTypeDefault;
        if (!self.inPerson) {
            _nameCell.detailTextLabel.text = @"Your name";
            _nameCell.textField.textColor = [UIColor lightGrayColor];
        } else  {
            _nameCell.detailTextLabel.text = self.inPerson.name;
            _nameCell.textField.textColor = [UIColor blackColor];
        }
    }
    return _nameCell;
}

- (LITInputTableViewCell *)sexCell {
    if (!_sexCell) {
        _sexCell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sex"];
        _sexCell.textLabel.text = NSLocalizedString(@"Sex", @"");
        _sexCell.textField.keyboardType = UIKeyboardTypeDefault;
        if (!self.inPerson) {
            _sexCell.detailTextLabel.text = @"M/F";
            _sexCell.textField.textColor = [UIColor lightGrayColor];
        } else {
            _sexCell.detailTextLabel.text = self.inPerson.isMale ? @"M" : @"F";
            _sexCell.textField.textColor = [UIColor blackColor];
        }
    }
    return _sexCell;
}

- (LITInputTableViewCell *)heightCell {
    if (!_heightCell) {
        _heightCell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"height"];
        _heightCell.textLabel.text = NSLocalizedString(@"Height", @"");
		_heightCell.textField.keyboardType = UIKeyboardTypeNumberPad;
        
        if (!self.inPerson) {
            _heightCell.detailTextLabel.text = @"cm";
            _heightCell.textField.textColor = [UIColor lightGrayColor];
        } else {
            _heightCell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.inPerson.height];
            _heightCell.textField.textColor = [UIColor blackColor];
        }
    }
    return _heightCell;
}

- (LITInputTableViewCell *)weightCell {
    if (!_weightCell) {
        _weightCell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"weight"];
        _weightCell.textLabel.text = NSLocalizedString(@"Weight", @"");
		_weightCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        
        if (!self.inPerson) {
            _weightCell.detailTextLabel.text = @"kg";
            _weightCell.textField.textColor = [UIColor lightGrayColor];
        } else {
            _weightCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", self.inPerson.weight];
            _weightCell.textField.textColor = [UIColor blackColor];
        }
    }
    return _weightCell;
}

- (LITInputTableViewCell *)birthdateCell {
    if (!_birthdateCell) {
        _birthdateCell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"birthdate"];
        _birthdateCell.textLabel.text = NSLocalizedString(@"Birth date", @"");
		_birthdateCell.textField.keyboardType = UIKeyboardTypeDefault;
        
        if (!self.inPerson) {
            _birthdateCell.detailTextLabel.text = @"DD/MM/YYYY";
            _birthdateCell.textField.textColor = [UIColor lightGrayColor];
        } else {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"dd/MM/YYYY";
            
            _birthdateCell.detailTextLabel.text = [dateFormatter stringFromDate:self.inPerson.birthDate];
            _birthdateCell.textField.textColor = [UIColor blackColor];
        }
    }
    return _birthdateCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LITInputTableViewCell *cell = [self.cells objectAtIndex:indexPath.row];
    cell.textField.delegate = self;
    
    return cell;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.textColor = [UIColor blackColor];
    textField.text = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)save:(id)sender {
    LITPerson *person = [[LITPerson alloc] init];
    person.name = self.nameCell.textField.text;
    person.male = [self.sexCell.textField.text isEqualToString:@"M"];
    person.height = [self.heightCell.textField.text integerValue];
    person.weight = [self.weightCell.textField.text doubleValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    person.birthDate = [dateFormatter dateFromString:self.birthdateCell.textField.text];
    
    [[LITDataManager sharedInstance] savePerson:person];
    [LITPersonManager sharedInstance].currentPerson = person;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLITPersonUpdatedNotification object:nil];
    
    if (self.isModal) {
        [self.presentingViewController dismissModalViewControllerAnimated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
