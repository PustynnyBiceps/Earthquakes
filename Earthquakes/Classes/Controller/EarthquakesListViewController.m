//
//  EQEarthquakesViewController.m
//  Earthquakes
//
//  Created by Stasiu on 20.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "EarthquakesListViewController.h"
#import "RestManager.h"
#import "CoreDataManager.h"
#import "EarthquakeCell.h"
#import "Earthquake.h"
#import "Coordinates.h"
#import "EarthquakesMapViewController.h"

@interface EarthquakesListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray* earthquakesData;
@property (nonatomic) IBOutlet UITableView* earthquakesTableView;
@property (nonatomic) IBOutlet UISegmentedControl* tsunamiSegmentedControl;

@end

@implementation EarthquakesListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateViews];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.earthquakesTableView addSubview:refreshControl];
    
    [refreshControl beginRefreshing];
    [self refresh:refreshControl];
    self.earthquakesTableView.contentOffset = CGPointMake(0, -refreshControl.frame.size.height);
}

- (void)updateViews
{
    if (self.tsunamiSegmentedControl.selectedSegmentIndex==0)
        self.earthquakesData = [[CoreDataManager sharedInstance]fetchEarthquakes];
    else
        self.earthquakesData = [[CoreDataManager sharedInstance]fetchEarthquakesWithTsunami:YES];
    [self.earthquakesTableView reloadData];
}

#pragma mark - User Events

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [[RestManager sharedInstance] getEarthquakesWithResultBlock:^(NSArray*result, NSError*error)
     {
         if (!error)
         {
             [self updateViews];
         }
         else
         {
             UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Connection error" message:@"Application couldn't load earthquakes data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [alertView show];
         }
         [refreshControl endRefreshing];
     }];
}

- (IBAction)tsunamiSegmentedControlValueChanged:(UISegmentedControl*)sender
{
    [self updateViews];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.earthquakesData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EarthquakeCell* cell = (EarthquakeCell*)[tableView dequeueReusableCellWithIdentifier:@"earthquake"];
    [cell configureForEarthquake:self.earthquakesData[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EarthquakesMapViewController* vc = [[UIStoryboard storyboardWithName:@"EarthquakesMap" bundle:nil]instantiateInitialViewController];
    Earthquake* earthquake = self.earthquakesData[indexPath.row];
    vc.longitude = [((Coordinates*)earthquake.coordinates[0]).value doubleValue];
    vc.latitude = [((Coordinates*)earthquake.coordinates[1]).value doubleValue];
    vc.radius = [((Coordinates*)earthquake.coordinates[2]).value intValue];
    
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
