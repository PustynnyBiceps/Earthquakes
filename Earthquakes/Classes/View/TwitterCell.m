//
//  EQTweeterCell.m
//  Earthquakes
//
//  Created by Stasiu on 20.10.2014.
//  Copyright (c) 2014 organization. All rights reserved.
//

#import "TwitterCell.h"

@interface TwitterCell()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation TwitterCell

-(void)configureForTweet:(NSDictionary*)tweet
{
    self.tweetTextView.text = tweet[@"text"];
}

@end
