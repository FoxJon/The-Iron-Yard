//
//  SCGstageVC.m
//  Squares
//
//  Created by Jonathan Fox on 4/11/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SCGStageVC.h"
#import "SCGSquare.h"
#import "SCGBackgroundLayer.h"
#import "MOVE.h"
#import "SCGData.h"

@implementation SCGStageVC
{
    int gameSize;
    
   // UIView * home;
    UIView * gameBoard;
    float circleWidth;
    
    NSArray * playerColors;
    
    int playerTurn;
    
    NSMutableDictionary * tappedDots;
    NSMutableDictionary * countDownNumbers;
    NSMutableDictionary * allSquares;
    
    NSString * topLeftDot;
    NSString * topRightDot;
    NSString * bottomLeftDot;
    NSString * bottomRightDot;
    UIButton * startButton;
    UIButton * homeButton;
    UIButton *player2Button;
    UIButton *player1Button;
    UIButton * gridSize4;
    UIButton * gridSize5;
    UIButton * gridSize6;
    UILabel *player1Label;
    UILabel *player1Score;
    UILabel *player2Label;
    UILabel *player2Score;
    UILabel *player1Dot;
    UILabel *player2Dot;
    UIColor * currentColor;
    SCGSquare * currentSquare;
    SCGSquare * square;
    int tempPlayer1SquareCount;
    int tempPlayer2SquareCount;
    UIView * titleFrameF;
    UIView * titleFrameL;
    UIView * titleFrameI;
    UIView * titleFrameP;
    UILabel *letterF;
    UILabel *letterL;
    UILabel *letterI;
    UILabel *letterP;
    UILabel *sletterFrame;
    UILabel *qletterFrame;
    UILabel *uletterFrame;
    UILabel *aletterFrame;
    UILabel *rletterFrame;
    UILabel *eletterFrame;
    UILabel * circleCountDown;
    UIView * newForm;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        playerColors = @[LIGHTBLUE_COLOR, DARKBLUE_COLOR];     // O is lightblue, 1 is darkblue, 2 is white
        
        playerTurn = 0;
        
        tappedDots = [@{}mutableCopy];
       // NSLog(@"tapped dots %@", tappedDots);
        
        countDownNumbers = [@{}mutableCopy];
       // NSLog(@"countDownNumbers %@", countDownNumbers);
        
        NSMutableDictionary * test = [@{@"one":@1, @"two":@2, @"three":@3}mutableCopy];
        
        NSLog(@"Before test: %@", test);
    
        NSArray *keys = [test allKeys];
        NSInteger count = [keys count];
        for (int i = 0; i < count; i++)
        {
            id key = [keys objectAtIndex: i];
            id value = [test objectForKey: key];
            value = [NSNumber numberWithInt:[value intValue]+1];
            [test setValue:value forKey:key];
            
        }
        NSLog(@"After test: %@", test);

    
    
//        NSDictionary *testCopy = [test copy];
//        for (NSNumber *number in [testCopy allValues]) {
//
//        NSNumber *update = [NSNumber numberWithInt:[number intValue]+1];
//        
//        [test setValue:update forKey:[test objectForKey:0]];
//            
//        NSLog(@"test %@",test);
//        }
        
//        NSDictionary *testCopy = [test copy];
//        
//        for (NSNumber *number in [testCopy allValues]) {
//            
//            NSNumber *update = [NSNumber numberWithInt:[number intValue]+1];
//            // NSLog(@"update %@",update);
//            
//            [test setValue:update forKey:[test objectForKey:0]];
//            
//            NSLog(@"test %@",test);
//        }
        
        
//        NSNumber *num;
//        for (int i=0;i<[test count];i++)
//        {
//            num = (NSNumber *) [array objectAtIndex:i];
//            if ([num intValue]> 0)
//            {
//                [array replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[num intValue]+1]];
//            }	
//        }
        

        allSquares = [@{}mutableCopy];
        
        newForm = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:newForm];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; //when the view controller loads on the screen
    
    gameBoard = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    homeButton = [[UIButton alloc] initWithFrame:CGRectMake(280, (SCREEN_HEIGHT * 0.03), 21, 21)];
}

