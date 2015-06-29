//
//  MMXClass.h
//  
//
//  Created by Dong Yiming on 6/29/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MMXLesson;

@interface MMXClass : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *lessons;
@end

@interface MMXClass (CoreDataGeneratedAccessors)

- (void)insertObject:(MMXLesson *)value inLessonsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLessonsAtIndex:(NSUInteger)idx;
- (void)insertLessons:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLessonsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLessonsAtIndex:(NSUInteger)idx withObject:(MMXLesson *)value;
- (void)replaceLessonsAtIndexes:(NSIndexSet *)indexes withLessons:(NSArray *)values;
- (void)addLessonsObject:(MMXLesson *)value;
- (void)removeLessonsObject:(MMXLesson *)value;
- (void)addLessons:(NSOrderedSet *)values;
- (void)removeLessons:(NSOrderedSet *)values;
@end
