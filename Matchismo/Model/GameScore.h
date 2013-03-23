//
//  GameScore.h
//  Matchismo
//
//  Created by Bernie on 17.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameScore : NSObject
@property (strong, nonatomic) NSDate *start;
@property (strong, nonatomic) NSDate *end;
@property  (strong, nonatomic) NSNumber *score;

-(NSArray *) getScoreAsPropertyList;
@end
