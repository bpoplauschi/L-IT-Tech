//
//  LITDataManager.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITDataManager.h"
#import "LITPerson.h"

@implementation LITDataManager

+ (LITDataManager *)sharedInstance {
    static LITDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LITDataManager alloc] init];
    });
    return instance;
}

- (void)savePerson:(LITPerson *)inPerson {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *decodedPersons = [NSMutableArray arrayWithArray:[self loadPersons]];
    int index = -1;
    for (int i=0; i<decodedPersons.count; i++) {
        LITPerson *aPerson = [decodedPersons objectAtIndex:i];
        if ([aPerson.name isEqualToString:inPerson.name]) {
            index = i;
            break;
        }
    }
    if (index != -1) {
        [decodedPersons replaceObjectAtIndex:index withObject:inPerson];
    } else {
        [decodedPersons addObject:inPerson];
    }
    
    NSMutableArray *encodedPersons = [NSMutableArray array];
    for (LITPerson *aPerson in decodedPersons) {
        [encodedPersons addObject:[NSKeyedArchiver archivedDataWithRootObject:aPerson]];
    }
    
    [prefs setObject:encodedPersons forKey:@"persons"];
    [prefs synchronize];
}

- (NSArray *)loadPersons {
    NSMutableArray *persons = [NSMutableArray array];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for (NSData *encodedPerson in [prefs arrayForKey:@"persons"]) {
        LITPerson *aPerson = (LITPerson *)[NSKeyedUnarchiver unarchiveObjectWithData:encodedPerson];
        [persons addObject:aPerson];
    }
    return [persons copy];
}

@end
