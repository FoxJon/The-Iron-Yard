//
//  LPSFilterController.h
//  LibraryPhotoDisplayer
//
//  Created by Jonathan Fox on 5/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPDFilterControllerDelegate;

@interface LPDFilterController : UIViewController

@property (nonatomic, assign) id<LPDFilterControllerDelegate> delegate;

@property (nonatomic) UIImage * imageToFilter;

@end

@protocol LPDFilterControllerDelegate <NSObject>

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image;

@end
