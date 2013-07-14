//
//  LITPulseCalculatorViewController.m
//  LITTech
//
//  Created by John McLane on 7/12/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPulseCalculatorViewController.h"
#import "LITInputTableViewCell.h"
#import "LITPersonManager.h"
#import "LITPerson.h"

@interface LITPulseCalculatorViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) LITInputTableViewCell *pulseCell;

- (void)calculate:(id)sender;

@end


@implementation LITPulseCalculatorViewController

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
    self.navigationItem.title = NSLocalizedString(@"Heart Rate", @"");
    
    UIBarButtonItem *calculateButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Calculate", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(calculate:)];
    self.navigationItem.rightBarButtonItem = calculateButton;
    self.tableView.allowsSelection = NO;
}

- (void)calculate:(id)sender {
    if (self.pulseCell.textField.text.length) {
        int pulse = [self.pulseCell.textField.text intValue] * 6;
        
        [[LITPersonManager sharedInstance].currentPerson addHeartRateEventWithInfo:[NSString stringWithFormat:@"%d bpm", pulse]];
        
        NSString *message = @"";
        if (pulse > 90)
            message = @"You have a heart rate greater than 90 beats per minute and are diagnosed with Tachycardia";
        else if (pulse > 60)
            message = @"You have a good heart rate";
        else if (pulse > 0)
            message = @"You have a heart rate less than 60 beats per minute and are diagnosed with bradycardia";
        else
            message = @"Wrong value";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Heart rate" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing value" message:@"Please enter the measurement " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (LITInputTableViewCell *)pulseCell {
    if (!_pulseCell) {
        _pulseCell = [[LITInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pulse1"];
        _pulseCell.textLabel.text = NSLocalizedString(@"Enter heart rate", @"");
		_pulseCell.textField.keyboardType = UIKeyboardTypeNumberPad;
        _pulseCell.detailTextLabel.text = @"example: 12";
        _pulseCell.textField.textColor = [UIColor lightGrayColor];
    }
    return _pulseCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 160.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = nil;
    view = [[UIView alloc] initWithFrame:CGRectMake(8.0, 0.0, self.view.frame.size.width - 16, 160.0f)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:view.frame];
    title.text = @"Set your index finger, middle finger and ring one on your hand joint, under the palm, at the basis of the thumb.\nAnother method implies putting the top of the index and middle finger on the trachea.\nPress easily with your fingers until you feel your blood is pulsing under the fingers.\nIt is possible the need of movement of the fingers up or down to discover the area in which the pulse is stronger.\nUse a stopwatch or a watch with a second hand.\nCount how many heart beats are totalized in 10 seconds";
    title.numberOfLines = 11;
    title.font = [UIFont systemFontOfSize:12];
    title.backgroundColor = [UIColor clearColor];
    [view addSubview:title];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LITInputTableViewCell *cell = self.pulseCell;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
