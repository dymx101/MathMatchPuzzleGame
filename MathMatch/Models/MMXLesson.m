//
//  MMXLesson.m
//  
//
//  Created by Dong Yiming on 6/29/15.
//
//

#import "MMXLesson.h"
#import "MMXClass.h"


@implementation MMXLesson

@dynamic arithmeticType;
@dynamic lessonID;
@dynamic musicTrackType;
@dynamic numberOfCards;
@dynamic penaltyMultiplier;
@dynamic starTimes;
@dynamic startingPositionType;
@dynamic targetNumber;
@dynamic title;
@dynamic fromClass;

-(NSString *)description {
    return [NSString stringWithFormat:@"[MMXLesson] - lessonID:%@, arithmeticType:%@, musicTrackType:%@, numberOfCards:%@, penaltyMultiplier:%@, starTimes:%@, startingPositionType:%@, targetNumber:%@, title:%@", self.lessonID, self.arithmeticType, self.musicTrackType, self.numberOfCards, self.penaltyMultiplier, self.starTimes, self.startingPositionType, self.targetNumber, self.title];
}

@end
