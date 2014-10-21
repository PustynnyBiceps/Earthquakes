//
//  Earthquake+ext.m
//  Earthquakes
//
//  Created by Stasiu on 19.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "Earthquake+ext.h"
#import "RestManager.h"

@implementation Earthquake (ext)

+(RKEntityMapping*)mapping
{
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"Earthquake" inManagedObjectStore:[RestManager sharedInstance].managedObjectStore];
    [mapping addAttributeMappingsFromDictionary:@{
     @"id": @"id",
     @"properties.place": @"place",
     @"properties.time": @"timestamp",
     @"properties.title": @"title",
     @"properties.tsunami" : @"tsunami",
     @"properties.mag" : @"magnitude",
     @"properties.magType" : @"magnitudeType",
     }];
    mapping.identificationAttributes=@[@"id"];
    
    RKEntityMapping *categoryMapping = [RKEntityMapping mappingForEntityForName:@"Coordinate" inManagedObjectStore:[RestManager sharedInstance].managedObjectStore];
    [categoryMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"value"]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"geometry.coordinates" toKeyPath:@"coordinates" withMapping:categoryMapping]];
    return mapping;
}

-(UIColor*)color
{
    float pinkHue = 0.86;
    float magnitudeHue = pinkHue - ([self.magnitude floatValue]/7.0)*pinkHue;
    return [UIColor colorWithHue:magnitudeHue saturation:1 brightness:1 alpha:1];
}

-(NSDate *)time
{
    return [NSDate dateWithTimeIntervalSince1970:[self.timestamp longLongValue]/1000
            ];
}

@end
