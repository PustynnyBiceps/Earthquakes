//
//  Earthquake+ext.h
//  Earthquakes
//
//  Created by Stasiu on 19.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "Earthquake.h"

@class RKEntityMapping;

@interface Earthquake (ext)

@property (nonatomic, readonly) UIColor* color;
@property (nonatomic, readonly) NSDate* time;

+(RKEntityMapping*)mapping;

@end
