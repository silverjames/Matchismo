//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Bernie on 06.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "SetCard.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "GameScore.h"

#define GAME_TYPE_MATCH 0
#define GAME_TYPE_SET 1

#define FLIP_STATUS @"flip_status"
#define CARDS_MATCHED @"cards_matched"
#define CARDS_MISMATCHED @"cards_mismatched"
#define SYMBOL_FONT @"HiraKakuProN-W3"
#define SYSTEM_FONT @"HelveticaNeue"


@interface CardGameViewController ()
@property (strong, nonatomic) GameScore *gameScore;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController
//////////////////
//
//lifecycle methods
//
//////////////////

- (void)viewDidLoad{
}
- (void)viewWillAppear:(BOOL)animated{
  //    NSLog(@"CGVC:viewWillAppear");  
}

- (void)viewDidAppear:(BOOL)animated{
//    NSLog(@"CGVC:viewDidAppear");
}
//////////////////
//
//action methods
//
//////////////////

- (IBAction)deal:(id)sender {
    self.game = Nil;
    self.gameScore = Nil;
    self.flipCount = 0;
    [self updateUI];
}

//playing card button action!
- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.gameScore.score = self.game.score;
    self.gameScore.gameType = self.game.gameType;
    [self.gameScore synchronize];
    self.flipCount++;
    [self updateUI];
}


//////////////////
//
//initializers and other methods
//
//////////////////

//game play initialize - override in subclass for other game types
- (CardMatchingGame *) game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                           usingDeck:[[PlayingCardDeck alloc]init]
                                                           usingType:GAME_TYPE_MATCH];
    return _game;
}

- (GameScore *) gameScore{
    if (!_gameScore) _gameScore = [[GameScore alloc] init];
    return _gameScore;
}

- (void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;    	
    [self updateUI];
}

//keeping model and view in synch
- (void)updateUI {

    //set all the buttons
    [self updateUICardButtons];
    
    //set the text labels
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];

    //format and set status message
    //MATCH LOGIC
    if ([self.game.status objectForKey:CARDS_MATCHED]) {
        //get the matching card array
        NSArray *arr = [self.game.status objectForKey:CARDS_MATCHED];
        BOOL setGame = YES;
        NSMutableArray *matchCards = [[NSMutableArray alloc]init];
        
        if ([[arr lastObject] isKindOfClass: [SetCard class]]) {

            //we are dealing with set cards, let's create an array of
            //attributed strings that can be displayed
            for (SetCard *card in arr){
                NSMutableString *cardSymbols = [[NSMutableString alloc] init];
                //string the card symbol
                for (int i =1; i<=card.number; i++)[cardSymbols appendString:card.symbol];
                //define color, shading and font of symbol
                NSDictionary *cardAttributes = @{NSFontAttributeName:[UIFont fontWithName:SYMBOL_FONT size:12],NSForegroundColorAttributeName:[[UIColor performSelector:NSSelectorFromString(card.color)] colorWithAlphaComponent:card.shading]};
                //allocate the formatted string and set the title
                NSAttributedString *cont = [[NSAttributedString alloc] initWithString:cardSymbols attributes:cardAttributes];
                [matchCards addObject:cont];
            }//end for set cards
        } else {
            setGame = NO;
            for (PlayingCard *card in arr)[matchCards addObject:[NSString stringWithString:card.contents]];
        }//end for playing cards
        
        if (setGame) {
            NSMutableAttributedString *msg = [[NSMutableAttributedString alloc] initWithString:@"matched cards: "];
            NSMutableAttributedString *divider = [[NSMutableAttributedString alloc] initWithString:@" - "];
            for (NSMutableAttributedString *as in matchCards){
                [msg appendAttributedString:as];
                [msg appendAttributedString:divider];
            }//end for
            [self.statusLabel setAttributedText:msg];
        } else {//no set game
            NSMutableString *msg = [[NSMutableString alloc] initWithString:@"matched cards: "];
            for (NSString *as in matchCards){
                [msg appendString:as];
                [msg appendString:@" - "];
            }//end for
            [self.statusLabel setText:msg];

        }//end msg formatting
    
    }//end CARD MATCHED state
    
    //MISMATCH LOGIG
    else if ([self.game.status objectForKey:CARDS_MISMATCHED]) self.statusLabel.text = @"cards mismatched!";

    //FLIP LOGIC
    else if ([self.game.status objectForKey:FLIP_STATUS]){

        if ([[self.game.status objectForKey:FLIP_STATUS] isKindOfClass: [SetCard class]]) {
            SetCard *card = [self.game.status objectForKey:FLIP_STATUS];
            NSMutableString *cardSymbols = [[NSMutableString alloc] init];
 
            //string the card symbol
            for (int i =1; i<=card.number; i++)[cardSymbols appendString:card.symbol];
                
            //define color, shading and font of symbol
            NSDictionary *cardAttributes = @{NSFontAttributeName:[UIFont fontWithName:SYMBOL_FONT size:12],NSForegroundColorAttributeName:[[UIColor performSelector:NSSelectorFromString(card.color)] colorWithAlphaComponent:card.shading]};
                
            //allocate the formatted string and set the title
            NSAttributedString *cont = [[NSAttributedString alloc] initWithString:cardSymbols attributes:cardAttributes];

            NSMutableAttributedString *msg = [[NSMutableAttributedString alloc] initWithString:@"flipped card: "];
            [msg appendAttributedString:cont];
            [msg addAttributes:cardAttributes range:NSMakeRange(13, card.number)];

            [self.statusLabel setAttributedText:msg];

        } else {//not a set card
            PlayingCard *card = [self.game.status objectForKey:FLIP_STATUS];
            self.statusLabel.text = [NSString stringWithFormat:@"flipped card %@", card.contents];
            
        }
    }
    
    [self.game.status removeAllObjects];
}

//this method needs to be overridden in the subclasses for the card-specific implementation
- (void)updateUICardButtons {
}

@end
