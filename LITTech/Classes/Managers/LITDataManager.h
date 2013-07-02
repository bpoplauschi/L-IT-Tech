//
//  LITDataManager.h
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LITPerson;

@interface LITDataManager : NSObject

+ (LITDataManager *)sharedInstance;
- (void)savePerson:(LITPerson *)inPerson;
- (NSArray *)loadPersons;

@end
