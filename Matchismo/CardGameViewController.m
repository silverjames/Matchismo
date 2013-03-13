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
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

//actions
- (IBAction)gameType:(id)sender {
    int i = [self.gameSelector selectedSegmentIndex];
}
- (IBAction)deal:(id)sender {
    self.game = Nil;
    self.flipCount = 0;
    [self updateUI];
}

//playing card button action!
- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

//game play initialize
- (CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]] usingGameType:[self.gameSelector selectedSegmentIndex]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

//keeping model and view in synch
- (void)updateUI
{
    //set all the buttons
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3: 1.0;
        //NSLog(@"Controller:updateUI: button set with %@", card.contents  );
    }//end for through cardButtons
    
    //set the text labels
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.statusLabel.text = [NSString stringWithFormat:@"%@", self.game.status];
}

@end
