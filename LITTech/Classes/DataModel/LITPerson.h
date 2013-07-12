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
@property (nonatomic, strong) NSMutableArray *events;

- (double)imc;

- (double)idealWeightNormal;
- (double)idealWeightSlender;
- (double)idealWeightRobust;

- (int)yearsOld;

- (double)bmr; // per 24 hours

- (void)addWorkoutEventWithInfo:(NSString *)inInfo;
- (void)addMealEventWithInfo:(NSString *)inInfo;
- (void)addAlcholEventWithInfo:(NSString *)inInfo;
- (void)addHeartRateEventWithInfo:(NSString *)inInfo;

@end
