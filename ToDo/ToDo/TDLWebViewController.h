//
//  TDLWebViewController.h
//  ToDo
//
//  Created by Jonathan Fox on 4/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDLWebViewController : UIViewController

@property (strong, nonatomic) NSURL *gitHubUrl;
@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end
