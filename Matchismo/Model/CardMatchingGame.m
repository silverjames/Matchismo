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
@property (readwrite, nonatomic) NSString *status;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) BOOL threeMatchGame;
@end

@implementation CardMatchingGame

//setter
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

//initializer
-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck usingGameType:(NSUInteger)gameType
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
                //NSLog(@"GameModel:init:random card: %d - %@", i, card.contents  );
            }
        }//end for
        self.status = @" ";
        //now set the game type (2 or 3 matches, default is 2)
        if (gameType == 1) {
            self.threeMatchGame = YES;
            NSLog(@"game model:init: three card match");
        } else {
            self.threeMatchGame = NO;
            NSLog(@"game model:init: two card match");
        }
    }//end if
    return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

-(void)flipCardAtIndex:(NSUInteger)index
{
    NSMutableArray *faceUpCards;
    Card *card = [self cardAtIndex:index];
    NSLog(@"gameModel:flipCardAtIndex:card: %@", card.contents);

    if (!card.isUnplayable) {//if the card is playable
        //NSLog(@"gameModel:flipCardAtIndex: card is playable");
        if (!card.isFaceUp) {//and was not faceup, we can turn and match
            //NSLog(@"gameModel:flipCardAtIndex: card was not face up");
            
            //find all other face-up cards
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [faceUpCards addObject:otherCard];
                }//end if
            }//end for

            //do the matching if we found any other face-up card
            if ([faceUpCards count] > 0) {
                NSMutableString *matchLabels;
                int matchscore = [card match:faceUpCards];
                if (matchscore) {
                    for (Card *matchCard in faceUpCards) {
                        matchCard.unplayable = YES;
                        //format matching cards for status message
                        if (matchLabels == Nil) {
                            [matchLabels appendString:matchCard.contents];
                        } else {
                            [matchLabels appendFormat:@" and %@", matchCard.contents];
                        }
                    }//end for
                    card.unplayable = YES;
                    self.score += matchscore * MATCH_BONUS;
                    self.status = [NSString stringWithFormat:@"matched %@ with %@ for %d points!",
                                            card.contents, matchLabels, matchscore * MATCH_BONUS];
                             
                    } else {//no match!
                        for (Card *matchCard in faceUpCards) {
                            matchCard.faceUp = NO;
                        }
                        self.score -= MISMATCH_PENALTY;
                        self.status = [NSString stringWithFormat:@"Oops! Mismatch penalty: %d points!",MISMATCH_PENALTY];
                    }//if matchscore
                             
            }//end faceUpCard count
            self.status = [NSString stringWithFormat:@"flipped %@ up",card.contents];
        
        }//end if card was not faceup and could be trurned
        card.faceUp = !card.faceUp;
        self.score -= FLIP_COST;

    }//end if card is playable

}//end method

            
-(Card *) cardAtIndex:(NSUInteger)index
{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
