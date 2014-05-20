//
//  SFADisplayViewController.m
//  SFASmileyFace
//
//  Created by Jonathan Fox on 5/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SFADisplayViewController.h"
#import "SFAData.h"
#import "STTwitter.h"

@interface SFADisplayViewController ()

@end

@implementation SFADisplayViewController
{
    int bigSmiliesTag;
    UITextField * tweetField;
    STTwitterAPI * twitter;
    UIButton * twitterButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
        
        
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            
            NSLog(@"%@", username);
            
        } errorBlock:^(NSError *error) {
            
            NSLog(@"%@", error.userInfo);
            
        }];
        
        NSArray * bigSmilies = @[@"yellow1", @"yellow2", @"yellow3", @"yellow4", @"yellow5", @"yellow6", @"yellow7", @"yellow8", @"yellow9"];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        bigSmiliesTag = [SFAData mainData].bigSmiley;

        UIImageView * bigSmileyFrame = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-96, 125, 192, 192)];
        bigSmileyFrame.image = [UIImage imageNamed: bigSmilies[bigSmiliesTag]];
        [self.view addSubview:bigSmileyFrame];
        
        tweetField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 325, 200, 165)];
        tweetField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        tweetField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [self.view addSubview:tweetField];
        
        twitterButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -88, 64, 48, 48)];
        twitterButton.backgroundColor = [UIColor lightGrayColor];
        [twitterButton addTarget:self action:@selector(socialSelector:) forControlEvents:UIControlEventTouchUpInside];
        [twitterButton setImage:[UIImage imageNamed: @"sm_twitter_g.png"] forState:UIControlStateNormal];
        [twitterButton setImage:[UIImage imageNamed: @"sm_twitter.png"] forState:UIControlStateSelected];
        twitterButton.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:twitterButton];
        
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
        
        UIButton * check = [[UIButton alloc]initWithFrame:CGRectMake(128, 500, 64, 40)];
        check.backgroundColor = [UIColor lightGrayColor];
        [check addTarget:self action:@selector(postTweet) forControlEvents:UIControlEventTouchUpInside];
        [check setImage:[UIImage imageNamed: @"check.png"] forState:UIControlStateNormal];
        check.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:check];
        
    }
    return self;
}

-(void)postTweet
{
    if (twitterButton.selected) {
        NSLog(@"I'm On!");
    
        [twitter postStatusUpdate:tweetField.text inReplyToStatusID:nil latitude:nil longitude:nil placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
            
            NSLog(@"Post Me!");

            NSLog(@"%@", tweetField.text);
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@", error.userInfo);
        }];
    }
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

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

-(BOOL)prefersStatusBarHidden{return YES;}


@end
