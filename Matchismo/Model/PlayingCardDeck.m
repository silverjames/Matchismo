//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Bernie on 09.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck


- (id)init
{
    self = [super init];
    
    if (self) {
        
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank =1; rank <= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }//end rank for
        }//end suit for
    }//end if
                                                        
    return self;
}//end init

@end
