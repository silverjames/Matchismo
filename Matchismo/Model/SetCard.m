//
//  SetCard.m
//  Matchismo
//
//  Created by Bernie on 28.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "SetCard.h"
#define MAX_VARIATIONS 3;

@implementation SetCard
@synthesize symbol = _symbol;

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
