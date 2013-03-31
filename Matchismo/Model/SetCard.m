//
//  SetCard.m
//  Matchismo
//
//  Created by Bernie on 28.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "SetCard.h"
#define MAX_VARIATIONS 3;

@interface SetCard()
@property (strong, nonatomic) NSMutableArray *symbolSet;
@property (strong, nonatomic) NSMutableArray *numberSet;
@property (strong, nonatomic) NSMutableArray *colorSet;
@property (strong, nonatomic) NSMutableArray *shadingSet;
@end

@implementation SetCard
@synthesize symbol = _symbol;


//the sets hold the matching symbols, numbers, color and shading (scoring prep)
-(NSMutableArray *)symbolSet {
    if(!_symbolSet) _symbolSet = [[NSMutableArray alloc]init];
    return _symbolSet;
}
-(NSMutableArray *)numberSet {
    if(!_numberSet) _numberSet = [[NSMutableArray alloc]init];
    return _numberSet;
}
-(NSMutableArray *)colorSet {
    if(!_colorSet) _colorSet = [[NSMutableArray alloc]init];
    return _colorSet;
}
-(NSMutableArray *)shadingSet {
    if(!_shadingSet) _shadingSet = [[NSMutableArray alloc]init];
    return _shadingSet;
}

//matching logic
-(int)match:(NSArray *)otherCards
{
    int score=0;
    [self.symbolSet removeAllObjects];
    [self.numberSet removeAllObjects];
    [self.colorSet removeAllObjects];
    [self.shadingSet removeAllObjects];
//   NSLog(@"SelfCard contents:%@", self.contents);
    if (otherCards) {
        //gather the matching properties in sets
        NSLog(@"SetCard:matching logic: %d cards", otherCards.count + 1);
        for (SetCard *card in otherCards) {
            NSLog(@"compare card contents:%@", card.contents);
            if ([card.symbol isEqualToString:self.symbol]) {
                [self.symbolSet addObject:card.symbol];
            }//end if symbol match
            if (card.number == self.number) {
                [self.numberSet  addObject:@(card.number)];
            }//end if number match
            if ([card.color isEqualToString:self.color]) {
                [self.colorSet  addObject:card.color];
            }//end if color match
            if (card.shading == self.shading) {
                [self.shadingSet  addObject:@(card.shading)];
            }//end if shading match
         }
    }
    
    //then check the sets - we need three with a count of 2 for a match!
    int i =0;
    if ([self.symbolSet count] == 2) i = i+2;
    if ([self.numberSet count] == 2) i = i+2;
    if ([self.colorSet count] == 2) i = i+2;
    if ([self.shadingSet count] == 2) i = i+2;
    if (i == 6) score = 24;
    
    NSLog(@"SetCard:match:returning score of %d", score);
    return score;
}

//return content
-(NSString *) contents{
    return  [[NSString alloc] initWithFormat: @"%@%@%d%f", self.symbol, self.color, self.number, self.shading];
}

//setters and getters
- (NSString *)symbol {
    return _symbol;
}

- (void) setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void) setShading:(float)shading {
    if (shading <= 1.0) {
        _shading = shading;
    }
}

+ (NSArray *) validNumbers {
    return @[@1, @2, @3];
}

+ (NSArray *) validFills {
    return @[@0.2, @0.5, @1.0];
}

+ (NSArray *) validSymbols {
    return @[@"▲", @"■", @"●"];
}

+ (NSArray *) validColors {
    return @[@"redColor", @"blueColor", @"greenColor"];
}

@end
