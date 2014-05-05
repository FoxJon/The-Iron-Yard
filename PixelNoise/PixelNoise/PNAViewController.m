//
//  PNARootViewController.m
//  PixelNoise
//
//  Created by Jonathan Fox on 5/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PNAViewController.h"
#import "PNAPixelSounds.h"


@interface PNAViewController ()

@end

@implementation PNAViewController
{
    PNAPixelSounds * sounds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        sounds = [[PNAPixelSounds alloc]init];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"play sound");
    [sounds playSoundWithName:@"click_alert"];
    
 //   This will not play because the sound closes out before it plays.
//    PNAPixelSounds * sound_obj = [[PNAPixelSounds alloc]init];
//    [sound_obj playSoundWithName:@"click_alert"];]
}

-(BOOL)prefersStatusBarHidden {return YES;}


@end
