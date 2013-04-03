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
@property (nonatomic) double duration;
@property  (nonatomic) int score;
@property  (nonatomic)int gameType;

+(NSArray *) allGameResults;
+(NSArray *) allGameResultsSorted:descriptor;
+(void)resetAllScores;
-(GameScore *) init;
-(void)synchronize; //...with user defaults
@end
