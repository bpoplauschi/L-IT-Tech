//
//  LITPersonManager.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPersonManager.h"
#import "LITPerson.h"

@implementation LITPersonManager

+ (LITPersonManager *)sharedInstance {
    static LITPersonManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LITPersonManager alloc] init];
    });
    return instance;
}

@end
