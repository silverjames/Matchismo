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
@property (strong, nonatomic) NSMutableArray *faceUpCards;
@property (strong, nonatomic) NSMutableString *matchLabels;

@end

@implementation CardMatchingGame

//setter
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}
-(NSMutableArray *)faceUpCards
{
    if(!_faceUpCards) _faceUpCards = [[NSMutableArray alloc]init];
    return _faceUpCards;
}
-(NSMutableString *)matchLabels
{
    if(!_matchLabels) _matchLabels = [[NSMutableString alloc]init];
    return _matchLabels;
}

//initializer
-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck usingType:(NSUInteger)idx
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
        self.matchType = idx;
    }//end if
    return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

-(void)flipCardAtIndex:(NSUInteger)index
{
    [self.faceUpCards removeAllObjects];
    [self.matchLabels setString:@""];
    //NSLog(@"game:flipCard: game type: %d", self.matchType);
    Card *card = [self cardAtIndex:index];
    //NSLog(@"gameModel:flipCardAtIndex:card: %@", card.contents);

    if (!card.isUnplayable) {//if the card is playable
        //NSLog(@"gameModel:flipCardAtIndex: card is playable");
        if (!card.isFaceUp) {//and was not faceup, we can turn and match
            //NSLog(@"gameModel:flipCardAtIndex: card was not face up");
            self.status = [NSString stringWithFormat:@"flipped %@ up",card.contents];
            
            //find all other face-up cards
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [self.faceUpCards addObject:otherCard];
                    NSLog(@"found one other face-up card, total now at %d", [self.faceUpCards count]);
                }//end if
            }//end for

            switch ([self.faceUpCards count]) {
                case 0:
                    break;
                case 1:
                    if (self.matchType == 0) {
                        int matchscore = [card match:self.faceUpCards];
                        if (matchscore) {
                            BOOL firstCard = YES;
                            for (Card *matchCard in self.faceUpCards) {
                                matchCard.unplayable = YES;
                                //format matching cards for status message
                                if (firstCard) {
                                    [self.matchLabels appendString:matchCard.contents];
                                    firstCard = NO;
                                } else {
                                    [self.matchLabels appendFormat:@" and %@", matchCard.contents];
                                }
                            }//end for
                            card.unplayable = YES;
                            self.score += matchscore * MATCH_BONUS;
                            self.status = [NSString stringWithFormat:@"matched %@ with %@ for %d points!",
                                           card.contents, self.matchLabels, matchscore * MATCH_BONUS];
                            
                        } else {//no match!
                            for (Card *matchCard in self.faceUpCards) {
                                matchCard.faceUp = NO;
                            }
                            self.score -= MISMATCH_PENALTY;
                            self.status = [NSString stringWithFormat:@"Oops! Mismatch penalty: %d points!",MISMATCH_PENALTY];
                        }//if matchscore

                    }
                    break;
                case 2:
                    if (self.matchType == 1) {
                        int matchscore = [card match:self.faceUpCards];
                        if (matchscore) {
                            BOOL firstCard = YES;
                            for (Card *matchCard in self.faceUpCards) {
                                matchCard.unplayable = YES;
                                //format matching cards for status message
                                if (firstCard) {
                                    [self.matchLabels appendString:matchCard.contents];
                                    firstCard = NO;
                                } else {
                                    [self.matchLabels appendFormat:@" and %@", matchCard.contents];
                                }
                            }//end for
                            card.unplayable = YES;
                            self.score += matchscore * MATCH_BONUS;
                            self.status = [NSString stringWithFormat:@"matched %@ with %@ for %d points!",
                                           card.contents, self.matchLabels, matchscore * MATCH_BONUS];
                            
                        } else {//no match!
                            for (Card *matchCard in self.faceUpCards) {
                                matchCard.faceUp = NO;
                            }
                            self.score -= MISMATCH_PENALTY;
                            self.status = [NSString stringWithFormat:@"Oops! Mismatch penalty: %d points!",MISMATCH_PENALTY];
                        }//if matchscore
                    }
                    
                default:
                    break;
            }//end switch
            
            self.score -= FLIP_COST;
        
        }//end if card was not faceup and could be trurned
        card.faceUp = !card.faceUp;

    }//end if card is playable
    [self.faceUpCards removeAllObjects];
    
}//end method

            
-(Card *) cardAtIndex:(NSUInteger)index
{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
