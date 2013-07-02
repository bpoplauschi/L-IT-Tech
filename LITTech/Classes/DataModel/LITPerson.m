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

@end