-(void) viewDidAppear:(BOOL)animated {
    [self loadTitlePage];
}

-(void) loadTitlePage{
    
    ///////////////////////////
    // TITLE AND ANIMATIONS //
    //////////////////////////
   
    [homeButton removeFromSuperview];
    [player1Label removeFromSuperview];
    [player2Label removeFromSuperview];
    [player1Dot removeFromSuperview];
    [player2Dot removeFromSuperview];
    [player1Score removeFromSuperview];
    [player2Score removeFromSuperview];
    [newForm removeFromSuperview];
    [circleCountDown removeFromSuperview];


    CAGradientLayer *bgLayer = [SCGBackgroundLayer blueGradient];
    bgLayer.frame = gameBoard.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    [self.view addSubview:gameBoard];
    
    
    titleFrameF = [[UIView alloc]initWithFrame:CGRectMake(45, 50, 50, 50)];
    titleFrameF.backgroundColor = DARKBLUE_COLOR;
    [self.view addSubview:titleFrameF];
    
    letterF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    letterF.text = @"F";
    letterF.textAlignment = 1;
    letterF.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    letterF.textColor = WHITE_COLOR;
    
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^(void) {
                         titleFrameF.backgroundColor = LIGHTBLUE_COLOR;
                         titleFrameF.transform = CGAffineTransformMakeScale(1, -1);
                     }
                     completion:^(BOOL b) {
                     }];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(addF) userInfo:nil repeats:NO];
    
    titleFrameL = [[UIView alloc]initWithFrame:CGRectMake(105, 50, 50, 50)];
    titleFrameL.backgroundColor = DARKBLUE_COLOR;
    [self.view addSubview:titleFrameL];
    
    letterL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    letterL.text = @"L";
    letterL.textAlignment = 1;
    letterL.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    letterL.textColor = WHITE_COLOR;
    
    [UIView animateWithDuration:0.8 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^(void) {
                         titleFrameL.backgroundColor = LIGHTBLUE_COLOR;
                         titleFrameL.transform = CGAffineTransformMakeScale(1, -1);
                     }
                     completion:^(BOOL b) {
                     }];
    [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(addL) userInfo:nil repeats:NO];
    
    titleFrameI = [[UIView alloc]initWithFrame:CGRectMake(165, 50, 50, 50)];
    titleFrameI.backgroundColor = DARKBLUE_COLOR;
    [self.view addSubview:titleFrameI];
    
    letterI = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    letterI.text = @"I";
    letterI.textAlignment = 1;
    letterI.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    letterI.textColor = WHITE_COLOR;
    [UIView animateWithDuration:0.8 delay:0.6 options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^(void) {
                         titleFrameI.backgroundColor = LIGHTBLUE_COLOR;
                         titleFrameI.transform = CGAffineTransformMakeScale(1, -1);
                     }
                     completion:^(BOOL b) {
                     }];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(addI) userInfo:nil repeats:NO];
    
    titleFrameP = [[UIView alloc]initWithFrame:CGRectMake(225, 50, 50, 50)];
    titleFrameP.backgroundColor = DARKBLUE_COLOR;
    [self.view addSubview:titleFrameP];
    
    letterP = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    letterP.text = @"P";
    letterP.textAlignment = 1;
    letterP.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    letterP.textColor = WHITE_COLOR;
    
    [UIView animateWithDuration:0.8 delay:0.9 options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^(void) {
                         titleFrameP.backgroundColor = LIGHTBLUE_COLOR;
                         titleFrameP.transform = CGAffineTransformMakeScale(1, -1);
                     }
                     completion:^(BOOL b) {
                     }];
    [NSTimer scheduledTimerWithTimeInterval:1.3 target:self selector:@selector(addP) userInfo:nil repeats:NO];
    
    sletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(20, 125, 42.5, 42.5)];
    sletterFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    sletterFrame.text = @"S";
    sletterFrame.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    sletterFrame.textAlignment = 1;
    sletterFrame.textColor = LIGHTBLUE_COLOR;
    [self.view addSubview:sletterFrame];
    
    qletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(67.5, 125, 42.5, 42.5)];
    qletterFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    qletterFrame.text = @"Q";
    qletterFrame.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    qletterFrame.textAlignment = 1;
    qletterFrame.textColor = LIGHTBLUE_COLOR;
    [self.view addSubview:qletterFrame];
    
    uletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(115, 125, 42.5, 42.5)];
    uletterFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    uletterFrame.text = @"U";
    uletterFrame.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    uletterFrame.textAlignment = 1;
    uletterFrame.textColor = LIGHTBLUE_COLOR;
    [self.view addSubview:uletterFrame];
    
    aletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(162.5, 125, 42.5, 42.5)];
    aletterFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    aletterFrame.text = @"A";
    aletterFrame.textAlignment = 1;
    aletterFrame.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    aletterFrame.textColor = LIGHTBLUE_COLOR;
    [self.view addSubview:aletterFrame];
    
    rletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(210, 125, 42.5, 42.5)];
    rletterFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    rletterFrame.text = @"R";
    rletterFrame.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    rletterFrame.textAlignment = 1;
    rletterFrame.textColor = LIGHTBLUE_COLOR;
    [self.view addSubview:rletterFrame];
    
    eletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(257.5, 125, 42.5, 42.5)];
    eletterFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    eletterFrame.text = @"E";
    eletterFrame.font =[UIFont fontWithName:@"AvenirNext-DemiBold" size:35.0f];
    eletterFrame.textAlignment = 1;
    eletterFrame.textColor = LIGHTBLUE_COLOR;
    [self.view addSubview:eletterFrame];
    
    ///////////////////////////////
    // END TITLE & ANIMATIONS    //
    // LOAD OPTIONS & ANIMATIONS //
    ///////////////////////////////
    
    player1Button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-105, (SCREEN_HEIGHT * 0.99), 105, 30)];
    [player1Button setTitle:@"1 PLAYER" forState:UIControlStateNormal];
    [player1Button addTarget:self action:@selector(playerSelector1) forControlEvents:UIControlEventTouchUpInside];
    player1Button.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    [player1Button setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [player1Button setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    player1Button.layer.cornerRadius = 6;
    player1Button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20.0f];
    player1Button.titleLabel.tintColor = [UIColor redColor];
    player1Button.alpha = 0;
    [gameBoard addSubview:player1Button];
    [MOVE animateView:player1Button properties:@{@"y": @(SCREEN_HEIGHT * 0.65),@"alpha":@1.0,@"delay":@1.5, @"duration":@1.0}];

    player2Button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+5, (SCREEN_HEIGHT * 0.99), 105, 30)];
    [player2Button setTitle:@"2 PLAYER" forState:UIControlStateNormal];
    [player2Button addTarget:self action:@selector(playerSelector2) forControlEvents:UIControlEventTouchUpInside];
    player2Button.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    [player2Button setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [player2Button setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    player2Button.layer.cornerRadius = 6;
    player2Button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20.0f];
    player2Button.titleLabel.tintColor = [UIColor redColor];
    player2Button.alpha = 0;
    [gameBoard addSubview:player2Button];
    [MOVE animateView:player2Button properties:@{@"y": @(SCREEN_HEIGHT * 0.65),@"alpha":@1.0,@"delay":@1.5, @"duration":@1.0}];

    gridSize4 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-55, (SCREEN_HEIGHT * 0.99), 30, 30)];
    [gridSize4 setTitle:@"4" forState:UIControlStateNormal];
    [gridSize4 addTarget:self action:@selector(loadGridSize4) forControlEvents:UIControlEventTouchUpInside];
    gridSize4.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    [gridSize4 setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [gridSize4 setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    gridSize4.layer.cornerRadius = 6;
    gridSize4.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20.0f];
    gridSize4.alpha = 0;
    [gameBoard addSubview:gridSize4];
    [MOVE animateView:gridSize4 properties:@{@"y": @(SCREEN_HEIGHT * 0.75),@"alpha":@1.0, @"delay":@1.5, @"duration":@1.0}];
    
    gridSize5 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, (SCREEN_HEIGHT * 0.99), 30, 30)];
    [gridSize5 setTitle:@"5" forState:UIControlStateNormal];
    [gridSize5 addTarget:self action:@selector(loadGridSize5) forControlEvents:UIControlEventTouchUpInside];
    gridSize5.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    [gridSize5 setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [gridSize5 setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    gridSize5.layer.cornerRadius = 6;
    gridSize5.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20.0f];
    gridSize5.alpha = 0;
    [gameBoard addSubview:gridSize5];
    [MOVE animateView:gridSize5 properties:@{@"y": @(SCREEN_HEIGHT * 0.75),@"alpha":@1.0, @"delay":@1.5, @"duration":@1.0}];
    
    gridSize6 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+25, (SCREEN_HEIGHT * 0.99), 30, 30)];
    [gridSize6 setTitle:@"6" forState:UIControlStateNormal];
    [gridSize6 addTarget:self action:@selector(loadGridSize6) forControlEvents:UIControlEventTouchUpInside];
    gridSize6.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    [gridSize6 setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [gridSize6 setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    gridSize6.layer.cornerRadius = 6;
    gridSize6.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20.0f];
    gridSize6.alpha = 0;
    [gameBoard addSubview:gridSize6];
    [MOVE animateView:gridSize6 properties:@{@"y": @(SCREEN_HEIGHT * 0.75),@"alpha":@1.0, @"delay":@1.5, @"duration":@1.0}];
    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake(110, (SCREEN_HEIGHT * 0.99), 100, 30)];
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(checkSettings) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    startButton.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    startButton.layer.cornerRadius = 6;
    startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
    startButton.alpha = 0;
    [gameBoard addSubview:startButton];
    [MOVE animateView:startButton properties:@{@"y": @(SCREEN_HEIGHT * 0.85),@"alpha":@1.0, @"delay":@1.5, @"duration":@1.0}];
}

