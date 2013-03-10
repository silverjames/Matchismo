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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController


//playing card button action!
- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.flipCount++;
}


//may move this to updateUI
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Umdrehungen aktualisiert zu %d", self.flipCount);
}//end setter


//called when the user changes game type

@end
