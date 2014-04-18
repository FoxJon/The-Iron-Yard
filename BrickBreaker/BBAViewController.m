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
    UILabel * startButtonRing;
    UILabel * endButtonRing;
    UIButton * endButton;
    UILabel * scoreLabel;
    UILabel * livesLabel;
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
    
    

    
    startButtonRing = [[UILabel alloc] initWithFrame:CGRectMake((240 - 125), (160 - 75), 250, 150)];
    startButtonRing.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    startButtonRing.layer.cornerRadius = 6;
    startButtonRing.alpha = 0.1;
    startButtonRing.layer.masksToBounds = YES;
    
    [self.view addSubview:startButtonRing];

    
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
    [startButtonRing removeFromSuperview];
    
    [level resetLevel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) gameDone{
    
    NSLog(@"Game Done");
    
    [level.view removeFromSuperview];
    [self endGameWin];

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

-(void) endGameWin
{
    [scoreLabel removeFromSuperview];
    [livesLabel removeFromSuperview];
    
    endButtonRing = [[UILabel alloc] initWithFrame:CGRectMake((240 - 125), (160 - 75), 250, 150)];
    endButtonRing.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
    endButtonRing.layer.cornerRadius = 6;
    endButtonRing.alpha = 0.1;
    endButtonRing.layer.masksToBounds = YES;
    
    [self.view addSubview:endButtonRing];
    
    
    endButton = [[UIButton alloc] initWithFrame:CGRectMake((240 - 100), (160 - 50), 200, 100)];
    
    [endButton setTitle:@"YOU WIN" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(resetNewGame) forControlEvents:UIControlEventTouchUpInside];
    endButton.backgroundColor = [UIColor redColor];
    endButton.layer.cornerRadius = 6;
    
    [self.view addSubview:endButton];
}

-(BOOL)prefersStatusBarHidden {return YES;}


@end
