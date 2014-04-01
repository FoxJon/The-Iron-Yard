//
//  CARWheel.h
//  Car
//
//  Created by Jonathan Fox on 4/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CARWheel : UIView

@property (nonatomic) int pressure;
@property (nonatomic) BOOL flat;
@property (nonatomic) NSString * brand;

-(void)fillWithAir;


@end
