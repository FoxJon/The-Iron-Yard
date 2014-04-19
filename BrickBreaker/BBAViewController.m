//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by Jonathan Fox on 4/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BBAViewController.h"
#import "BBALevelController.h"

@interface BBAViewController () <BBALevelDelegate>

@end

@implementation BBAViewController
{
    BBALevelController * level;
    UIButton * startButton;
    UIButton * endButton;
    UILabel * buttonRing;
    UILabel * scoreLabel;
    UILabel * livesLabel;
    UILabel * totalScoreLabel;
    UILabel * highScoreLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
   
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    buttonRing = [[UILabel alloc] initWithFrame:CGRectMake((240 - 125), (160 - 75), 250, 150)];
    buttonRing.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    buttonRing.layer.cornerRadius = 6;
    buttonRing.alpha = 0.1;
    buttonRing.layer.masksToBounds = YES;
    
    [self.view addSubview:buttonRing];

    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake((240 - 100), (160 - 50), 200, 100)];
    
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(resetNewGame) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor redColor];
    startButton.layer.cornerRadius = 6;
    
    [self.view addSubview:startButton];
    // Do any additional setup after loading the view.
}

- (void)resetNewGame
{
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(420, 0, 60, 20)];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self.view addSubview:scoreLabel];
    
    livesLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    livesLabel.backgroundColor = [UIColor clearColor];
    livesLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self.view addSubview:livesLabel];
    
    level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    level.delegate = self;
    
    level.view.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40);
    [self.view addSubview:level.view];
    
    [startButton removeFromSuperview];
    [buttonRing removeFromSuperview];
    [totalScoreLabel removeFromSuperview];
    [highScoreLabel removeFromSuperview];

    
    [level resetLevel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) gameDone:(int)points
{
    
    NSLog(@"Game Done");
    
    [level.view removeFromSuperview];

    [scoreLabel removeFromSuperview];
    [livesLabel removeFromSuperview];
    
    buttonRing = [[UILabel alloc] initWithFrame:CGRectMake((240 - 125), (160 - 75), 250, 150)];
    buttonRing.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    buttonRing.layer.cornerRadius = 6;
    buttonRing.alpha = 0.1;
    buttonRing.layer.masksToBounds = YES;
    
    [self.view addSubview:buttonRing];
    
    
    endButton = [[UIButton alloc] initWithFrame:CGRectMake((240 - 100), (160 - 50), 200, 100)];
    
    [endButton setTitle:@"GAME OVER" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(resetNewGame) forControlEvents:UIControlEventTouchUpInside];
    endButton.backgroundColor = [UIColor redColor];
    endButton.layer.cornerRadius = 6;
    
    [self.view addSubview:endButton];
    
    totalScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 87, 250, 175, 20)];
    totalScoreLabel.backgroundColor = [UIColor clearColor];
    totalScoreLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    totalScoreLabel.text = [NSString stringWithFormat:@"  TOTAL SCORE: %d", points];
    [self.view addSubview:totalScoreLabel];

    highScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 87, 270, 175, 20)];
    highScoreLabel.backgroundColor = [UIColor clearColor];
    highScoreLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    
//   NSMutableArray * highScore = [@[ @"0"] mutableCopy];

//    if (points > [highScore objectAtIndex:0])
//    {
//        [highScore objectAtIndex:0] = points;
//        highScoreLabel.text = [NSString stringWithFormat:@"NEW HIGH SCORE!! %@", [highScore objectAtIndex:0]];
//        [self.view addSubview:highScoreLabel];
//    }
//    else
//    {
    highScoreLabel.text = [NSString stringWithFormat:@"  HIGH SCORE: %d", points];
    [self.view addSubview:highScoreLabel];
//    }
}

-(void)addPoints:(int)points
{
    scoreLabel.text = [NSString stringWithFormat:@"%d", points];
}

-(void)addLives:(int)totalLives
{
    NSLog(@"LIVES");
    livesLabel.text = [NSString stringWithFormat:@"LIVES: %d", totalLives];
}


-(BOOL)prefersStatusBarHidden {return YES;}


@end
