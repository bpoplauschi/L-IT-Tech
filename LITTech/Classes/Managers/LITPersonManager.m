//
//  LITPersonManager.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPersonManager.h"
#import "LITPerson.h"
#import "LITDataManager.h"
#import "LITConstants.h"

@implementation LITPersonManager

+ (LITPersonManager *)sharedInstance {
    static LITPersonManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LITPersonManager alloc] init];
    });
    return instance;
}

- (LITPerson *)currentPerson {
    if (!_currentPerson) {
        NSArray *persons = [[LITDataManager sharedInstance] loadPersons];
        if (persons.count) {
            _currentPerson = [persons objectAtIndex:0];
        }
    }
    return _currentPerson;
}

- (NSArray *)persons {
    return [[LITDataManager sharedInstance] loadPersons];
}

- (void)selectPersonAtIndex:(int)index {
    NSArray *persons = [[LITDataManager sharedInstance] loadPersons];
    if (persons.count && index < persons.count && index >= 0) {
        self.currentPerson = [persons objectAtIndex:index];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kLITPersonUpdatedNotification object:nil];
}

- (void)deletePersonAtIndex:(int)index {
    NSMutableArray *persons = [NSMutableArray arrayWithArray:[[LITDataManager sharedInstance] loadPersons]];
    if (persons.count && index < persons.count && index >= 0) {
        [persons removeObjectAtIndex:index];
    }
    // TODO
}

@end
