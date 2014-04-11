//
//  SCGCircle.h
//  Squares
//
//  Created by Jonathan Fox on 4/11/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCGCircleDelegate;

@interface SCGCircle : UIView

@property (nonatomic, assign) id<SCGCircleDelegate> delegate;  //do not change delegate name.

@property (nonatomic) CGPoint position;

@end

@protocol SCGCircleDelegate <NSObject>

-(UIColor *)circleTappedWithPosition:(CGPoint)position;  // delegate needs to listen to this

@end