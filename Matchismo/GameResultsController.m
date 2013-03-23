//
//  GameResultsController.m
//  Matchismo
//
//  Created by Bernie on 17.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "GameResultsController.h"
#import "GameScore.h"
#import "ScoreKeeper.h"


@interface GameResultsController ()
@property (strong, nonatomic) ScoreKeeper *keeper;
@property (weak, nonatomic) IBOutlet UITextView *gameResultsTextView;
@property (strong, nonatomic) NSMutableString *displayText;
@end

@implementation GameResultsController

//lifecycle methods
//
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
    
    if (!self.keeper) _keeper = [[ScoreKeeper alloc]init];
    if (!self.displayText) _displayText = [[NSMutableString alloc]init];
    NSLog(@"GRC:viedDidLoad with %lu scores", (unsigned long)[self.keeper.cardGameScores count]);
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.keeper) {//I have a context - display scores
        //1. refresh from user defaults
        [self.keeper synchronize];
        
        //2. print contents to view
        int i = 1;
        for (id key in self.keeper.cardGameScores) {
            NSArray *score = [self.keeper.cardGameScores objectForKey:key];
            [self.displayText appendString:[[NSArray arrayWithObjects: [NSNumber numberWithInt:i], score[0],score[1], score[2], @"\n", nil] componentsJoinedByString:@" "]];
            i++;
        }//end for
        
        self.gameResultsTextView.text = self.displayText.description;
    }//end if

}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
 
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.displayText setString: @""];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//action methods
//
- (IBAction)sortScore:(id)sender {
}
- (IBAction)sortDate:(id)sender {
}
- (IBAction)sortTime:(id)sender {
}


@end
