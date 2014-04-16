//
//  DLAStageScribble.m
//  DrawLinesApp
//
//  Created by Jonathan Fox on 4/15/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "DLAStageScribble.h"

@implementation DLAStageScribble
{
    NSMutableArray * scribbles;
    UIButton * redButton;
    UIButton * blueButton;
    UIButton * greenButton;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //defaults
        self.lineWidth = 2.0;
        self.lineColor = [UIColor colorWithWhite:0.3 alpha:1.0];
       
        // Initialization code
        scribbles = [@[]mutableCopy];
        
        //self.backgroundColor = [UIColor whiteColor];
        
//        redButton = [[UIButton alloc] initWithFrame:CGRectMake(55, (SCREEN_HEIGHT * 0.89), 50 , 50)];
//        redButton.backgroundColor = [UIColor redColor];
//        redButton.layer.cornerRadius = 6;
//        [redButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:redButton];
//        
//        blueButton = [[UIButton alloc] initWithFrame:CGRectMake(135, (SCREEN_HEIGHT * 0.89), 50 , 50)];
//        blueButton.backgroundColor = [UIColor blueColor];
//        blueButton.layer.cornerRadius = 6;
//        [blueButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:blueButton];
//        
//        greenButton = [[UIButton alloc] initWithFrame:CGRectMake(215, (SCREEN_HEIGHT * 0.89), 50 , 50)];
//        greenButton.backgroundColor = [UIColor greenColor];
//        greenButton.layer.cornerRadius = 6;
//        [greenButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:greenButton];
        
        

    }
    return self;
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
    
    //[[UIColor cyanColor] set];
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    [self.lineColor set];

   // CGContextClearRect(context, rect);            //clears the context


    for (NSDictionary * scribble in scribbles) {
       // CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
        
        CGContextSetLineWidth(context, [scribble[@"width"] floatValue]);
        [(UIColor * )scribble[@"color"] set];
        
        NSArray * points = scribble[@"points"];
        
        CGPoint start = [points[0] CGPointValue];
        
        CGContextMoveToPoint(context, start.x, start.y);
        
        for (NSValue * value in points) {
            
            //int index = [scribble indexOfObject:value];
            CGPoint point = [value CGPointValue];
            //if (index > 0) CGContextAddLineToPoint(context, point.x, point.y);
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        CGContextStrokePath(context);                           // can fill it or stroke it
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
        [scribbles addObject:[@{
                                @"color" : self.lineColor,
                                @"width" : @(self.lineWidth),
                                @"points" : [@[[NSValue valueWithCGPoint:location]]mutableCopy]
                                            }mutableCopy]];
        
        NSLog(@"TOUCHES BEGAN X = %f Y = %f", location.x, location.y);

    }
    [self setNeedsDisplay];
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

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
//        [[scribbles lastObject] addObject:[NSValue valueWithCGPoint:location]];

        [[scribbles lastObject] [@"points"] addObject:[NSValue valueWithCGPoint:location]];

        NSLog(@"TOUCHES MOVED X = %f Y = %f", location.x, location.y);

    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        
//       [[scribbles lastObject] addObject:[NSValue valueWithCGPoint:location]];
        
        [[scribbles lastObject] [@"points"] addObject:[NSValue valueWithCGPoint:location]];

        NSLog(@"TOUCHES ENDED X = %f Y = %f", location.x, location.y);

    }
    [self setNeedsDisplay];
}


@end
