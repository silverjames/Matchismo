//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Bernie on 10.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "GameScore.h"

@interface CardMatchingGame : NSObject
@property(nonatomic,readonly) GameScore *trackScore;
@property(nonatomic,readonly) NSString *status;
@property (nonatomic, readwrite) int matchType; //0 = 2-card match, 1 = 3-card match

//designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck usingType:(NSUInteger) idx;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@end
