//
//  EQCoreData.m
//  Earthquakes
//
//  Created by Stasiu on 20.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "CoreDataManager.h"
#import "RestManager.h"

@interface CoreDataManager ()

@property (nonatomic) NSManagedObjectContext* managedObjectContext;

@end

@implementation CoreDataManager

-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil)
    {
        _managedObjectContext = [RestManager sharedInstance].managedObjectStore.mainQueueManagedObjectContext;
    }
    return _managedObjectContext;
}

+ (CoreDataManager*)sharedInstance
{
    static CoreDataManager *coreData = nil;
    if (!coreData)
    {
        coreData = [[CoreDataManager alloc]init];
    }
    return coreData;
}

-(NSArray *)fetchEarthquakes
{
    return [self fetchEarthquakesWithTsunami:NO];
}

- (NSArray*)fetchEarthquakesWithTsunami:(bool)tsunami
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Earthquake" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"magnitude" ascending:NO]]];
    if (tsunami)
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"tsunami = YES"];
    fetchRequest.fetchLimit = 20;
    
    NSArray* result = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return result;
}


@end
