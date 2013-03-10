//
//  Card.h
//  Matchismo
//
//  Created by Bernie on 06.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property(nonatomic, getter=isFaceUp) BOOL faceUp;
@property(nonatomic, getter=isUnplayable) BOOL unplayable;
-(int)match:(NSArray *)otherCards;
@end
