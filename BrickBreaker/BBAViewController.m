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

    
    startButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(resetNewGame) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor redColor];
    startButton.layer.cornerRadius = 6;
    
    [self.view addSubview:startButton];

    
    // Do any additional setup after loading the view.
}

- (void)resetNewGame{
    
    [startButton removeFromSuperview];
    
    [level resetLevel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
