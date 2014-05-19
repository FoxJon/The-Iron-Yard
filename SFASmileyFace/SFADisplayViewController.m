//
//  SFADisplayViewController.m
//  SFASmileyFace
//
//  Created by Jonathan Fox on 5/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SFADisplayViewController.h"
#import "SFAData.h"

@interface SFADisplayViewController ()

@end

@implementation SFADisplayViewController
{
    int bigSmiliesTag;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSArray * bigSmilies = @[@"yellow1", @"yellow2", @"yellow3", @"yellow4", @"yellow5", @"yellow6", @"yellow7", @"yellow8", @"yellow9"];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        bigSmiliesTag = [SFAData mainData].bigSmiley;

        UIImageView * bigSmileyFrame = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-96, self.view.frame.size.height/2-96, 192, 192)];
        bigSmileyFrame.image = [UIImage imageNamed: bigSmilies[bigSmiliesTag]];
        [self.view addSubview:bigSmileyFrame];
        
        UIButton * twitter = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -88, 64, 48, 48)];
        twitter.backgroundColor = [UIColor lightGrayColor];
        [twitter addTarget:self action:@selector(socialSelector:) forControlEvents:UIControlEventTouchUpInside];
        [twitter setImage:[UIImage imageNamed: @"sm_twitter_g.png"] forState:UIControlStateNormal];
        [twitter setImage:[UIImage imageNamed: @"sm_twitter.png"] forState:UIControlStateSelected];
        twitter.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:twitter];
        
        UIButton * facebook;facebook = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -24, 64, 48, 48)];
        facebook.backgroundColor = [UIColor lightGrayColor];
        [facebook setImage:[UIImage imageNamed: @"sm_facebook_g.png"] forState:UIControlStateNormal];
        [facebook setImage:[UIImage imageNamed: @"sm_facebook.png"] forState:UIControlStateSelected];
        [facebook addTarget:self action:@selector(socialSelector:) forControlEvents:UIControlEventTouchUpInside];
        facebook.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:facebook];
        
        UIButton * google = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+40, 64, 48, 48)];
        google.backgroundColor = [UIColor lightGrayColor];
        [google addTarget:self action:@selector(socialSelector:) forControlEvents:UIControlEventTouchUpInside];
        [google setImage:[UIImage imageNamed: @"sm_google_g.png"] forState:UIControlStateNormal];
        [google setImage:[UIImage imageNamed: @"sm_google.png"] forState:UIControlStateSelected];

        google.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:google];
        
        UIButton * check = [[UIButton alloc]initWithFrame:CGRectMake(128, 486, 64, 40)];
        check.backgroundColor = [UIColor lightGrayColor];
        [check addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [check setImage:[UIImage imageNamed: @"check.png"] forState:UIControlStateNormal];
        check.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:check];
        
    }
    return self;
}

-(void)socialSelector:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
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

-(BOOL)prefersStatusBarHidden{return YES;}


@end
