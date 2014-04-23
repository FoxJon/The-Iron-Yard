//
//  TLANavController.m
//  TweetLike
//
//  Created by Jonathan Fox on 4/23/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TLANavController.h"

@interface TLANavController () <UITextViewDelegate>

@end

@implementation TLANavController
{
    UIButton * addNewButton;
    UIButton * submitButton;
    UIButton * cancelButton;
    UIView * blueBox;
    UITextView * newCaption;
    UIImageView * logo;
    UIView * newForm;
}


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
       // self.navigationBar.barTintColor = [UIColor blueColor];
       // self.navigationBar.translucent = YES;
        
        blueBox = [[UIView alloc]initWithFrame:self.navigationBar.frame];
        blueBox.backgroundColor = [UIColor blueColor];
        [self.view addSubview:blueBox];
        
        newForm = [[UIView alloc] initWithFrame:self.view.frame];
      //  newForm.backgroundColor = [UIColor clearColor];
        [blueBox addSubview:newForm];
        
        addNewButton = [[UIButton alloc] initWithFrame:CGRectMake(80, (self.navigationBar.frame.size.height-30)/2, 160, 30)];
        addNewButton.backgroundColor = [UIColor whiteColor];
        addNewButton.layer.cornerRadius = 15;
        [addNewButton addTarget:self action:@selector(newItem:) forControlEvents:UIControlEventTouchUpInside];
        [addNewButton setTitle:@"Add New" forState:UIControlStateNormal];
        addNewButton.titleLabel.textColor = [UIColor lightGrayColor];

        [blueBox addSubview:addNewButton];
        
        newCaption = [[UITextView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-125, (self.view.frame.size.height/2)-75, 250, 150)];
        newCaption.backgroundColor = [UIColor whiteColor];
        newCaption.textColor = [UIColor darkGrayColor];
        newCaption.layer.cornerRadius = 6;
        newCaption.delegate = self;
        newCaption.font = [UIFont systemFontOfSize:13];
        
        logo = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-87.5, (self.view.frame.size.height/2)-125, 175, 45)];
        logo.contentMode = UIViewContentModeScaleAspectFit;
        logo.image = [UIImage imageNamed:@"logo"];
        
        submitButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2-125), (self.view.frame.size.height/2)+100, 100, 30)];
        submitButton.backgroundColor = [UIColor greenColor];
        submitButton.layer.cornerRadius = 15;
   //     [submitButton addTarget:self action:@selector(newTweet:) forControlEvents:UIControlEventTouchUpInside];
        [submitButton setTitle:@"Submit" forState:UIControlStateNormal],
        submitButton.titleLabel.textColor = [UIColor whiteColor];
        
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)+25, (self.view.frame.size.height/2)+100, 100, 30)];
        cancelButton.backgroundColor = [UIColor redColor];
        cancelButton.layer.cornerRadius = 15;
        [cancelButton addTarget:self action:@selector(reloadTweets) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:@"cancel" forState:UIControlStateNormal],
        cancelButton.titleLabel.textColor = [UIColor whiteColor];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -100, 320, self.view.frame.size.height);
    }];
}

-(void)tapScreen
{
    [newCaption resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
}

- (void)reloadTweets
{
    [UIView animateWithDuration:0.4 animations:^{
    blueBox.frame = self.navigationBar.frame;
        
    newForm.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    
    
    [newCaption removeFromSuperview];
    [submitButton removeFromSuperview];
    [cancelButton removeFromSuperview];
    [logo removeFromSuperview];
    [blueBox addSubview:addNewButton];

    }completion:^(BOOL finished) {
    addNewButton.alpha = 1.0;
    [addNewButton setTitle:@"Add New" forState:UIControlStateNormal];
    addNewButton.titleLabel.textColor = [UIColor lightGrayColor];

        }];
}


-(void)newItem:(UIButton *)sender;
{
    
  
    [UIView animateWithDuration:0.4 animations:^{
        
        blueBox.frame = self.view.frame;

        addNewButton.alpha = 0.0;
    }completion:^(BOOL finished) {
     
        [newForm addSubview:newCaption];
        [newForm addSubview:logo];
        [newForm addSubview:submitButton];
        [newForm addSubview:cancelButton];
    }];
}

//-(void)newTweet
//{
//    [tweetItems insertObject:@{@"likes":@0, @"caption":@"Hello"} atIndex:0];
//    NSLog(@"%@", tweetItems);
//}

- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) String
{
    if ([String isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
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
