//
//  LITBaseViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 6/25/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITBaseViewController.h"


@interface LITBaseViewController ()

@end


@implementation LITBaseViewController

#pragma mark -
#pragma mark View Controller Rotation Methods (iOS6 and later)

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark -
#pragma mark View Controller Rotation Methods (iOS5 and earlier)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    BOOL ret = (toInterfaceOrientation == UIInterfaceOrientationPortrait);    
    return ret;
}

@end
