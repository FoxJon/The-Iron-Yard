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
    
    CGContextClearRect(context, rect);
    
    
    [[UIColor cyanColor] set];                   //line color

    
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    [self.lineColor set];

    for (NSDictionary * line in lines) {
//        CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
        
        CGContextSetLineWidth(context, [line[@"width"] floatValue]);
        [(UIColor * )line[@"color"] set];
        

        CGPoint start = [line[@"points"][0] CGPointValue];
        CGPoint end = [line[@"points"][1] CGPointValue];
    
    
        CGContextMoveToPoint(context, start.x, start.y);
        CGContextAddLineToPoint(context, end.x, end.y);
        
        CGContextStrokePath(context);                           // can fill it or stroke it
    
    }

}


//-(UIColor *)randomColor
//{
//    CGFloat red = arc4random_uniform(255) / 255.0;
//    CGFloat green = arc4random_uniform(255) / 255.0;
//    CGFloat blue = arc4random_uniform(255) / 255.0;
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    //NSLog(@"%@", color);
//    return color;
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch * touch in touches) {
        
        CGPoint location = [touch locationInView:self];

//        [lines addObject:[@[
//                            [NSValue valueWithCGPoint:location],
//                            [NSValue valueWithCGPoint:location]
//                            ]mutableCopy]];
        
        [lines addObject:[@{
                                @"color" : self.lineColor,
                                @"width" : @(self.lineWidth),
                                @"points" : [@[
                                               [NSValue valueWithCGPoint:location],
                                               [NSValue valueWithCGPoint:location]
                                               ]mutableCopy]
                                }mutableCopy]];
        
        NSLog(@"TOUCHES BEGAN X = %f Y = %f", location.x, location.y);


 //       [self randomColor];                   //line color

    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
//        [lines lastObject][1] = [NSValue valueWithCGPoint:location];
        [lines lastObject][@"points"][1] = [NSValue valueWithCGPoint:location];

        
        NSLog(@"TOUCHES MOVED X = %f Y = %f", location.x, location.y);
    }
    [self setNeedsDisplay];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
//        [lines lastObject][1] = [NSValue valueWithCGPoint:location];
        [lines lastObject][@"points"][1] = [NSValue valueWithCGPoint:location];

        
        NSLog(@"TOUCHES ENDED X = %f Y = %f", location.x, location.y);
    }
    [self setNeedsDisplay];

}
@end
