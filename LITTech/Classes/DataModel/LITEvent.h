//
//  LITEvent.h
//  LITTech
//
//  Created by John McLane on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LITEventType) {
    LITEventTypeWorkout = 0,
    LITEventTypeMeal,
    LITEventTypeAlcohol
};

@interface LITEvent : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) LITEventType type;

@end
