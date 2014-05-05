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

@implementation SCGStageVC
{
    int gameSize;
    
   // UIView * home;
    UIView * gameBoard;
    
    NSArray * playerColors;
    
    int playerTurn;
    
    NSMutableDictionary * tappedDots;
    
    NSMutableDictionary * allSquares;
    
    NSString * topLeftDot;
    NSString * topRightDot;
    NSString * bottomLeftDot;
    NSString * bottomRightDot;
    UIButton * startButton;
    UIButton * homeButton;
    UILabel * titleFrame;
    UIButton *playerButton;
    UIButton * gridSize;
    UILabel *player1Label;
    UILabel *player2Label;
    UILabel *player1Dot;
    UILabel *player2Dot;
    UIColor * currentColor;
    SCGSquare * currentSquare;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        playerColors = @[LIGHTBLUE_COLOR, DARKBLUE_COLOR];     // O is lightblue, 1 is darkblue, 2 is white
        
        playerTurn = 0;
        
        tappedDots = [@{}mutableCopy];
        
        allSquares = [@{}mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; //when the view controller loads on the screen
    
    gameBoard = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    homeButton = [[UIButton alloc] initWithFrame:CGRectMake(280, (SCREEN_HEIGHT * 0.03), 18, 18)];

    
}

-(void) viewDidAppear:(BOOL)animated {
    [self loadGameBoard];


}

-(void) loadGameBoard{
   
    [homeButton removeFromSuperview];
    [player1Label removeFromSuperview];
    [player2Label removeFromSuperview];
    [player1Dot removeFromSuperview];
    [player2Dot removeFromSuperview];

    CAGradientLayer *bgLayer = [SCGBackgroundLayer blueGradient];
    bgLayer.frame = gameBoard.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    [self.view addSubview:gameBoard];
    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake(110, (SCREEN_HEIGHT * 0.99), 100, 30)];
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(loadGameElements) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor darkGrayColor];
    startButton.layer.cornerRadius = 6;
    startButton.alpha = 0;
    [gameBoard addSubview:startButton];
//    [MOVE animateView:startButton properties:@{@"y": @(SCREEN_HEIGHT * 0.85),@"duration" : @.8}];
    [MOVE animateView:startButton properties:@{@"y": @(SCREEN_HEIGHT * 0.85),@"alpha":@1.0, @"duration":@1.0}];
    
    titleFrame = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, 200, 200)];
    titleFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    titleFrame.layer.shadowColor = [UIColor blackColor].CGColor;
    titleFrame.layer.shadowOpacity = 0.75;
    titleFrame.layer.shadowRadius = 15.0;
    titleFrame.layer.shadowOffset = (CGSize){0.0,20.0};
    
    [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^(void)
     {
         titleFrame.transform = CGAffineTransformMakeScale(1, -1);
     }
                     completion:^(BOOL b) {
                         titleFrame.layer.shadowColor = [UIColor blackColor].CGColor;
                         titleFrame.layer.shadowOpacity = 0.75;
                         titleFrame.layer.shadowRadius = 15.0;
                         titleFrame.layer.shadowOffset = (CGSize){0.0, 20.0};
                     }];
    [UIView animateWithDuration:0.5 animations: ^(void) {
        titleFrame.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    }];

    [gameBoard addSubview:titleFrame];
    