-(void)playerSelector1
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Sorry" message: @"1 vs computer coming soon!." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    player1Button.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    player2Button.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
    [SCGData mainData].numberOfPlayers = 2;
}

-(void)playerSelector2
{
    player1Button.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    player2Button.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
    [SCGData mainData].numberOfPlayers = 2;
}

-(void)loadGridSize4
{
    gridSize5.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    gridSize6.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    gridSize4.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
    [SCGData mainData].gridSize = 4;
}

-(void)loadGridSize5
{
    gridSize4.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    gridSize6.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    gridSize5.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
    [SCGData mainData].gridSize = 5;
}

-(void)loadGridSize6
{
    gridSize4.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    gridSize5.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    gridSize6.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
    [SCGData mainData].gridSize = 6;
}

-(void)addF
{
    [titleFrameF addSubview:letterF];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
        titleFrameF.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL b) {
    }];
}

-(void)addL
{
    [titleFrameL addSubview:letterL];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
        titleFrameL.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL b) {
    }];
}

-(void)addI
{
    [titleFrameI addSubview:letterI];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
        titleFrameI.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL b) {
    }];
}

-(void)addP
{
    [titleFrameP addSubview:letterP];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
        titleFrameP.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL b) {
    }];
}

- (void)checkGameSize
{
    gameSize = [SCGData mainData].gridSize;
}

