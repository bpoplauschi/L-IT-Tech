//
//  LITPerson.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPerson.h"

@implementation LITPerson

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.male = [aDecoder decodeBoolForKey:@"male"];
        self.height = [aDecoder decodeIntegerForKey:@"height"];
        self.weight = [aDecoder decodeDoubleForKey:@"weight"];
        self.birthDate = [aDecoder decodeObjectForKey:@"birthDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeBool:self.isMale forKey:@"male"];
    [aCoder encodeInteger:self.height forKey:@"height"];
    [aCoder encodeDouble:self.weight forKey:@"weight"];
    [aCoder encodeObject:self.birthDate forKey:@"birthDate"];
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

@end