//    UILabel *sletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(43.5, 100, 35, 35)];
//    sletterFrame.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:sletterFrame];
//    
//    UILabel *qletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(82.5, 100, 35, 35)];
//    qletterFrame.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:qletterFrame];
//    
//    UILabel *uletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(121.5, 100, 35, 35)];
//    uletterFrame.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:uletterFrame];
//    
//    UILabel *aletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(160.5, 100, 35, 35)];
//    aletterFrame.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:aletterFrame];
//    
//    UILabel *rletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(199.5, 100, 35, 35)];
//    rletterFrame.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:rletterFrame];
//    
//    UILabel *eletterFrame = [[UILabel alloc] initWithFrame:CGRectMake(238.5, 100, 35, 35)];
//    eletterFrame.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:eletterFrame];

    playerButton = [[UIButton alloc] initWithFrame:CGRectMake(60, (SCREEN_HEIGHT * 0.99), 200, 30)];
    [playerButton setTitle:@"1 PLAYER | 2 PLAYERS" forState:UIControlStateNormal];
    [playerButton addTarget:self action:@selector(loadGameElements) forControlEvents:UIControlEventTouchUpInside];
    playerButton.backgroundColor = [UIColor darkGrayColor];
    playerButton.layer.cornerRadius = 6;
    playerButton.alpha = 0;
    [gameBoard addSubview:playerButton];
   // [MOVE animateView:playerButton properties:@{@"y": @(SCREEN_HEIGHT * 0.65),@"duration" : @.8}];
    [MOVE animateView:playerButton properties:@{@"y": @(SCREEN_HEIGHT * 0.65),@"alpha":@1.0, @"duration":@1.0}];

    
    gridSize = [[UIButton alloc] initWithFrame:CGRectMake(125, (SCREEN_HEIGHT * 0.99), 70, 30)];
    [gridSize setTitle:@"4 | 6 | 8" forState:UIControlStateNormal];
    [gridSize addTarget:self action:@selector(loadGameElements) forControlEvents:UIControlEventTouchUpInside];
    gridSize.backgroundColor = [UIColor darkGrayColor];
    gridSize.layer.cornerRadius = 6;
    gridSize.alpha = 0;
    [gameBoard addSubview:gridSize];
    //[MOVE animateView:gridSize properties:@{@"y": @(SCREEN_HEIGHT * 0.75),@"duration" : @.8}];
    [MOVE animateView:gridSize properties:@{@"y": @(SCREEN_HEIGHT * 0.75),@"alpha":@1.0, @"duration":@1.0}];
    
}
- (void)checkGameSize{
    
    gameSize = 6;

}

-(void)loadGameElements{
    
    [startButton removeFromSuperview];
    [titleFrame removeFromSuperview];
    [playerButton removeFromSuperview];
    [gridSize removeFromSuperview];

    [homeButton setTitle:@"H" forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(loadGameBoard) forControlEvents:UIControlEventTouchUpInside];
    homeButton.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    homeButton.layer.cornerRadius = 6;
    [gameBoard addSubview:homeButton];
    
    player1Label = [[UILabel alloc] initWithFrame:CGRectMake(-100, (SCREEN_HEIGHT * 0.03), 90, 18)];
    player1Label.text = @" PLAYER 1";
    player1Label.textColor = [UIColor whiteColor];
    player1Label.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.5f];
    player1Label.layer.cornerRadius = 6;
    player1Label.layer.masksToBounds = YES;
    [gameBoard addSubview:player1Label];
    [MOVE animateView:player1Label properties:@{@"x": @20,@"duration" : @1.0}];
    
    player1Dot = [[UILabel alloc] initWithFrame:CGRectMake(-100, (SCREEN_HEIGHT * 0.03), 18, 18)];
    player1Dot.backgroundColor = LIGHTBLUE_COLOR;
    player1Dot.layer.cornerRadius = 9;
    player1Dot.layer.masksToBounds = YES;
    [gameBoard addSubview:player1Dot];
    [MOVE animateView:player1Dot properties:@{@"x": @120,@"duration" : @1.0}];
    
    player2Label = [[UILabel alloc] initWithFrame:CGRectMake(-100, (SCREEN_HEIGHT * 0.08), 90, 18)];
    player2Label.text = @" PLAYER 2";
    player2Label.textColor = [UIColor whiteColor];
    player2Label.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
    player2Label.layer.cornerRadius = 6;
    player2Label.layer.masksToBounds = YES;
    [gameBoard addSubview:player2Label];
    [MOVE animateView:player2Label properties:@{@"x": @20,@"duration" : @1.0}];
    
    player2Dot = [[UILabel alloc] initWithFrame:CGRectMake(-100, (SCREEN_HEIGHT * 0.08), 18, 18)];
    player2Dot.backgroundColor = DARKBLUE_COLOR;
    player2Dot.layer.cornerRadius = 9;
    player2Dot.layer.masksToBounds = YES;
    [gameBoard addSubview:player2Dot];
    [MOVE animateView:player2Dot properties:@{@"x": @120,@"duration" : @1.0}];




    [self checkGameSize];
    
    float circleWidth = SCREEN_WIDTH / gameSize;
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
            
            SCGSquare * square = [[SCGSquare alloc] initWithFrame:CGRectMake(squareX, squareY, squareWidth, squareWidth)];
            
            square.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1f];
            square.layer.cornerRadius = 0;
            
            
            NSString * key = [NSString stringWithFormat:@"c%dr%d",sCol,sRow]; //0,1 will say c0r1
            
            allSquares[key] = square;
            
            [self.view addSubview:square];
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
            
            [self.view addSubview:circle];
            [MOVE animateView:circle properties:@{@"alpha":@1, @"duration":@0.2,@"delay":@0.3}];

        }
    }
    
}

