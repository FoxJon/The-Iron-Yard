//
//  CBARedViewController.m
//  ColorBattle
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CBARedViewController.h"
#import "CBAData.h"

@interface CBARedViewController ()

@end

@implementation CBARedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        UILabel * redLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 200, 200)];
        redLabel.backgroundColor = [UIColor whiteColor];
        redLabel.text = @"0";
        redLabel.textAlignment = 1;
        redLabel.layer.cornerRadius = 100;
        redLabel.textColor = [UIColor blueColor];
        redLabel.font = [UIFont fontWithName:@"Helvetica" size:80.0];
        redLabel.layer.masksToBounds = YES;
        [self.view addSubview:redLabel];
        
        
    }
    return self;
}

-(void)tapScreen
{
    NSLog(@"TAP");
    [CBAData mainData].redScore += 1;
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
