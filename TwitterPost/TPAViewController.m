//
//  TPAViewController.m
//  TwitterPost
//
//  Created by Jonathan Fox on 5/20/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TPAViewController.h"
#import "STTwitter.h"

@interface TPAViewController ()

@end

@implementation TPAViewController
{
    STTwitterAPI * twitter;
    UITextField * tweetField;
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
        
        UIButton * postButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 20, self.view.frame.size.height/2 - 50, 50, 50)];
        postButton.backgroundColor = [UIColor blueColor];
        postButton.layer.cornerRadius = 15;
        [postButton setTitle:@"POST" forState:UIControlStateNormal];
        [postButton addTarget:self action:@selector(postTweet) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:postButton];
        
        tweetField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 20, 200, 165)];
        tweetField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        tweetField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [self.view addSubview:tweetField];
    }
    return self;
}

-(void)postTweet
{
    [twitter postStatusUpdate:tweetField.text inReplyToStatusID:nil latitude:nil longitude:nil placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
        
        NSLog(@"%@", status);

    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
    }];
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
