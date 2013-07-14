//
//  LITEditPersonViewController.h
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITBaseViewController.h"

@class LITPerson;

@interface LITEditPersonViewController : LITBaseViewController

@property (nonatomic, assign, getter = isModal) BOOL modal;
@property (nonatomic, strong) LITPerson *inPerson;

@end
