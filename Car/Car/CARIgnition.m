//
//  CARIgnition.m
//  Car
//
//  Created by Jonathan Fox on 4/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CARIgnition.h"

@implementation CARIgnition

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor greenColor];
        self.layer.cornerRadius = 5;


    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
