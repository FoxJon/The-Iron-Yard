//
//  LPAViewController.m
//  LilPlayA
//
//  Created by Jonathan Fox on 5/13/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "LPAViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface LPAViewController ()
{
    AVAudioPlayer * player;
    UIButton * playButton;
    UIButton * pauseButton;
    UIView * progressBar;
    UIView * progressBar2;
    UIView * progressCircle;
    UILabel * currentTimeLabel;
    NSTimeInterval duration;
    float oldX;
    float oldY;
    BOOL dragging;
    UISlider * slider;
    float xPosition;
    CGRect frame;
}

@end

@implementation LPAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIActivityIndicatorView * spinner;
        spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 50);
        spinner.hidesWhenStopped = YES;
        [spinner setColor:[UIColor whiteColor]];
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
        slider = [[UISlider alloc]initWithFrame:CGRectMake(60, 440, 200, 10)];
        [slider addTarget:self action:@selector(sliderVolume:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        
        playButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 100, 100, 100)];
        playButton.backgroundColor = [UIColor whiteColor];
        playButton.layer.cornerRadius = 50;
        [playButton setTitle:@"Play" forState:UIControlStateNormal];
        [playButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [playButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
        [self.view addSubview:playButton];
        
        pauseButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 100, 100, 100)];
        pauseButton.backgroundColor = [UIColor whiteColor];
        pauseButton.layer.cornerRadius = 50;
        [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [pauseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [pauseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
        UIButton * stopButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 300, 100, 100)];
        stopButton.backgroundColor = [UIColor whiteColor];
        stopButton.layer.cornerRadius = 50;
        [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [stopButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [stopButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
        [self.view addSubview:stopButton];
        
        progressBar = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2, 275, 4)];
        progressBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:progressBar];
        
        progressCircle = [[UIView alloc]initWithFrame:CGRectMake(progressBar.frame.origin.x, progressBar.frame.origin.y-8, 20, 20)];
        progressCircle.layer.cornerRadius = 10;
        progressCircle.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:progressCircle];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
        (unsigned long)NULL), ^{
            NSURL * url = [NSURL URLWithString:@"https://api.soundcloud.com/tracks/147445565/download?client_id=2d87025c8392069f828c446b965862e3"];
        
        NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                player = [[AVAudioPlayer alloc]initWithData:data error:nil];
                
                [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
                [pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
                [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
                
                [spinner removeFromSuperview];

                NSLog(@"play");
            });
        });
    }
    return self;
}

-(void)sliderVolume:(UISlider *)sender
{
    NSLog(@"Slider");
    player.volume = sender.value;
}


- (void)updateProgressBar:(NSTimer *)timer {
    NSTimeInterval currentTime = [player currentTime];
    duration = [player duration];
    
    float currentMin = floor(currentTime/60);
    float currentSec = round(currentTime - currentMin * 60);
    
    NSLog(@"Duration %f:", duration);
    NSLog(@"Current Time %f:", currentTime);

    
    float progress = currentTime/duration;
    
    xPosition = progressBar.frame.origin.x + progress * progressBar.frame.size.width;
    
    [progressCircle removeFromSuperview];
    progressCircle = [[UIView alloc]initWithFrame:CGRectMake(xPosition, progressBar.frame.origin.y-8, 20, 20)];
    progressCircle.layer.cornerRadius = 10;
    progressCircle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:progressCircle];
    
    [currentTimeLabel removeFromSuperview];
    currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(progressCircle.frame.origin.x-5, 210, 30, 20)];
    currentTimeLabel.backgroundColor = [UIColor clearColor];
    currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)currentMin, (int)currentSec];
    currentTimeLabel.textAlignment = 1;
    currentTimeLabel.font = [UIFont systemFontOfSize:10];
    currentTimeLabel.textColor = [UIColor whiteColor];
    [self.view  addSubview:currentTimeLabel];
    
    [progressBar2 removeFromSuperview];
    progressBar2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2, xPosition-10, 4)];
    progressBar2.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:progressBar2];
}


- (void)play
{
    player.currentTime = xPosition;

    [playButton removeFromSuperview];
    [player play];
    [self.view addSubview:pauseButton];
    [self updateProgressBar:self.timer];
    
    float totalMin = floor(duration/60);
    float totalSec = round(duration - totalMin * 60);
    
    UILabel * totalTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(progressBar.frame.size.width + 12, progressBar.frame.origin.y - 8, 30, 20)];
    totalTimeLabel.backgroundColor = [UIColor clearColor];
    totalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)totalMin, (int)totalSec];
    totalTimeLabel.textAlignment = 1;
    totalTimeLabel.font = [UIFont systemFontOfSize:10];
    totalTimeLabel.textColor = [UIColor whiteColor];
    [self.view  addSubview:totalTimeLabel];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.23 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
}

- (void)pause
{
    [pauseButton removeFromSuperview];
    [player pause];
    [self.view addSubview:playButton];
    [self.timer invalidate];
    self.timer = nil;

}

-(void)stop
{
    [self.timer invalidate];
    self.timer = nil;
    player.currentTime = 0;
    xPosition = player.currentTime;
    [player stop];
    [pauseButton removeFromSuperview];
    [self.view addSubview:playButton];
    [self updateProgressBar:self.timer];

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches)
    {
        [self.timer invalidate];
        self.timer = nil;
        CGPoint touchLocation = [touch locationInView:self.view];
        
        if (CGRectContainsPoint(progressCircle.frame, touchLocation))
        {
            dragging = YES;
            oldX = touchLocation.x;
            oldY = touchLocation.y;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch* touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:self.view];
        
        if ([[touch.view class] isSubclassOfClass:[UIView class]]) {
            if (dragging) {
                frame = progressCircle.frame;
                frame.origin.x = progressBar.frame.origin.x + touchLocation.x - oldX;
                if (frame.origin.x > self.view.frame.size.width/2-160 && frame.origin.x < self.view.frame.size.width/2+110) {
                    progressCircle.frame = frame;
                }
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    xPosition = frame.origin.x;
    dragging = NO;
    [self play];

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
