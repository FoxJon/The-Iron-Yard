//
//  DPAPondViewController.m
//  DigitalPond
//
//  Created by Jonathan Fox on 5/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "DPAPondViewController.h"
#import "DPARipple.h"

@interface DPAPondViewController ()

@end

@implementation DPAPondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self createRipplesWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self createRipplesWithTouches:touches];
}

-(void)createRipplesWithTouches:(NSSet *)touches
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self.view];
        DPARipple * ripple = [[DPARipple alloc]initWithFrame:CGRectMake(location.x, location.y, 0, 0)];
        
        ripple.rippleCount = 3;
        ripple.rippleLifeTime = 2;
        
        [self.view addSubview:ripple];
    }
}

-(BOOL)prefersStatusBarHidden {return YES;}

@end
