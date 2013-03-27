//
//  GameResultsController.m
//  Matchismo
//
//  Created by Bernie on 17.03.13.
//  Copyright (c) 2013 bfk engineering. All rights reserved.
//

#import "GameResultsController.h"
#import "GameScore.h"
#define START_KEY @"start"
#define DURATION_KEY @"duration"
#define SCORE_KEY @"score"


@interface GameResultsController ()
@property (weak, nonatomic) IBOutlet UITextView *gameResultsTextView;
@end

@implementation GameResultsController

//other methods
//update UI
-(void)updateUI:(NSArray *)descriptor{
    
    if (!descriptor) [self sortScore]; //perform default sort operation

    self.gameResultsTextView.text = @"";
    NSMutableString *displayText = [[NSMutableString alloc ]init ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSLocale *deLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];

    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:deLocale];
    
    for (GameScore *result in [GameScore allGameResultsSorted:descriptor]) {
        [displayText appendFormat:@"score: %d (%@ - %ds)\n", result.score, [dateFormatter stringFromDate:result.start], (int)round(result.duration) ];
    }
    
    self.gameResultsTextView.text = displayText.description;
}

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
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"GRC:viewWillAppear");
    [self sortScore];

}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
 
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//action methods
//
- (IBAction)sortScore {
    NSArray *descriptor = [[NSArray alloc] initWithObjects:[[NSSortDescriptor alloc]initWithKey:SCORE_KEY ascending:NO], nil];
    [self updateUI:descriptor];
}
- (IBAction)sortDate {
    NSArray *descriptor = [[NSArray alloc] initWithObjects:[[NSSortDescriptor alloc]initWithKey:START_KEY ascending:YES], nil];
    [self updateUI:descriptor];
}
- (IBAction)sortDuration {
    NSArray *descriptor = [[NSArray alloc] initWithObjects:[[NSSortDescriptor alloc]initWithKey:DURATION_KEY ascending:YES], nil];
    [self updateUI:descriptor];
}



@end
