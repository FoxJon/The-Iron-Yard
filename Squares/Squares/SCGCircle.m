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
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        dotColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [dotColor set];
    
    float dotXY = (self.frame.size.width - 20) /2;
    
    CGContextAddEllipseInRect(context, CGRectMake(dotXY, dotXY, self.frame.size.width / 2.6, self.frame.size.width / 2.6));
    
    CGContextFillPath(context);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //asks for color from VC while giving position of tapped circle
    dotColor = [self.delegate circleTappedWithPosition:self.position];
    
    //redraws layer with the -drawRect method above
    [self setNeedsDisplay];
    
    NSLog(@"My position is row %d, col %d", (int)self.position.x, (int)self.position.y);
}

@end
