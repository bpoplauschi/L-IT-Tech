//
//  LITFirstAidViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/3/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITFirstAidViewController.h"
#import "LITMedicalDictionaryViewController.h"

@interface LITFirstAidViewController ()

@end

@implementation LITFirstAidViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First Aid", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"med_dex.png"];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Med Dex", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(medicalDictAction:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)medicalDictAction:(id)sender {
    LITMedicalDictionaryViewController *medicalDictViewController = [[LITMedicalDictionaryViewController alloc] initWithNibName:@"LITMedicalDictionaryViewController" bundle:nil];
    [self.navigationController pushViewController:medicalDictViewController animated:YES];
}

@end
