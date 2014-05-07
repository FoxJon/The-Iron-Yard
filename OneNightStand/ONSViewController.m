//
//  ONSViewController.m
//  OneNightStand
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "ONSViewController.h"
#import "ONSData.h"
#import "ONSSecondViewController.h"

@interface ONSViewController ()

@end

@implementation ONSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [ONSData mainData].controllerName = @"ViewController";
        
        NSLog(@"ViewController init %@", [ONSData mainData].controllerName);
        
        ONSSecondViewController * secondVC = [[ONSSecondViewController alloc]initWithNibName:nil bundle:nil];
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
