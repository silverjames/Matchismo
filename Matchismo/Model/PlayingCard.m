//
//  PlayingCard.m
//  Matchismo
//
//  Created by Bernie on 09.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards
{
    int score=0;
    
    //the vectors hold the matching suits and ranks
    NSMutableArray *suitVector;
    NSMutableArray *rankVector;
     
    if (otherCards) {
        for (int i = 0; i<otherCards.count; i++) {
            PlayingCard *card = [otherCards objectAtIndex:i];
            if ([card.suit isEqualToString:self.suit]) {
                [suitVector insertObject:card.suit atIndex:i];
            }//end if suit match
            if (card.rank == self.rank) {
                [rankVector insertObject:(NSString *)@"x" atIndex:i];
            }//end if rank match
        }
    }
    
    //now lets evaluate the vectors
    if (otherCards.count == 1){//match for a two-card game
    
        if ([suitVector count] == 1){//suit match
            score=1;
        } else if ([rankVector count] == 1 ){
            score = 4;
        }
    
    } else if (otherCards.count == 2){//match for a three-card game

        if ([suitVector count] == 2){//rank match
            score = 4;
        } else if ([rankVector count] == 2 ){
            score = 12;
        }
       
        
    }//end else if
        
    return score;
}
- (NSString *)suit
{
    return _suit;
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
         _suit = suit;
    }
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count -1;
}
+ (NSArray *) validSuits
{
    return @[@"♣", @"♠", @"♥", @"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"B", @"D", @"K"];
}
@end
