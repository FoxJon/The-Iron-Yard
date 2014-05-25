//
//  EDAViewController.m
//  EggDrop
//
//  Created by Jonathan Fox on 5/22/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "EDAViewController.h"
#import "EDASounds.h"

#import <CoreMotion/CoreMotion.h>


@interface EDAViewController ()

@end

@implementation EDAViewController
{
    CMMotionManager * mManager;
    
    BOOL eggIsFalling;
    
    float eggMidX;
    float spoonMidX;
    
    EDASounds * sounds;
    EDASounds * chkEnd;
    UIButton * resetButton;
    
    UIImageView * brokenEggFrame;
    
    float oldX;
    float oldY;
    float xPosition;
    BOOL dragging;
    CGRect frame;


}

- (void)viewDidLoad
{
    NSLog(@"viewdidload");
   
    [super viewDidLoad];

    mManager = [[CMMotionManager alloc]init];
    
    sounds = [[EDASounds alloc]init];
    chkEnd = [[EDASounds alloc]init];
    
    [self loadGame];
}

-(void)loadGame
{
    NSLog(@"load");
    
    self.egg.image = [UIImage imageNamed:@"egg"];
    
    dragging = YES;
    
    resetButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, SCREEN_HEIGHT - 50, 70, 20)];
    [resetButton addTarget:self action:@selector(loadGame) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setTitle:@"Restart" forState:UIControlStateNormal];
    resetButton.titleLabel.textColor = [UIColor blueColor];
    resetButton.backgroundColor = [UIColor whiteColor];
    resetButton.layer.cornerRadius = 6;
    [self.view addSubview:resetButton];
    
    if (eggIsFalling == YES) {
        
        float x = spoonMidX - self.egg.frame.size.width;
        float y = spoonMidX - self.egg.frame.size.width - 10;
        float w = self.egg.frame.size.width * 2;
        float h = self.egg.frame.size.height * 2;
        
        self.egg.frame = CGRectMake(x, y, w, h);
    }
    
    [sounds playSoundWithName:@"chkLoop" loops:-1];

    
    eggIsFalling = NO;
 
    
    [mManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        float roll = motion.attitude.roll * 20;
        
        if (!eggIsFalling) self.egg.frame = CGRectOffset(self.egg.frame, roll, 0);
        
        eggMidX = CGRectGetMidX(self.egg.frame);
        spoonMidX = CGRectGetMidX(self.spoon.frame);
        
        if (fabs(spoonMidX - eggMidX) > self.egg.frame.size.width/2.0 && !eggIsFalling)//float absolute
        {
            eggIsFalling = YES;
            dragging = NO;
            [sounds playSoundWithName:@"silence" loops:0];
            
            [UIView animateWithDuration:0.5 animations:^{
                
                float x = self.egg.frame.origin.x + self.egg.frame.size.width / 4.0;
                float y = self.egg.frame.origin.y + self.egg.frame.size.height / 4.0;
                float w = self.egg.frame.size.width / 2.0;
                float h = self.egg.frame.size.height / 2.0;

                if (eggMidX < self.spoon.frame.size.width/2) {
                    self.egg.frame = CGRectMake(x - 35, y, w, h);
                }else if (eggMidX > self.spoon.frame.size.width/2)
                    self.egg.frame = CGRectMake(x + 35, y, w, h);
            } completion:^(BOOL finished) {
                [sounds playSoundWithName:@"EggCrack" loops:0];
                [chkEnd playSoundWithName:@"chkEnd" loops:0];
                
                self.egg.image = [UIImage imageNamed:@"brokenegg"];
                
            }];
        }
    }];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (dragging) {
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.view];
        
        if(CGRectContainsPoint(self.spoon.frame, location))
        {
            self.spoon.frame = CGRectMake(location.x - 160, self.spoon.frame.origin.y, self.spoon.frame.size.width, self.spoon.frame.size.height);
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
