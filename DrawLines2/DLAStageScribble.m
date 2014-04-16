//
//  DLAStageScribble.m
//  DrawLinesApp
//
//  Created by Jonathan Fox on 4/15/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "DLAStageScribble.h"

@implementation DLAStageScribble


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //defaults
        self.lineWidth = 2.0;
        self.lineColor = [UIColor colorWithWhite:0.3 alpha:1.0];
       
        // Initialization code
        self.lines = [@[]mutableCopy];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)clearStage{
    NSLog(@"Clear Here");

    [self.lines removeAllObjects];
    [self setNeedsDisplay];
}

-(void)undo{
    NSLog(@"Undo Here");

    [self.lines removeLastObject];
    [self setNeedsDisplay];
}


-(void)setLineWidth:(float)lineWidth{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}


- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)changeLineColor: (UIButton *) sender{
    [self setLineColor:sender.backgroundColor];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextMoveToPoint(context, 50, 50);
    CGContextAddCurveToPoint(context, 270, 50, 270, 400, 50, 400);    //control"anchor" point
    
//    CGContextAddEllipseInRect(<#CGContextRef context#>, <#CGRect rect#>);
//    CGContextFillPath(<#CGContextRef c#>);
    
    CGContextSetLineWidth(context, self.lineWidth);
    [self.lineColor set];

    CGContextStrokePath(context);                           // can fill it or stroke it

   // CGContextClearRect(context, rect);            //clears the context


    for (NSDictionary * line in self.lines) {
        
        CGContextSetLineWidth(context, [line[@"width"] floatValue]);
        [(UIColor * )line[@"color"] set];
        
        NSArray * points = line[@"points"];
        
        CGPoint start = [points[0] CGPointValue];
        
        CGContextMoveToPoint(context, start.x, start.y);
        
        for (NSValue * value in points) {
            
            CGPoint point = [value CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
        [self.lines addObject:[@{
                                @"color" : self.lineColor,
                                @"width" : @(self.lineWidth),
                                @"points" : [@[[NSValue valueWithCGPoint:location]]mutableCopy]
                                            }mutableCopy]];
        
        NSLog(@"TOUCHES BEGAN X = %f Y = %f", location.x, location.y);

    }
    [self setNeedsDisplay];
 }

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self doTouch:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self doTouch:touches];
}
-(void)doTouch:(NSSet *)touches{
    UITouch * touch = [touches allObjects] [0];
    CGPoint location = [touch locationInView:self];
    [[self.lines lastObject][@"points"] addObject:[NSValue valueWithCGPoint:location]];
    [self setNeedsDisplay];
    
}


@end
