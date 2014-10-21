//
//  Coordinates.h
//  Earthquakes
//
//  Created by Stasiu on 21.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Earthquake;

@interface Coordinates : NSManagedObject

@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) Earthquake *earthquake;

@end
