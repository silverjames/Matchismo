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

#define SYMBOL_FONT @"HiraKakuProN-W3"

@interface SetGameViewController ()
@property (strong, nonatomic) SetCardGame *game;


@end

@implementation SetGameViewController
//initializer
//game play initialize
- (SetCardGame *) game{
    if (!_game) _game = [[SetCardGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc]init] usingType:1];
    return _game;
}

-(void)updateUICardButtons {
    NSLog(@"SGVC:updateUICardButtons: entered");
    
    NSMutableString *cardSymbols = [[NSMutableString alloc] init];
    for (UIButton *cardButton in self.cardButtons){
        SetCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //NSLog(@"SGVC:updateUICardButtons: button set with %@", card.contents);

        //string the card symbol
        for (int i =1; i<=card.number; i++)[cardSymbols appendString:card.symbol];
        
        //define color, shading and font of symbol
        NSDictionary *cardAttributes = @{NSFontAttributeName:[UIFont fontWithName:SYMBOL_FONT size:19],NSForegroundColorAttributeName:[[UIColor performSelector:NSSelectorFromString(card.color)] colorWithAlphaComponent:card.shading]};

        //allocate the formatted string and set the title
        NSAttributedString *cont = [[NSAttributedString alloc] initWithString:cardSymbols attributes:cardAttributes];
        [cardButton setAttributedTitle:cont forState:UIControlStateNormal];
 
        if (card.isUnplayable) cardButton.alpha = 0.0;
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        cardButton.selected ? [cardButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]]:[cardButton setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.1]];
    
       [cardSymbols setString:@""];
    }//end for through cardButtons
    
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
