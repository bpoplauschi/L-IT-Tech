//
//  LITMedicalDictionaryViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/1/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITMedicalDictionaryViewController.h"

@interface LITMedicalDictionaryViewController ()

@end

@implementation LITMedicalDictionaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"MEDICAL DICT", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"med_dex.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