-(void)checkSettings
{
    if ([SCGData mainData].numberOfPlayers == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"Please select number of players." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if ([SCGData mainData].gridSize == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"Please select grid size." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        NSLog(@"numberOfPlayers %d", [SCGData mainData].numberOfPlayers);
        NSLog(@"gridSize %d", [SCGData mainData].gridSize);
        
        [self loadGameElements];
    }
}

//////////////////////////////////////////////////////////////////////////////
///////// GAME BOARD /////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


-(void)loadGameElements
{
    [newForm removeFromSuperview];
    
    [startButton removeFromSuperview];
    [titleFrameF removeFromSuperview];
    [titleFrameL removeFromSuperview];
    [titleFrameI removeFromSuperview];
    [titleFrameP removeFromSuperview];
    [sletterFrame removeFromSuperview];
    [qletterFrame removeFromSuperview];
    [uletterFrame removeFromSuperview];
    [aletterFrame removeFromSuperview];
    [rletterFrame removeFromSuperview];
    [eletterFrame removeFromSuperview];
    
    [player1Button removeFromSuperview];
    [player2Button removeFromSuperview];
    [gridSize4 removeFromSuperview];
    [gridSize5 removeFromSuperview];
    [gridSize6 removeFromSuperview];

    [self.view addSubview:newForm];

    [homeButton setTitle:@"H" forState:UIControlStateNormal];
    homeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
    [homeButton addTarget:self action:@selector(loadTitlePage) forControlEvents:UIControlEventTouchUpInside];
    homeButton.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    homeButton.titleLabel.textAlignment = 1;
    homeButton.layer.cornerRadius = 6;
    [newForm addSubview:homeButton];
    
    player1Label = [[UILabel alloc] initWithFrame:CGRectMake(-110, (SCREEN_HEIGHT * 0.03), 100, 22)];
    player1Label.text = @" PLAYER 1";
    player1Label.textColor = WHITE_COLOR;
    player1Label.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
    player1Label.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
    player1Label.layer.cornerRadius = 6;
    player1Label.layer.masksToBounds = YES;
    [gameBoard addSubview:player1Label];
    [MOVE animateView:player1Label properties:@{@"x": @20,@"duration" : @1.0}];
    
    player1Dot = [[UILabel alloc] initWithFrame:CGRectMake(-100, (SCREEN_HEIGHT * 0.03), 20, 22)];
    player1Dot.backgroundColor = LIGHTBLUE_COLOR;
    player1Dot.layer.masksToBounds = YES;
    
    [gameBoard addSubview:player1Dot];
    [MOVE animateView:player1Dot properties:@{@"x": @130,@"duration" : @1.0}];
    
    player1Score = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    player1Score.text = @"0";
    player1Score.textAlignment = 1;
    player1Score.textColor = WHITE_COLOR;
    player1Score.layer.cornerRadius = 6;
    player1Score.layer.masksToBounds = YES;
    [player1Dot addSubview:player1Score];
    
    player2Label = [[UILabel alloc] initWithFrame:CGRectMake(-110, (SCREEN_HEIGHT * 0.08), 100, 22)];
    player2Label.text = @" PLAYER 2";
    player2Label.textColor = WHITE_COLOR;
    player2Label.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
    player2Label.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    player2Label.layer.cornerRadius = 6;
    player2Label.layer.masksToBounds = YES;
    [gameBoard addSubview:player2Label];
    [MOVE animateView:player2Label properties:@{@"x": @20,@"duration" : @1.0}];
    
    player2Dot = [[UILabel alloc] initWithFrame:CGRectMake(-100, (SCREEN_HEIGHT * 0.08), 20, 22)];
    player2Dot.backgroundColor = DARKBLUE_COLOR;
    player2Dot.layer.masksToBounds = YES;
  
    [gameBoard addSubview:player2Dot];
    [MOVE animateView:player2Dot properties:@{@"x": @130,@"duration" : @1.0}];

    player2Score = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    player2Score.text = @"0";
    player2Score.textAlignment = 1;
    player2Score.textColor = WHITE_COLOR;
    player2Score.layer.cornerRadius = 6;
    player2Score.layer.masksToBounds = YES;
    [player2Dot addSubview:player2Score];

    [self checkGameSize];
    
    circleWidth = SCREEN_WIDTH / gameSize;
    float squareWidth = circleWidth /1.1;
    float squareOffset = circleWidth - ( squareWidth / 2 );
    
    //create squares
    for (int sRow = 0; sRow < gameSize - 1; sRow++)
    {
        for (int sCol = 0; sCol < gameSize - 1; sCol++)
        {
            //            float squareX = ((circleWidth - squareWidth) * 1.5) + (circleWidth * sCol);
            //            float squareY = ((circleWidth - squareWidth) * 1.5) + (circleWidth * sRow) + ((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);
            
            float squareX = squareOffset + (circleWidth * sCol);
            float squareY = squareOffset + (circleWidth * sRow) + ((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);
            
            square = [[SCGSquare alloc] initWithFrame:CGRectMake(squareX, squareY, squareWidth, squareWidth)];
            
            square.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
            square.layer.cornerRadius = 0;
            
            
            NSString * key = [NSString stringWithFormat:@"c%dr%d",sCol,sRow]; //0,1 will say c0r1
            
            allSquares[key] = square;
            
            [newForm addSubview:square];
            [MOVE animateView:square properties:@{@"alpha":@1.0, @"duration":@2.0,@"delay":@.5}];

            
        }
    }
    
    //create circles
    for (int row = 0; row < gameSize; row++){
        for (int col = 0; col < gameSize; col++){
            
            float circleX = circleWidth * col;
            float circleY = (circleWidth * row) + ((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);
            
            SCGCircle * circle = [[SCGCircle alloc]initWithFrame:CGRectMake(circleX, circleY, circleWidth, circleWidth)];
            
            circle.position = (CGPoint){col,row};
            circle.delegate = self;
            
            NSString * key = [NSString stringWithFormat:@"c%dr%d",col,row]; //0,1 will say c0r1
            
            tappedDots[key] = @2;
            countDownNumbers[key] = @6;
            
            circle.backgroundColor = [UIColor clearColor];
            
            [newForm addSubview:circle];
            
            [MOVE animateView:circle properties:@{@"alpha":@1, @"duration":@0.2,@"delay":@0.3}];

        }
    }
}

-(UIColor *)circleTappedWithPosition:(CGPoint)position{
    
    //get tapped key from position
    NSString * key = [NSString stringWithFormat:@"c%dr%d", (int)position.x, (int)position.y];
    
   // NSLog(@"My touched position is col %d, row %d", (int)position.x, (int)position.y);
    
    /////////////////////////////////////
    // Checks to see if already tapped //
    /////////////////////////////////////
    
    if ([tappedDots[key]  isEqual: @(playerTurn)])
    {
          NSLog(@"IF");
        tappedDots[key] = @(playerTurn);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"You selected your own color. Try again." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return playerColors[playerTurn];
    }
    else if (![tappedDots[key] isEqual: @(0)] && ![tappedDots[key] isEqual: @(2)])
    {
        NSLog(@"ELSE IF 1");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"That color has already been taken. Try again." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
         return playerColors[1];
    }
    else if (![tappedDots[key] isEqual: @(1)] && ![tappedDots[key] isEqual: @(2)])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"That color has already been taken. Try again." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"ELSE IF 0");
         return playerColors[0];
    }
    else
    {
       NSLog(@"ELSE");
    
    ///////////////////////
    // CIRCLE COUNT DOWN //
    ///////////////////////
    
    circleCountDown = [[UILabel alloc]initWithFrame:CGRectMake(circleWidth * position.x+(circleWidth/2-5), (circleWidth * position.y+(circleWidth/2-10)) + ((SCREEN_HEIGHT - SCREEN_WIDTH) / 2), 20, 20)];
    circleCountDown.textColor = WHITE_COLOR;
    circleCountDown.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
        

    if ([countDownNumbers[key] isEqual: @6]) {
        countDownNumbers[key] = @5;
        NSLog(@"countDownNumbers[key]: %@", countDownNumbers[key]);
        circleCountDown.text = [NSString stringWithFormat:@"%@", countDownNumbers[key]];
        [newForm addSubview:circleCountDown];
    }else if ([countDownNumbers[key] isEqual: @5]) {
        countDownNumbers[key] = @4;
        NSLog(@"countDownNumbers[key]: %@", countDownNumbers[key]);
        circleCountDown.text = [NSString stringWithFormat:@"%@", countDownNumbers[key]];
        [newForm addSubview:circleCountDown];
    }else if ([countDownNumbers[key] isEqual: @4]) {
        countDownNumbers[key] = @3;
        NSLog(@"countDownNumbers[key]: %@", countDownNumbers[key]);
        circleCountDown.text = [NSString stringWithFormat:@"%@", countDownNumbers[key]];
        [newForm addSubview:circleCountDown];
    }else if ([countDownNumbers[key] isEqual: @3]) {
        countDownNumbers[key] = @2;
        NSLog(@"countDownNumbers[key]: %@", countDownNumbers[key]);
        circleCountDown.text = [NSString stringWithFormat:@"%@", countDownNumbers[key]];
        [newForm addSubview:circleCountDown];
    }else if ([countDownNumbers[key] isEqual: @2]) {
        countDownNumbers[key] = @1;
        NSLog(@"countDownNumbers[key]: %@", countDownNumbers[key]);
        circleCountDown.text = [NSString stringWithFormat:@"%@", countDownNumbers[key]];
        [newForm addSubview:circleCountDown];
    }else if ([countDownNumbers[key] isEqual: @1]) {
        countDownNumbers[key] = @0;
        tappedDots[key] = @2;
        currentColor = playerColors[playerTurn];
        playerTurn = (playerTurn) ? 0 : 1;
        [self highlightPlayerLabel];
        return currentColor;
        }
    }
  //  NSLog(@"countDownNumbers %@", countDownNumbers);
  //  NSLog(@"countDownNumbersKey %@", countDownNumbers[key]);
    
    // set player num to value in tappedDots
    tappedDots[key] = @(playerTurn);
     //   NSLog(@"tapped dots %@", tappedDots);
     //   NSLog(@"tapped dots %@", tappedDots[key]);

    // check for square
    [self checkForSquareAroundPosition:position];
    
    currentColor = playerColors[playerTurn];
    playerTurn = (playerTurn) ? 0 : 1;
    [self highlightPlayerLabel];
    return currentColor;
}

//-(void)circleFlip
//{
//    
//    NSLog(@"BEING USED");
//    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState
//                     animations: ^(void)
//     {
//         currentSquare.transform = CGAffineTransformMakeScale(1, -1);
//     }
//                     completion:^(BOOL b) {
//                         currentSquare.layer.shadowColor = [UIColor blackColor].CGColor;
//                         currentSquare.layer.shadowOpacity = 0.75;
//                         currentSquare.layer.shadowRadius = 15.0;
//                         currentSquare.layer.shadowOffset = (CGSize){0.0, 20.0};
//                     }];
//}

- (void)highlightPlayerLabel{
    if (playerTurn == 1) {
        //NSLog(@"two");
        player1Label.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
        [gameBoard addSubview:player1Label];
        player2Label.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
        [gameBoard addSubview:player2Label];
        
    
    }else if (playerTurn == 0) {
        //NSLog(@"one");
        player2Label.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
        [gameBoard addSubview:player2Label];
        player1Label.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
        [gameBoard addSubview:player1Label];
    }
}

- (void)checkForSquareAroundPosition:(CGPoint)position
{
    
    int pX = position.x;
    int pY = position.y;
    
    // x = col and y = row
    BOOL above = (position.y > 0);               //if the position y > 0, there is something above
    BOOL below = (position.y < gameSize -1);     //if the position y < 3, there is something below
    BOOL left = (position.x > 0);                //if the position x > 0, there is something left
    BOOL right = (position.x < gameSize -1);     //if the position x < 3, there is something right
    
    if (above && left)
    {
        [self checkSquareForQuadrantAtPosition:(CGPoint){pX-1,pY-1}];
    }
    if (above && right)
    {
        [self checkSquareForQuadrantAtPosition:(CGPoint){pX,pY-1}];
    }
    if (below && left)
    {
        [self checkSquareForQuadrantAtPosition:(CGPoint){pX-1,pY}];
    }
    if (below && right)
    {
        [self checkSquareForQuadrantAtPosition:(CGPoint){pX,pY}];
    }
}

-(void)updateP1Score
{
    player1Score.text = [NSString stringWithFormat:@"%d", tempPlayer1SquareCount];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
         player1Dot.transform = CGAffineTransformMakeScale(1, 1);
     }completion:^(BOOL b) {
    }];
}

