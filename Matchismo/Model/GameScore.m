//
//  GameScore.m
//  Matchismo
//
//  Created by Bernie on 17.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "GameScore.h"

@implementation GameScore

-(GameScore *)init{
    self = [super init];
    self.start = [NSDate date];
    self.score = [NSNumber numberWithInt:0];
    return self;
}

//returns self as a property list
-(NSArray *)getScoreAsPropertyList{
    return [NSArray arrayWithObjects: self.start.description, [NSNumber numberWithDouble:[self.end timeIntervalSinceDate:self.start]], self.score, nil];
}

@end
