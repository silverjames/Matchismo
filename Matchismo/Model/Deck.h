//
//  Deck.h
//  Matchismo
//
//  Created by Bernie on 08.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;
@end
