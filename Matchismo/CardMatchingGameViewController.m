//
//  CardMatchingGameViewController.m
//  Matchismo
//
//  Created by Bernie on 28.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"


@interface CardMatchingGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardMatchingGameViewController

//keeping model and view in synch - game-specific code
-(void)updateUICardButtons {
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        cardButton.alpha = card.isUnplayable ? 0.3: 1.0;
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"card_front"] forState:UIControlStateSelected];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(10,10,10,10)];
        if (!cardButton.selected) {
            [cardButton setBackgroundImage:[UIImage imageNamed:@"card_back"] forState:UIControlStateNormal];
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(10,10,10,10)];
        }//card is not seleced
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        //NSLog(@"Controller:updateUI: button set with %@", card.contents  );
    }//end for through cardButtons
}

-(void) resetGame{
    self.game = Nil;
}


//game-specific initializer
- (CardMatchingGame *) game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:[[PlayingCardDeck alloc]init]
                                                          usingType:0];
    return _game;
}

//overrridden lifecycle methods


@end
