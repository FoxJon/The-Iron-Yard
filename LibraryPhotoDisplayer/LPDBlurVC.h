//
//  BlurVC.h
//  
//
//  Created by Jonathan Fox on 5/2/14.
//
//

#import <UIKit/UIKit.h>

@protocol BlurViewControllerDelegate;

@interface LPDBlurVC : UIViewController

@property (nonatomic,assign) id<BlurViewControllerDelegate> delegate;

//#warning Please set the imageToFilter
@property(nonatomic)UIImage * imageToFilter;

@end

@protocol BlurViewControllerDelegate <NSObject>

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image;
//-(UIImage *)getFilterImage;

@end
