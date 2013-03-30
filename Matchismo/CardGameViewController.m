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
#import "GameScore.h"

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
    NSLog(@"CGVC:viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"CGVC:viewDidAppear");
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
    [self.gameScore synchronize];
    self.flipCount++;
    [self updateUI];
}


//////////////////
//
//initializers and other methods
//
//////////////////

//game play initialize
- (CardMatchingGame *) game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                           usingDeck:[[PlayingCardDeck alloc]init]
                                                           usingType:0];
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
    NSLog(@"CGVC:update UI");

    [self updateUICardButtons];
    
    //set the text labels
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.statusLabel.text = [NSString stringWithFormat:@"%@", self.game.status];
    NSLog(@"CGVC:updateUI:Labels:%@/%@/%@",self.scoreLabel.text, self.flipsLabel.text, self.statusLabel.text);
}

//this method needs to be overridden in the subclasses for the card-specific implementation
- (void)updateUICardButtons {
}

@end
