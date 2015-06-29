//
//  MMXDataManager.m
//  MathMatch
//
//  Created by Dong Yiming on 6/29/15.
//  Copyright (c) 2015 Computer Lab. All rights reserved.
//

#import "MMXDataManager.h"
#import "MMXClass.h"
#import "MMXLesson.h"

#define HAS_FILLED_DATABASE   @"HAS_FILLED_DATABASE"

@implementation MMXDataManager

+(void)initDataBase {
    
#warning TEST!!!
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:HAS_FILLED_DATABASE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:HAS_FILLED_DATABASE]) {
        
        [self fillDataBase];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HAS_FILLED_DATABASE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(void)fillDataBase {
    
    MMXClass *class = [MMXClass MR_createEntity];
    class.title = @"Addition";
    
    NSInteger lessonCount = 10;
    NSMutableOrderedSet *lessons = [[NSMutableOrderedSet alloc] initWithCapacity:lessonCount];
    NSInteger lessonID = 100;
    NSInteger targetNumber = 10;
    NSInteger numberOfCards = 12;
    NSInteger penaltyMultiplier = 4;
    
    EMMXArithmeticType arithmeticType = kMMXArithmeticAddition;
    EMMXStartingPositionType startingPositionType = kMMXStartingPositionFaceUp;
    EMMXDifficulty musicTrackType = kMMXDifficultyEasy;
    NSInteger starTimeBase = 8;
    
    for (NSInteger i = 0; i < lessonCount; i++) {
        MMXLesson *lesson = [MMXLesson MR_createEntity];
        lesson.lessonID = @(lessonID + i);
        lesson.targetNumber = @(targetNumber + i);
        lesson.title = [NSString stringWithFormat:@"Add to %@", lesson.targetNumber];
        lesson.numberOfCards = @(numberOfCards + i / 4 * 4);
        lesson.arithmeticType = @(arithmeticType);
        lesson.startingPositionType = @(startingPositionType);
        lesson.penaltyMultiplier = @(penaltyMultiplier);
        
        NSInteger starTime = starTimeBase * (1 + (lesson.targetNumber.floatValue / 100)) * (1 + (lesson.numberOfCards.floatValue / 40));
        lesson.starTimes = @[@(starTime * 2), @(starTime)];
        lesson.musicTrackType = @(musicTrackType);
        
        [lessons addObject:lesson];
    }
    
    class.lessons = lessons.copy;
    NSLog(@"lessons:\n %@", lessons);
    
}

@end
