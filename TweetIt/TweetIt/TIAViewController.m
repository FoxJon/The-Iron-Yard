//
//  TIAViewController.m
//  TweetIt
//
//  Created by Jonathan Fox on 4/21/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TIAViewController.h"

@interface TIAViewController ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;

@end



@implementation TIAViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.nameLabel.text = self.tweet[@"name"];
    self.tweetLabel.text = self.tweet[@"text"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {return YES;}

@end
