//
//  EQEarthquakeCell.m
//  Earthquakes
//
//  Created by Stasiu on 20.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "EarthquakeCell.h"
#import "Earthquake+ext.h"

@interface EarthquakeCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *magnitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation EarthquakeCell

-(void)configureForEarthquake:(Earthquake*)earthquake
{
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = earthquake.color;
    
    self.titleLabel.text = earthquake.place;
    self.magnitudeLabel.text = [earthquake.magnitude stringValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    self.timeLabel.text = [formatter stringFromDate:earthquake.time];
}

@end
