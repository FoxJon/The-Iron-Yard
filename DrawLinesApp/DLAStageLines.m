//
//  DLAStage.m
//  DrawLinesApp
//
//  Created by Jonathan Fox on 4/15/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "DLAStageLines.h"

@implementation DLAStageLines
{
    NSMutableArray * lines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        lines = [@[]mutableCopy];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    [[UIColor cyanColor] set];                   //line color

    
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context, kCGLineCapRound);

    for (NSArray * line in lines) {
        CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);

        CGPoint start = [line[0] CGPointValue];
        CGPoint end = [line[1] CGPointValue];
    
    
    CGContextMoveToPoint(context, start.x, start.y);
    CGContextAddLineToPoint(context, end.x, end.y);
    
    CGContextStrokePath(context);                           // can fill it or stroke it
    }
}


-(UIColor *)randomColor
{
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //NSLog(@"%@", color);
    return color;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        
        CGPoint location = [touch locationInView:self];
        NSLog(@"TOUCHES BEGAN X = %f Y = %f", location.x, location.y);

        [lines addObject:[@[
                            [NSValue valueWithCGPoint:location],
                            [NSValue valueWithCGPoint:location]
                            ]mutableCopy]];
        [self randomColor];                   //line color

    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
        [lines lastObject][1] = [NSValue valueWithCGPoint:location];
        
        NSLog(@"TOUCHES MOVED X = %f Y = %f", location.x, location.y);
    }
    [self setNeedsDisplay];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
        [lines lastObject][1] = [NSValue valueWithCGPoint:location];
        
        NSLog(@"TOUCHES ENDED X = %f Y = %f", location.x, location.y);
    }
    [self setNeedsDisplay];

}
@end
