//
//  PlayingCard.m
//  Matchismo
//
//  Created by Bernie on 09.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "PlayingCard.h"
@interface PlayingCard()
@property (strong, nonatomic) NSMutableArray *suitVector;
@property (strong, nonatomic) NSMutableArray *rankVector;
@end

@implementation PlayingCard
@synthesize suit = _suit;

//the vectors hold the matching suits and ranks
-(NSMutableArray *)suitVector
{
    if(!_suitVector) _suitVector = [[NSMutableArray alloc]init];
    return _suitVector;
}
-(NSMutableArray *)rankVector
{
    if(!_rankVector) _rankVector = [[NSMutableArray alloc]init];
    return _rankVector;
}

-(int)match:(NSArray *)otherCards
{
    int score=0;
    [self.suitVector removeAllObjects];
    [self.rankVector removeAllObjects];
     
    if (otherCards) {
        NSLog(@"PlayingCard:matching logic: %d cards", otherCards.count + 1);
        for (int i = 0; i<otherCards.count; i++) {
            PlayingCard *card = [otherCards objectAtIndex:i];
            if ([card.suit isEqualToString:self.suit]) {
                [self.suitVector  addObject:card.suit];
            }//end if suit match
            if (card.rank == self.rank) {
                [self.rankVector addObject:(NSString *)@"x"];
            }//end if rank match
        }
    }
    
    //now lets evaluate the vectors
    if (otherCards.count == 1){//match for a two-card game
    
        if ([self.suitVector count] == 1){//suit match
            score=1;
        } else if ([self.rankVector count] == 1 ){
            score = 4;
        }
    
    } else if (otherCards.count == 2){//match for a three-card game

        if ([self.suitVector count] == 2){//rank match
            score = 4;
        } else if ([self.rankVector count] == 2 ){
            score = 12;
        }       
        
    }//end else if
    NSLog(@"PlayingCard:match:returning score of %d", score);
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
