//
//  CBABlueViewController.m
//  ColorBattle
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CBABlueViewController.h"
#import "CBAData.h"

@interface CBABlueViewController ()

@end

@implementation CBABlueViewController
{
    UILabel * blueLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 200, 200)];
        blueLabel.backgroundColor = [UIColor whiteColor];
        blueLabel.layer.cornerRadius = 100;
        blueLabel.text = @"0";
        blueLabel.textAlignment = 1;
        blueLabel.textColor = [UIColor blueColor];
        blueLabel.font = [UIFont fontWithName:@"Helvetica" size:80.0];
        blueLabel.layer.masksToBounds = YES;
        [self.view addSubview:blueLabel];
        
        
    }
    return self;
}


-(void)tapScreen
{
    NSLog(@"TAP");
    [CBAData mainData].blueScore += 1;
    int total = [CBAData mainData].blueScore;
    blueLabel.text = [NSString stringWithFormat:@"%d", total];
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
