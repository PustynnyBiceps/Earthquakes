//
//  EQCoreData.h
//  Earthquakes
//
//  Created by Stasiu on 20.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

+ (CoreDataManager*)sharedInstance;
- (NSArray*)fetchEarthquakes;
- (NSArray*)fetchEarthquakesWithTsunami:(bool)tsunami;

@end
