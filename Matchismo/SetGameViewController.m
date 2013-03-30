//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Bernie on 27.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()
@property (strong, nonatomic) SetCardGame *game;


@end

@implementation SetGameViewController
//initializer
//game play initialize
- (SetCardGame *) game{
    if (!_game) _game = [[SetCardGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc]init] usingType:0];
    return _game;
}

//keeping model and view in synch
- (void)updateUI {
    //set all the buttons
    NSLog(@"SGVC:update UI");
    
    [self updateUICardButtons];
    NSLog(@"SGVC:updateUI:LabelContent:%d/%d/%@",self.game.score, self.flipCount, self.game.status);
    
    //set the text labels
    
/*  self.tmp1.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.tmp2.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.tmp3.text = [NSString stringWithFormat:@"%@", self.game.status];
    //    NSLog(@"SGVC:updateUI:LabelText:%@/%@/%@",self.scoreLabel.text, self.flipsLabel.text, self.statusLabel.text);

 NSLog(@"SGVC:updateUI:LabelText:%@/%@/%@",self.tmp1.text, self.tmp2.text, self.tmp3.text);
*/
 }

-(void)updateUICardButtons {
    NSLog(@"SGVC:updateUICardButtons: entered");
    
    for (UIButton *cardButton in self.cardButtons){
        SetCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        NSLog(@"SGVC:updateUICardButtons: button set with %@", card.contents);

        //string 1-3 times the card symbol
        NSMutableString *cardSymbols = [[NSMutableString alloc] init];
        for (int i =1; i==card.number; i++) [cardSymbols appendString:card.symbol];

        //define color, shading and font of symbol
//        NSDictionary *cardAttributes = @{NSForegroundColorAttributeName:[card.color colorWithAlphaComponent:card.shading], NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:16]};
        NSDictionary *cardAttributes = @{NSForegroundColorAttributeName:card.color, NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:10]};

        //allocate the formatted string and set the title
        NSMutableAttributedString *cont = [[NSMutableAttributedString alloc] initWithString:cardSymbols attributes:cardAttributes];
        [cardButton setAttributedTitle:cont forState:UIControlStateNormal];
        
        if (card.isUnplayable) cardButton.alpha = 0.0;
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
    }//end for through cardButtons
    NSLog(@"SGVC:updateUICardButtons: labels:%@/%d/%d", self.game.status, self.game.score, self.flipCount);
    NSLog(@"SGVC:updateUICardButtons: exit");
    
}

//lifecycle methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
