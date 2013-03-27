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
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) GameScore *gameScore;
@property (nonatomic) int flipCount;
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


}
//////////////////
//
//action methods
//
//////////////////

- (IBAction)gameType:(id)sender {
    self.game = Nil;
    self.gameScore = nil;
    self.flipCount = 0;
    NSLog(@"selector segment index: %d", [self.gameSelector selectedSegmentIndex]);
    [self updateUI];

}
- (IBAction)deal:(id)sender {
    self.game = Nil;
    self.gameScore = Nil;
    self.flipCount = 0;
    [self.gameSelector setEnabled:YES forSegmentAtIndex:0];
    [self.gameSelector setSelectedSegmentIndex:0];
    [self.gameSelector setEnabled:YES forSegmentAtIndex:1];
    
    [self updateUI];
}

//playing card button action!
- (IBAction)flipCard:(UIButton *)sender
{
    [self.gameSelector setEnabled:NO forSegmentAtIndex:0];
    [self.gameSelector setEnabled:NO forSegmentAtIndex:1];
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
//    NSLog(@"CGVC:game: selectedSegmentIndex: %d", [self.gameSelector selectedSegmentIndex]);
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                           usingDeck:[[PlayingCardDeck alloc]init]
                                                           usingType:[self.gameSelector selectedSegmentIndex]];
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
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        cardButton.alpha = card.isUnplayable ? 0.3: 1.0;
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"card_front"] forState:UIControlStateSelected];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(2.2, 2.2, 2.2, 2.2)];
        if (!cardButton.selected) {
            [cardButton setBackgroundImage:[UIImage imageNamed:@"card_back"] forState:UIControlStateNormal];
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(2.2, 2.2, 2.2, 2.2)];
        }//card is not seleced
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        //NSLog(@"Controller:updateUI: button set with %@", card.contents  );
    }//end for through cardButtons
    
    //set the text labels
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.statusLabel.text = [NSString stringWithFormat:@"%@", self.game.status];

}

@end
