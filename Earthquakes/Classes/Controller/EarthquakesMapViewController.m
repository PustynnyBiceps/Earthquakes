//
//  EQTwitterTableViewController.m
//  Earthquakes
//
//  Created by Stasiu on 20.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "EarthquakesMapViewController.h"
#import <STTwitter/STTwitter.h>
#import <MapKit/MapKit.h>
#import "TwitterCell.h"

@interface EarthquakesMapViewController () <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *twitterTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *twitterActivityIndicator;

@property (nonatomic) NSArray* twitterData;

@end

@implementation EarthquakesMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
    [self.mapView addAnnotation:annotation];
    
    [self loadTwitterData];
}

- (void)loadTwitterData
{
    STTwitterAPI* twitterAPI = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"fElZ9pi6QvBFgIhfTvLTpXNJq" consumerSecret:@"WECkh2zcoEdbuVDgTIIe91ewSdE1R9QgeebHBO2hiRvTfLhNyJ"];
    
    NSString* geocode = [NSString stringWithFormat:@"%@,%@,%@km",@(self.latitude),@(self.longitude),@(self.radius)];
    NSString* count = @"20";
    [twitterAPI verifyCredentialsWithSuccessBlock:^(NSString *username) {
        [twitterAPI getSearchTweetsWithQuery:@"earthquakes" geocode:geocode lang:nil locale:nil resultType:nil count:count until:nil sinceID:nil maxID:nil includeEntities:nil callback:nil successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            self.twitterData = statuses;
            [self.twitterTableView reloadData];
            [self.twitterActivityIndicator stopAnimating];
        } errorBlock:^(NSError *error) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Connection error" message:@"Applications couldn't load twitter data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            [self.twitterActivityIndicator stopAnimating];
        }];
    } errorBlock:^(NSError *error) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Connection error" message:@"Application couldn't connect with twitter" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        [self.twitterActivityIndicator stopAnimating];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMake(CLLocationCoordinate2DMake(self.latitude, self.longitude), MKCoordinateSpanMake(5, 5))];
    [self.mapView setRegion:adjustedRegion];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.twitterData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"twitter";
    TwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell configureForTweet:self.twitterData[indexPath.row]];
    
    return cell;
}

@end
