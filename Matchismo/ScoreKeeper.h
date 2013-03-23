//
//  ScoreKeeper.h
//  Matchismo
//
//  Model helper class - reads/writes game results from user preferences
//  Created by Bernie on 17.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScore.h"

@interface ScoreKeeper : NSObject
@property (strong, nonatomic) NSMutableDictionary *cardGameScores;

-(id)init;
-(void) writeResults: (GameScore *) score;
-(void) synchronize;

@end
