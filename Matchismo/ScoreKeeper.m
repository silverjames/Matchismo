//
//  ScoreKeeper.m
//  Matchismo
//
//  Created by Bernie on 17.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "ScoreKeeper.h"
#define CARD_GAME_KEY @"cardgamekey"

@interface ScoreKeeper();
@property (strong, nonatomic) NSUserDefaults *userDefaults;

@end

@implementation ScoreKeeper

//get the current score and store it, keyed by start date
-(void) writeResults:(GameScore *)score{
    score.end = [NSDate date];
    [self.cardGameScores setObject:[score getScoreAsPropertyList] forKey:score.start.description];
    
    NSLog(@"SK:writeResults:stored score :%@/%@/%@", score.start, score.end, score.score);
    NSLog(@"SK:writeResults:total scores stored: %d", [self.cardGameScores count]);
    [self.userDefaults setObject:self.cardGameScores forKey:CARD_GAME_KEY];
    [self.userDefaults synchronize];
}
//setters
-(NSUserDefaults *) userDefaults {
    if (!_userDefaults) _userDefaults = [NSUserDefaults standardUserDefaults];
    return _userDefaults;
}

-(NSMutableDictionary *)cardGameScores {
    if (!_cardGameScores) _cardGameScores = [[NSMutableDictionary alloc]init];
    return _cardGameScores;
}

-(void)synchronize {

    self.cardGameScores = [[self.userDefaults objectForKey:CARD_GAME_KEY] mutableCopy];
    NSLog(@"SK:synchronize: cardGameScores loaded from user defaults: %d scores", [self.cardGameScores count]);

}
//designated initializer
-(id) init {
    self = [super init];
    //get existing game scores, or create the user defaults entry
    if ([self.userDefaults dictionaryForKey:CARD_GAME_KEY] == Nil) {
        [self.userDefaults setObject:self.cardGameScores forKey:CARD_GAME_KEY];
        NSLog(@"SK:init: cardGameScores initialized in user defaults");
    } else {
        [self synchronize];
    }
        return self;
}

@end
