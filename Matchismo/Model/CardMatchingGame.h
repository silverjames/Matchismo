//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Bernie on 10.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
@property(nonatomic, readonly) int score;
@property(nonatomic,readonly) NSString *status;
@property(nonatomic, readonly, getter = isThreeCardGame) BOOL threeCardGame;

//designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck usingGameType:(NSUInteger)gameType;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@end
