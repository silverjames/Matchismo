//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Bernie on 10.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation CardMatchingGame

//setter
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

//initializer
-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self){
        for (NSUInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card){
                self = nil;
            } else {
                card.faceUp = NO;
                self.cards[i] = card;
                NSLog(@"GameModel:init:random card: %d - %@", i, card.contents  );
            }
        }//end for
    }//end if
    return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSLog(@"gameModel:flipCardAtIndex:card: %@", card.contents);
    if (!card.isUnplayable) {//if the card is playable
        NSLog(@"gameModel:flipCardAtIndex: card is playable");
        if (!card.isFaceUp) {//and faceup, we can match
            NSLog(@"gameModel:flipCardAtIndex: card is face up");

            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    NSLog(@"gameModel:flipCardAtIndex: another card found");

                    int matchscore = [card match:@[otherCard]];
                    if (matchscore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchscore * MATCH_BONUS;
                        NSLog(@"gameModel:flipCardAtIndex: match!");
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        NSLog(@"gameModel:flipCardAtIndex: no match!");
                    }//if matchscore
                    break;
                }//there could be a match
            }//end for
            self.score -= FLIP_COST;
        }//end if card faceup
        card.faceUp = !card.faceUp;
        //[self.cards replaceObjectAtIndex:index withObject:card];
        if (card.faceUp) {
            NSLog(@"gameModel:flipCardAtIndex:turned card face up");
        }
    }
}

-(Card *) cardAtIndex:(NSUInteger)index
{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
