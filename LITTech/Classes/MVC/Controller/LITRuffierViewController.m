//
//  LITRuffierViewController.m
//  LITTech
//
//  Created by John McLane on 7/12/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITRuffierViewController.h"
#import "LITInputTableViewCell.h"


@interface LITRuffierViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *cells;

@property (nonatomic, strong) LITInputTableViewCell *pulse1Cell;
@property (nonatomic, strong) LITInputTableViewCell *pulse2Cell;
@property (nonatomic, strong) LITInputTableViewCell *pulse3Cell;

- (void)calculate:(id)sender;

@end


@implementation LITRuffierViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.title = NSLocalizedString(@"Ruffier", @"");
    
    UIBarButtonItem *calculateButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Calculate", @"")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(calculate:)];
    self.navigationItem.rightBarButtonItem = calculateButton;
    self.tableView.allowsSelection = NO;
}

- (void)calculate:(id)sender {
    if ( self.pulse1Cell.textField.text.length && self.pulse2Cell.textField.text.length && self.pulse3Cell.textField.text.length) {
        int index = [self.pulse2Cell.textField.text intValue] - 70 + [self.pulse3Cell.textField.text intValue] - [self.pulse1Cell.textField.text intValue];
        index = index / 10;
        
        NSString *message = @"";
        if (index > 6)
            message = @"Poor index value";
        else if (index > 3)
            message = @"Medium index value";
        else if (index > 0)
            message = @"Good index value";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ruffier index" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing value" message:@"Please enter all 3 pulse measurements" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (NSArray *)cells {
    if (!_cells) {
        _cells = @[self.pulse1Cell, self.pulse2Cell, self.pulse3Cell];
    }
    return _cells;
}

- (LITInputTableViewCell *)pulse1Cell {
    if (!_pulse1Cell) {
        _pulse1Cell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pulse1"];
        _pulse1Cell.textLabel.text = NSLocalizedString(@"Enter pulse value", @"");
		_pulse1Cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        _pulse1Cell.detailTextLabel.text = @"example: 70";
        _pulse1Cell.textField.textColor = [UIColor lightGrayColor];
    }
    return _pulse1Cell;
}

- (LITInputTableViewCell *)pulse2Cell {
    if (!_pulse2Cell) {
        _pulse2Cell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pulse2"];
        _pulse2Cell.textLabel.text = NSLocalizedString(@"Enter pulse value", @"");
		_pulse2Cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        _pulse2Cell.detailTextLabel.text = @"example: 98";
        _pulse2Cell.textField.textColor = [UIColor lightGrayColor];
    }
    return _pulse2Cell;
}

- (LITInputTableViewCell *)pulse3Cell {
    if (!_pulse3Cell) {
        _pulse3Cell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pulse3"];
        _pulse3Cell.textLabel.text = NSLocalizedString(@"Enter pulse value", @"");
		_pulse3Cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        _pulse3Cell.detailTextLabel.text = @"example: 80";
        _pulse3Cell.textField.textColor = [UIColor lightGrayColor];
    }
    return _pulse3Cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return self.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1)
        return 40.0f;
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = nil;
    if (section == 0) {
        view = [[UIView alloc] initWithFrame:CGRectMake(8.0, 0.0, self.view.frame.size.width - 16, 20.0f)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:view.frame];
        title.text = @"Pulse measured in a sitting position";
        title.numberOfLines = 1;
        title.font = [UIFont systemFontOfSize:13];
        title.backgroundColor = [UIColor clearColor];
        [view addSubview:title];
    } else if (section == 1) {
        view = [[UIView alloc] initWithFrame:CGRectMake(8.0, 0.0, self.view.frame.size.width - 16, 40.0f)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:view.frame];
        title.text = @"30 squats are to be performed; in the first 15 seconds, when the person is in outstretched position, the pulse is measured for the second time";
        title.numberOfLines = 3;
        title.font = [UIFont systemFontOfSize:11];
        title.backgroundColor = [UIColor clearColor];
        [view addSubview:title];
    } else if (section == 2) {
        view = [[UIView alloc] initWithFrame:CGRectMake(8.0, 0.0, self.view.frame.size.width - 16, 20.0f)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:view.frame];
        title.text = @"Pulse after 1 minute pause";
        title.numberOfLines = 1;
        title.font = [UIFont systemFontOfSize:13];
        title.backgroundColor = [UIColor clearColor];
        [view addSubview:title];
    }
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LITInputTableViewCell *cell = [self.cells objectAtIndex:indexPath.section];
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


@end
