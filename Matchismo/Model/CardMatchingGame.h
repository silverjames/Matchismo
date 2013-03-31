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
@property(nonatomic,readonly) NSString *status;
@property(nonatomic, readonly) int score;
@property (nonatomic, readwrite) int matchType; //0 = 2-card match, 1 = set game
@property (strong, nonatomic) NSMutableArray *cards;


//designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck usingType:(NSUInteger)idx;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@end
