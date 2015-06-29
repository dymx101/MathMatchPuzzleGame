//
//  MMXLesson.h
//  
//
//  Created by Dong Yiming on 6/29/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSInteger, EMMXArithmeticType) {
    kMMXArithmeticAddition = 0
    , kMMXArithmeticSubtraction
    , kMMXArithmeticMultiplication
    , kMMXArithmeticDivision
};

typedef NS_ENUM(NSInteger, EMMXStartingPositionType) {
    kMMXStartingPositionFaceUp = 0
    , kMMXStartingPositionFaceDown
};

typedef NS_ENUM(NSInteger, EMMXDifficulty) {
    kMMXDifficultyEasy = 0
    , kMMXDifficultyMedium
    , kMMXDifficultyHard
};

@class MMXClass;

@interface MMXLesson : NSManagedObject

@property (nonatomic, retain) NSNumber * arithmeticType;
@property (nonatomic, retain) NSNumber * lessonID;
@property (nonatomic, retain) NSNumber * musicTrackType;
@property (nonatomic, retain) NSNumber * numberOfCards;
@property (nonatomic, retain) NSNumber * penaltyMultiplier;
@property (nonatomic, retain) id starTimes;
@property (nonatomic, retain) NSNumber * startingPositionType;
@property (nonatomic, retain) NSNumber * targetNumber;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) MMXClass *fromClass;

@end
