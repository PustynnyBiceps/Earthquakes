//
//  Earthquake.h
//  Earthquakes
//
//  Created by Stasiu on 21.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Coordinates;

@interface Earthquake : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * magnitude;
@property (nonatomic, retain) NSString * magnitudeType;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSNumber * timestamp;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * tsunami;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSOrderedSet *coordinates;
@end

@interface Earthquake (CoreDataGeneratedAccessors)

- (void)insertObject:(Coordinates *)value inCoordinatesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCoordinatesAtIndex:(NSUInteger)idx;
- (void)insertCoordinates:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCoordinatesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCoordinatesAtIndex:(NSUInteger)idx withObject:(Coordinates *)value;
- (void)replaceCoordinatesAtIndexes:(NSIndexSet *)indexes withCoordinates:(NSArray *)values;
- (void)addCoordinatesObject:(Coordinates *)value;
- (void)removeCoordinatesObject:(Coordinates *)value;
- (void)addCoordinates:(NSOrderedSet *)values;
- (void)removeCoordinates:(NSOrderedSet *)values;
@end
