//
//  LITPerson.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPerson.h"
#import "LITEvent.h"
#import "LITDataManager.h"
#import "LITConstants.h"

@implementation LITPerson

- (id)init {
    self = [super init];
    if (self) {
        _events = [NSMutableArray array];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.male = [aDecoder decodeBoolForKey:@"male"];
        self.height = [aDecoder decodeIntegerForKey:@"height"];
        self.weight = [aDecoder decodeDoubleForKey:@"weight"];
        self.birthDate = [aDecoder decodeObjectForKey:@"birthDate"];
        self.events = [NSMutableArray arrayWithArray:[aDecoder decodeObjectForKey:@"events"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeBool:self.isMale forKey:@"male"];
    [aCoder encodeInteger:self.height forKey:@"height"];
    [aCoder encodeDouble:self.weight forKey:@"weight"];
    [aCoder encodeObject:self.birthDate forKey:@"birthDate"];
    [aCoder encodeObject:self.events forKey:@"events"];
}

- (double)imc {
    double imc = 0.0f;
    if (self.height) {
        imc = self.weight * 100 * 100 / (self.height * self.height);
    }
    return imc;
}

- (double)idealWeightNormal {
    return (self.height - 100 + ([self yearsOld] / 10)) * 0.9;
}

- (double)idealWeightSlender {
    return (self.height - 100 + ([self yearsOld] / 10)) * 0.9 * 0.9;
}

- (double)idealWeightRobust {
    return (self.height - 100 + ([self yearsOld] / 10)) * 0.9 * 1.1;
}

- (int)yearsOld {
    NSInteger years = 0;
    if (self.birthDate) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self.birthDate toDate:[NSDate date] options:0];
        years = components.year;
    }
    return years;
}

- (double)bmr {
    double bmr = 0.0f;
    if (self.isMale) {
        bmr = (13.75 * self.weight + 5 * self.height - 6.76 * [self yearsOld] + 66) / 24;
    } else {
        bmr = (9.56 * self.weight + 1.85 * self.height - 4.68 * [self yearsOld] + 655) / 24;
    }
    return bmr;
}

- (void)addWorkoutEventWithInfo:(NSString *)inInfo {
    LITEvent *event = [[LITEvent alloc] init];
    event.date = [NSDate date];
    event.info = inInfo;
    event.type = LITEventTypeWorkout;
    [self.events addObject:event];
    
    [[LITDataManager sharedInstance] savePerson:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLITPersonUpdatedNotification object:nil];
}

- (void)addMealEventWithInfo:(NSString *)inInfo {
    LITEvent *event = [[LITEvent alloc] init];
    event.date = [NSDate date];
    event.info = inInfo;
    event.type = LITEventTypeMeal;
    [self.events addObject:event];
    
    [[LITDataManager sharedInstance] savePerson:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLITPersonUpdatedNotification object:nil];
}

@end
