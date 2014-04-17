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
        
        self.backgroundColor = [UIColor blackColor];
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

//-(void)changeLineColor: (UIButton *) sender{
//    [self setLineColor:sender.backgroundColor];
//}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
 
   // CGContextSetFillColor(context, CGColorGetComponents([[UIColor redColor] CGColor]));
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);  //Fills a square.
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillRect(context, CGRectMake(100, 200, 100, 100));             //clears current path
//    
//    
//    CGContextAddEllipseInRect(context, CGRectMake(100, 75, 100, 75));   //draws an elipse
//    CGContextFillPath(context);                                         //fills current path. clears current path
//    
//    CGContextAddRect(context, CGRectMake(100, 100, 100, 100));          //draws an empty square
    
    CGContextSetLineWidth(context, 20.0);
    [[UIColor redColor] set];
    CGContextFillEllipseInRect(context, CGRectMake(100, 100, 100, 100));
    [[UIColor colorWithWhite:1.0 alpha:0.5]set];
    CGContextStrokeEllipseInRect(context, CGRectMake(150, 100, 100, 100));
    CGContextAddEllipseInRect(context, CGRectMake(200, 100, 100, 100));

//    
//    CGContextMoveToPoint(context, 100, 200);
//    CGContextAddCurveToPoint(context, 150, 100, 150, 100, 200, 200);    //control"anchor" point
//    
//    CGContextMoveToPoint(context, 150, 150);
//    CGContextAddArc(context, 100.0, 300.0, 90.0, 90.0, M_PI/2.0, false);
//    CGContextAddArc(context, 250.0, 250.0, 30.0, 3.0*M_PI/2.0, M_PI, true);
    
    CGContextMoveToPoint(context, 50, 50);
    
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 100, 150);
    
    CGContextAddLineToPoint(context, 50, 150);
    CGContextAddLineToPoint(context, 50, 50);
    
    CGContextStrokePath(context);                         // can use stroke or fill
//    
    
    CGContextSetLineWidth(context, self.lineWidth);
    [self.lineColor set];


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
        CGContextStrokePath(context);                           // can fill it or stroke it

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
