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

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        playerColors = @[RED_COLOR, GREEN_COLOR];     // O is red, 1 is green, 2 is grey
        
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
    startButton = [[UIButton alloc] initWithFrame:CGRectMake(110, (SCREEN_HEIGHT * 0.85), 100, 30)];
    homeButton = [[UIButton alloc] initWithFrame:CGRectMake(110, (SCREEN_HEIGHT * 0.10), 100, 30)];

    [self loadGameBoard];
    
}

-(void) viewWillAppear:(BOOL)animated {
   

}

-(void) loadGameBoard{
    
    CAGradientLayer *bgLayer = [SCGBackgroundLayer blueGradient];
    bgLayer.frame = gameBoard.bounds;
    [gameBoard.layer insertSublayer:bgLayer atIndex:0];
    
    [self.view addSubview:gameBoard];
    
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(loadGameElements) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor darkGrayColor];
    startButton.layer.cornerRadius = 6;
    [gameBoard addSubview:startButton];
}

-(void)loadGameElements{
    
    [startButton removeFromSuperview];
   
    [homeButton setTitle:@"HOME" forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(viewDidLoad) forControlEvents:UIControlEventTouchUpInside];
    homeButton.backgroundColor = [UIColor darkGrayColor];
    homeButton.layer.cornerRadius = 6;
    [gameBoard addSubview:homeButton];

    gameSize = 6;
    
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
        }
    }
    
}

-(UIColor *)circleTappedWithPosition:(CGPoint)position{
    
    //get tapped key from position
    NSString * key = [NSString stringWithFormat:@"c%dr%d", (int)position.x, (int)position.y];
    
    //set player num to value in tapped dots
//    if (tappedDots[key] == (tappedDots[key])) {
//        NSLog(@"change to grey");
//    }else{
        tappedDots[key] = @(playerTurn);
//    }
    
    // set player num to value in tappedDots
    [self checkForSquareAroundPosition:position];
    
    // check for square
    UIColor * currentColor = playerColors[playerTurn];
    playerTurn = (playerTurn) ? 0 : 1;
    return currentColor;
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
            SCGSquare * currentSquare = allSquares[topLeftDot];
            
            currentSquare.backgroundColor = color;
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
