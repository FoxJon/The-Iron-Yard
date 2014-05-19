//
//  CBAViewController.m
//  ColorBattle
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CBAViewController.h"
#import "CBARedViewController.h"
#import "CBABlueViewController.h"
#import "CBAData.h"

@interface CBAViewController ()

@end

@implementation CBAViewController
{
    CBARedViewController * redVC;
    CBABlueViewController * blueVC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        redVC = [[CBARedViewController alloc]initWithNibName:nil bundle:nil];
        redVC.view.frame = CGRectMake(0, 0, 320, 240);
        redVC.view.backgroundColor = [UIColor redColor];
        [self.view addSubview:redVC.view];
        
        blueVC = [[CBABlueViewController alloc]initWithNibName:nil bundle:nil];
        blueVC.view.frame = CGRectMake(0, 240, 320, 240);
        blueVC.view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:blueVC.view];
        
        redVC.delegate = self;
        blueVC.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapScreen
{
    NSLog(@"TAP");
    [CBAData mainData].blueScore += 1;
    [CBAData mainData].redScore += 1;
}

-(BOOL)prefersStatusBarHidden {return YES;}


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
