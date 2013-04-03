//
//  GameScore.m
//  Matchismo
//
//  Created by Bernie on 17.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "GameScore.h"
#define CARD_GAME_KEY @"cardgame_key"
#define START_KEY @"start"
#define DURATION_KEY @"duration"
#define SCORE_KEY @"score"
#define GAME_KEY @"game_key"

#define GAME_TYPE_MATCH 0
#define GAME_TYPE_SET 1

@interface GameScore()

@end

@implementation GameScore

+(NSArray *) allGameResultsSorted:(NSArray *)descriptor{
    //get all existing game score objects into this new array
    NSMutableArray *allGames = [[NSMutableArray alloc]initWithArray:[self allGameResults ]];
    
    NSArray *allGamesSorted = [allGames sortedArrayUsingDescriptors:descriptor];
    
    return allGamesSorted;
}

+(NSArray *) allGameResults{
    NSMutableArray *allGameResults = [[NSMutableArray alloc]init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:CARD_GAME_KEY]allValues]){
        GameScore *result = [[GameScore alloc]initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    return allGameResults;
}

//convenience initializer
-(id) initFromPropertyList:(id)plist{
    self = [self init];
    if (self){
        NSDictionary *results = (NSDictionary *) plist;
        self.start = results[START_KEY];
        self.duration = [results[DURATION_KEY] doubleValue];
        self.score = [results[SCORE_KEY] intValue];
        self.gameType = [results[GAME_KEY]intValue];
        if (!self.start || !self.duration) {
            self = nil;
        }
    }
    return self;
}

//designated initializer
-(GameScore *)init{
    //init  class and properties
    self = [super init];
    if (self){
        self.start = [NSDate date];
        self.duration = 0;
        self.score = 0;
        self.gameType = GAME_TYPE_MATCH;
    }
   return self;
}

//store the score, keyed by start date and sync the user defaults
-(void) synchronize{
    self.duration = [[NSDate date] timeIntervalSinceDate:self.start];
    NSMutableDictionary *cardGameScores = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:CARD_GAME_KEY] mutableCopy];

    if (!cardGameScores) cardGameScores = [[NSMutableDictionary alloc]init];
    
    cardGameScores[self.start.description] = [self asPropertyList];
    
    [[NSUserDefaults standardUserDefaults] setObject:cardGameScores forKey:CARD_GAME_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//empties the score store in user defaults
+(void) resetAllScores{
    
    NSMutableDictionary *cardGameScores = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:CARD_GAME_KEY] mutableCopy];
    
    if (!cardGameScores) cardGameScores = [[NSMutableDictionary alloc]init];
    
    [cardGameScores removeAllObjects];
    
    [[NSUserDefaults standardUserDefaults] setObject:cardGameScores forKey:CARD_GAME_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//return self as a property list
-(id)asPropertyList{
    return @{ START_KEY:self.start, DURATION_KEY:@(self.duration), SCORE_KEY:@(self.score), GAME_KEY:@(self.gameType)};
}

@end
