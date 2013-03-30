//
//  SetCardGame.m
//  Matchismo
//
//  Created by Bernie on 29.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "SetCardGame.h"
#import "SetCard.h"
@implementation SetCardGame

-(SetCard *) cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
