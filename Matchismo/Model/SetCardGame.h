//
//  SetCardGame.h
//  Matchismo
//
//  Created by Bernie on 29.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetCardGame : CardMatchingGame

-(SetCard *) cardAtIndex:(NSUInteger)index;

@end
