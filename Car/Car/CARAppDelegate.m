//
//  CARAppDelegate.m
//  Car
//
//  Created by Jonathan Fox on 4/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CARAppDelegate.h"
#import "CARRootViewController.h"

@implementation CARAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [[CARRootViewController alloc] init];
    
    self.window.backgroundColor = [UIColor blueColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
