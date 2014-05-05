//
//  SCGCircle.m
//  Squares
//
//  Created by Jonathan Fox on 4/11/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SCGCircle.h"

@implementation SCGCircle
{
    UIColor * dotColor;
    float dotWidth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        dotColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        
        dotWidth = frame.size.width/3;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [dotColor set];
    
    float dotXY = (self.frame.size.width - dotWidth) /2;
    
    CGContextAddEllipseInRect(context, CGRectMake(dotXY, dotXY, dotWidth, dotWidth));
    
    CGContextFillPath(context);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //asks for color from VC while giving position of tapped circle
    dotColor = [self.delegate circleTappedWithPosition:self.position];
    
    //redraws layer with the -drawRect method above
    [self setNeedsDisplay];
    
   // NSLog(@"My position is col %d, row %d", (int)self.position.x, (int)self.position.y);
}

@end
