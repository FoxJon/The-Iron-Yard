//
//  TLANavController.h
//  TweetLike
//
//  Created by Jonathan Fox on 4/23/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLATableViewController;

@interface TLANavController : UINavigationController

-(void)addTableViewController:(TLATableViewController *)viewController;

@end
