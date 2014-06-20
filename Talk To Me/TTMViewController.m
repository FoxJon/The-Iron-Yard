//
//  TTMViewController.m
//  Talk To Me
//
//  Created by Jonathan Fox on 6/9/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TTMViewController.h"
#import <Parse/Parse.h>

@interface TTMViewController ()

@end

@implementation TTMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Subscribe to a channel
        
        PFInstallation * currentInstallation = [PFInstallation currentInstallation];
        
        [currentInstallation addUniqueObject:@"Braves" forKey:@"channels"];
        //channels is a Parse thing
        
        [currentInstallation saveInBackground];
        
        //push to channel
        
        PFPush * push = [[PFPush alloc]init];
        [push setChannel:@"Braves"];
        
        [push setMessage:@"Braves Win!"];
        
        [push sendPushInBackground];
        
        //Push based on query
        PFQuery * query = [PFQuery queryWithClassName:@"User"];
        [query whereKey:@"age" greaterThan:@(20)];
        
        PFPush * pushWithQuery = [[PFPush alloc]init];
        [pushWithQuery setQuery:query];
        [pushWithQuery setMessage:@"Beer is Awesome!"];
        [pushWithQuery sendPushInBackground];
        
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

@end
