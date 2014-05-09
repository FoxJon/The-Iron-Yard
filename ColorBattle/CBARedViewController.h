//
//  CBARedViewController.h
//  ColorBattle
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBARedViewControllerDelegate;

@interface CBARedViewController : UIViewController

@property (nonatomic, assign) id<CBARedViewControllerDelegate> delegate;

@end

@protocol CBARedViewControllerDelegate <NSObject>

-(void)tapScreen;


@end