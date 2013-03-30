//
//  SetCard.h
//  Matchismo
//
//  Created by Bernie on 28.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) int number; //1, 2, 3
@property (nonatomic) float shading; //0.3, 0.6, 1.0

+(NSArray *) validSymbols;
+(NSArray *) validColors;
+(NSArray *) validNumbers;
+(NSArray *) validFills;

@end