-(UIColor *)circleTappedWithPosition:(CGPoint)position{
    
    //get tapped key from position
    NSString * key = [NSString stringWithFormat:@"c%dr%d", (int)position.x, (int)position.y];
    
    //set player num to value in tapped dots
    //if ([tappedDots[key]  isEqual: @(0)] || [tappedDots[key]  isEqual: @(1)]) {
//    if ([tappedDots[key]  isEqual: @(playerTurn)])
//    {
//        NSLog(@"IF");
//        tappedDots[key] = @(playerTurn);
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"You selected your own color. Try again." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [self highlightPlayerLabel];
//        return playerColors[playerTurn];
//    }
//    else if (![tappedDots[key] isEqual: @(0)] && ![tappedDots[key] isEqual: @(2)])
//    {
//      //  tappedDots[key] = @(playerTurn);
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"That color has already been taken. Try again." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        NSLog(@"ELSE IF");
//     //   currentColor = playerColors[playerTurn];
//        [self highlightPlayerLabel];
//        return playerColors[1];
//    }
//    else if (![tappedDots[key] isEqual: @(1)] && ![tappedDots[key] isEqual: @(2)])
//    {
//        //  tappedDots[key] = @(playerTurn);
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"That color has already been taken. Try again." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        NSLog(@"ELSE IF");
//        //   currentColor = playerColors[playerTurn];
//        [self highlightPlayerLabel];
//        return playerColors[0];
//    }
//    else
//    {
        NSLog(@"ELSE");
        tappedDots[key] = @(playerTurn);
    
        // set player num to value in tappedDots
        [self checkForSquareAroundPosition:position];
        
        // check for square
        currentColor = playerColors[playerTurn];
        playerTurn = (playerTurn) ? 0 : 1;
        [self highlightPlayerLabel];
        return currentColor;
//    }
}

-(void)circleFlip
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState
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
}

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

- (void)checkSquareForQuadrantAtPosition:(CGPoint)position
{
    int pX = position.x;
    int pY = position.y;
    
    for (UIColor * color in playerColors)
    {                                                           //  0,0  | +1,0   //x and y
        int player = [playerColors indexOfObject:color];          //  0,-1 | +1,-1
        
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
                NSLog(@"player1 Square Count = %d", player1SquareCount);
            }
            else if (player == 1) {
                player2SquareCount += 1;
                NSLog(@"player2 Square Count = %d", player2SquareCount);
            }
            
            currentSquare = allSquares[topLeftDot];

            currentSquare.layer.shadowColor = [UIColor blackColor].CGColor;
            currentSquare.layer.shadowOpacity = 0.75;
            currentSquare.layer.shadowRadius = 15.0;
            currentSquare.layer.shadowOffset = (CGSize){0.0,20.0};
                
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState
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
                [UIView animateWithDuration:0.5 animations: ^(void) {
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

//-(void)flipAnimation
//{
//     [UIView animateWithDuration:1.0 animations:^{
//        currentSquare.backgroundColor = [UIColor blackColor];
//        
//        currentSquare.layer.shadowColor = [UIColor blackColor].CGColor;
//        currentSquare.layer.shadowOpacity = 0.75;
//        currentSquare.layer.shadowRadius = 15.0;
//        currentSquare.layer.shadowOffset = (CGSize){0.0,20.0};
//        
//        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState
//                         animations: ^(void) {
//                             currentSquare.transform = CGAffineTransformMakeScale(-1, 1);
//                         }
//                         completion:^(BOOL b) {
//                             currentSquare.layer.shadowColor = [UIColor blackColor].CGColor;
//                             currentSquare.layer.shadowOpacity = 0.75;
//                             currentSquare.layer.shadowRadius = 15.0;
//                             currentSquare.layer.shadowOffset = (CGSize){0.0, 20.0};
//                         }];
//    }];
//}

@end
