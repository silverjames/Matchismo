//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Bernie on 29.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
- (id)init {
    self = [super init];
    
    if (self) {
        
        for (NSString *symbol in [SetCard validSymbols]) {
            for (UIColor *color in [SetCard validColors]) {
                for (NSNumber *number in [SetCard validNumbers]){
                    for (NSNumber *fill in [SetCard validFills]){
                        SetCard *card = [[SetCard alloc]init];
                        card.shading = fill.doubleValue;
                        card.color = color;
                        card.symbol = symbol;
                        card.number = number.intValue;
                        [self addCard:card atTop:YES];
                    }//fill
                }//number
            }//color
        }//symbol
    }//end if
    
    return self;
}//end init
@end
