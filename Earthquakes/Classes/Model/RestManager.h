//
//  RestManager.h
//  Earthquakes
//
//  Created by Stasiu on 19.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>

@interface RestManager : NSObject

@property (nonatomic) RKManagedObjectStore* managedObjectStore;

+(RestManager*)sharedInstance;
-(void)getEarthquakesWithResultBlock:(void(^)(NSArray*,NSError*))resultBlock;

@end
