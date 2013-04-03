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

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

#define FLIP_STATUS @"flip_status"
#define CARDS_MATCHED @"cards_matched"
#define CARDS_MISMATCHED @"cards_mismatched"

#define GAME_TYPE_MATCH 0
#define GAME_TYPE_SET 1

@interface CardMatchingGame()
@property (readwrite, nonatomic) NSMutableDictionary *status;
@property  (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *faceUpCards;

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
-(NSMutableDictionary *)status{
    if(!_status) _status = [[NSMutableDictionary alloc]init];
    return _status;
}

//initializer
//also sets game start timer
//
-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck usingType:(NSUInteger)idx
{
    self = [super init];

    for (NSUInteger i = 0; i < count; i++) {
        Card *card = [deck drawRandomCard];
        if (!card){
            self = nil;
        } else {
             card.faceUp = NO;
             self.cards[i] = card;
        }
    }//end for

    self.gameType = idx;
    return self;
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    [self.faceUpCards removeAllObjects];
//    [self.matchLabels setString:@""];
    Card *card = [self cardAtIndex:index];

    if (!card.isUnplayable) {//if the card is playable
        if (!card.isFaceUp) {//and was not faceup, we can turn and match
            [self.status setObject:card forKey:FLIP_STATUS];
            
            //find all other face-up cards
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [self.faceUpCards addObject:otherCard];
                }//end if
            }//end for

            switch ([self.faceUpCards count]) {
                case 0:
                    break;
                case 1:
                    if (self.gameType == GAME_TYPE_MATCH) {
                        [self processMatch:card];
                    }
                    break;
                case 2:
                    if (self.gameType == GAME_TYPE_SET) {
                        [self processMatch:card];
                   }
                default:
                    break;
            }//end switch
            
            self.score -= FLIP_COST;
        
        }//end if card was not faceup and could be turned
        card.faceUp = !card.faceUp;

    }//end if card is playable
    [self.faceUpCards removeAllObjects];
    
}//end method

-(void) processMatch: (Card *) card{

    int matchscore = [card match:self.faceUpCards];

    if (matchscore) {
        //process status data for match and render cards unplayable
        NSMutableArray *arr = [[NSMutableArray alloc]init];
 
        [arr addObject:card];
        card.unplayable = YES;
        
        for (Card *matchCard in self.faceUpCards){
            matchCard.unplayable = YES;
            [arr addObject:matchCard];
        }
        self.score += matchscore * MATCH_BONUS;
        [self.status setObject:arr forKey:CARDS_MATCHED];

    } else {//no match - turn cards back down and set status
        for (Card *matchCard in self.faceUpCards) matchCard.faceUp = NO;
        self.score -= MISMATCH_PENALTY;
        [self.status setObject:@"dummy" forKey:CARDS_MISMATCHED];
    }//if matchscore
}


-(Card *) cardAtIndex:(NSUInteger)index
{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
