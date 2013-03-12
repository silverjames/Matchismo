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

//designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@end
