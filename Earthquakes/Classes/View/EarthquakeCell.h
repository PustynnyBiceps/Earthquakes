//
//  EQEarthquakeCell.h
//  Earthquakes
//
//  Created by Stasiu on 20.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Earthquake;

@interface EarthquakeCell : UITableViewCell

-(void)configureForEarthquake:(Earthquake*)earthquake;

@end
