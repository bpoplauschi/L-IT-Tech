//
//  LITPersonManager.h
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LITPerson;


@interface LITPersonManager : NSObject

@property (nonatomic, strong) LITPerson *currentPerson;

+ (LITPersonManager *)sharedInstance;
- (NSArray *)persons;
- (void)selectPersonAtIndex:(int)index;

@end
