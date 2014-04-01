//
//  CARRootViewController.m
//  Car
//
//  Created by Jonathan Fox on 4/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CARRootViewController.h"
#import "CARBrake.h"
#import "CARBumper.h"
#import "CARGasPedal.h"
#import "CARIgnition.h"
#import "CARWheel.h"
#import "CARWindow.h"


@interface CARRootViewController ()

@end

@implementation CARRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
// Alloc/init the variables
    CARWheel * wheel1 = [[CARWheel alloc] init];
    CARWheel * wheel2 = [[CARWheel alloc] init];
    CARWheel * wheel3 = [[CARWheel alloc] init];
    CARWheel * wheel4 = [[CARWheel alloc] init];
    CARBumper * carBumper = [[CARBumper alloc] init];
    CARWindow * carWindow1 = [[CARWindow alloc] init];
    CARWindow * carWindow2 = [[CARWindow alloc] init];
    CARIgnition * carIgnition = [[CARIgnition alloc] init];
    CARGasPedal * carGasPedal = [[CARGasPedal alloc] init];
    CARBrake * carBrake = [[CARBrake alloc] init];
    
// set properties
    wheel1.pressure = 40;
    wheel2.pressure = 45;
    wheel3.pressure = 43;
    wheel4.pressure = 39;
    wheel1.flat = NO;
    wheel2.flat = NO;
    wheel3.flat = NO;
    wheel4.flat = YES;
    wheel1.brand = @"Goodyear";
    wheel2.brand = @"Goodyear";
    wheel3.brand = @"Michelin";
    wheel4.brand = @"Michelin";
    carBumper.chrome = YES;
    carBumper.dented = NO;
    carBumper.width = 16;
    carWindow1.open = YES;
    carWindow2.open = NO;
    carWindow1.cracked = YES;
    carWindow2.cracked = NO;
    carWindow1.tinted = YES;
    carWindow2.tinted = NO;
    
// set shapes
    wheel1.frame = CGRectMake(50, 40, 40, 40);
    wheel2.frame = CGRectMake(50, 300, 40, 40);
    wheel3.frame = CGRectMake(200, 40, 40, 40);
    wheel4.frame = CGRectMake(200, 300, 40, 40);
    carBumper.frame = CGRectMake(50, 20, 190, 10);
    carWindow1.frame = CGRectMake(50, 100, 10, 175);
    carWindow2.frame = CGRectMake(225, 100, 10, 175);
    carIgnition.frame = CGRectMake(100, 78, 10, 10);
    carGasPedal.frame = CGRectMake(100, 90, 40, 40);
    carBrake.frame = CGRectMake(60, 90, 40, 40);

    
//add properties to the view controller
    
    [self.view addSubview:wheel1];
    [self.view addSubview:wheel2];
    [self.view addSubview:wheel3];
    [self.view addSubview:wheel4];
    [self.view addSubview:carBrake];
    [self.view addSubview:carBumper];
    [self.view addSubview:carGasPedal];
    [self.view addSubview:carIgnition];
    [self.view addSubview:carWindow1];
    [self.view addSubview:carWindow2];

    [carGasPedal setTitle:@"Rev" forState:UIControlStateNormal];
    
    [carGasPedal addTarget:self action:@selector(pressGasPedal) forControlEvents:UIControlEventTouchUpInside];
    
    [carBrake setTitle:@"!" forState:UIControlStateNormal];
    
    [carBrake addTarget:self action:@selector(pressBrake) forControlEvents:UIControlEventTouchUpInside];
    
 

}

- (void)pressGasPedal
{
    NSLog(@"pressed gas");
}

- (void)pressBrake
{
    NSLog(@"pressed brake");
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
