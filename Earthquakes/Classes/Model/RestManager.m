//
//  RestManager.m
//  Earthquakes
//
//  Created by Stasiu on 19.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "RestManager.h"
#import "Earthquake+ext.h"
#import "CoreDataManager.h"

@interface RestManager ()

@property (nonatomic) RKObjectManager* objectManager;

@end

@implementation RestManager

+ (RestManager*)sharedInstance
{
    static RestManager *restManager = nil;
    if (!restManager)
    {
        restManager = [[RestManager alloc]init];
        [RKManagedObjectStore setDefaultStore:restManager.managedObjectStore];
        [RKObjectManager setSharedManager:restManager.objectManager];
    }
    return restManager;
}

-(RKManagedObjectStore *)managedObjectStore
{
    if (_managedObjectStore == nil)
    {
        NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Earthquakes" ofType:@"momd"]];
        NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] ;
        _managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
        
        [_managedObjectStore createPersistentStoreCoordinator];
        
        [_managedObjectStore addSQLitePersistentStoreAtPath:[RKApplicationDataDirectory() stringByAppendingPathComponent:@"earthquakes.sqlite"] fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:nil];
        
        [_managedObjectStore createManagedObjectContexts];
    }
    return _managedObjectStore;
}

-(RKObjectManager *)objectManager
{
    if (_objectManager == nil)
    {
        RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://earthquake.usgs.gov"]];
        objectManager.managedObjectStore = self.managedObjectStore;
        
        RKResponseDescriptor * responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[Earthquake mapping] method:RKRequestMethodGET pathPattern:@"/earthquakes/feed/v1.0/summary/2.5_week.geojson"  keyPath:@"features" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
        
        [objectManager addResponseDescriptor:responseDescriptor];
        _objectManager = objectManager;
    }
    return _objectManager;
}

-(void)getEarthquakesWithResultBlock:(void(^)(NSArray*,NSError*))resultBlock
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/earthquakes/feed/v1.0/summary/2.5_week.geojson" parameters:nil success:
     ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
         [[RestManager sharedInstance].managedObjectStore.mainQueueManagedObjectContext saveToPersistentStore:nil];
         resultBlock(mappingResult.array, nil);
     }
        failure:^(RKObjectRequestOperation *operation, NSError *error) {
            resultBlock(nil, error);
     }];
}

@end
