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
    if (otherCards.count == 1){
    
        PlayingCard *card = [otherCards lastObject];
        
        if ([card.suit isEqualToString:self.suit]){//suit match
            score=1;
        } else if (card.rank == self.rank){
            score = 4;
        }
    
    }//end oi count 1
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