-(void)updateP2Score
{
    player2Score.text = [NSString stringWithFormat:@"%d", tempPlayer2SquareCount];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
         player2Dot.transform = CGAffineTransformMakeScale(1, 1);
     }completion:^(BOOL b) {
    }];
}

- (void)checkSquareForQuadrantAtPosition:(CGPoint)position
{
    int pX = position.x;
    int pY = position.y;
    
    for (UIColor * color in playerColors)
    {                                                             //  0,0  | +1,0   //x and y
        NSInteger player = [playerColors indexOfObject:color];          //  0,-1 | +1,-1
        
        topLeftDot = [NSString stringWithFormat:@"c%dr%d", pX,pY];
        topRightDot = [NSString stringWithFormat:@"c%dr%d", pX+1,pY];
        bottomLeftDot = [NSString stringWithFormat:@"c%dr%d", pX,pY+1];
        bottomRightDot = [NSString stringWithFormat:@"c%dr%d", pX+1,pY+1];
        
        // checks if top left and top right are the same
        BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
        // checks if bottom left and bottom right are the same
        BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
        // checks if top left and bottom left are the same
        BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
        
        //if top, left, & bottom dots the same as player... thenthey own the square
        if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
        {
            static int player1SquareCount = 0;
            static int player2SquareCount = 0;

            if (player == 0) {
                player1SquareCount += 1;
                tempPlayer1SquareCount = player1SquareCount;
                
                [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
                     player1Dot.transform = CGAffineTransformMakeScale(1, -1);
                 }completion:^(BOOL b) {
                    }];
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateP1Score)userInfo:nil repeats:NO];
            }
            else if (player == 1) {
                player2SquareCount += 1;
                tempPlayer2SquareCount = player2SquareCount;
                
                [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations: ^(void){
                     player2Dot.transform = CGAffineTransformMakeScale(1, -1);
                 }completion:^(BOOL b) {
                }];
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateP2Score)userInfo:nil repeats:NO];
            }
            
            currentSquare = allSquares[topLeftDot];

            currentSquare.layer.shadowColor = [UIColor blackColor].CGColor;
            currentSquare.layer.shadowOpacity = 0.75;
            currentSquare.layer.shadowRadius = 15.0;
            currentSquare.layer.shadowOffset = (CGSize){0.0,20.0};
                
            [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState
             animations: ^(void)
             {
                currentSquare.transform = CGAffineTransformMakeScale(1, -1);
             }
                 completion:^(BOOL b) {
                     currentSquare.layer.shadowColor = [UIColor blackColor].CGColor;
                     currentSquare.layer.shadowOpacity = 0.75;
                     currentSquare.layer.shadowRadius = 15.0;
                     currentSquare.layer.shadowOffset = (CGSize){0.0, 20.0};
                    }];
                [UIView animateWithDuration:0.8 animations: ^(void) {
                    currentSquare.backgroundColor = color;
            }];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {return YES;}

@end
