//
//  LITEvent.m
//  LITTech
//
//  Created by John McLane on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITEvent.h"

@implementation LITEvent

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeInteger:self.type forKey:@"type"];
}


@end
