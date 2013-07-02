//
//  LITPerson.h
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LITPerson : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign, getter = isMale) BOOL male;   // true for males, false for females
@property (nonatomic, assign) NSUInteger height;            // in centimeters
@property (nonatomic, assign) double weight;                // in kilograms
@property (nonatomic, strong) NSDate *birthDate;

@end
