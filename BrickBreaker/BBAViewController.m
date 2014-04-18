//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by Jonathan Fox on 4/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BBAViewController.h"
#import "BBALevelController.h"


@interface BBAViewController () 

@end

@implementation BBAViewController
{
    BBALevelController * level;
    UIButton * startButton;
    UILabel * startButtonRing;
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
    
    level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    
    [self.view addSubview:level.view];

    
    
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

- (void)resetNewGame{
    
    [startButton removeFromSuperview];
    [startButtonRing removeFromSuperview];
    
    [level resetLevel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
