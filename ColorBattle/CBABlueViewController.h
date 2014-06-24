//
//  CBABlueViewController.h
//  ColorBattle
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

//Forward declaration of ChildViewControllerDelegate
@protocol CBABlueViewControllerDelegate;

//Declaration of the view controller class, as usual
@interface CBABlueViewController : UIViewController

// Delegate properties should always be weak references
@property (nonatomic, weak) id<CBABlueViewControllerDelegate> delegate;

@end

// Definition of the delegate's interface and required method
@protocol CBABlueViewControllerDelegate <NSObject>

-(void)tapScreen;


@end
