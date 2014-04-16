//
//  DLAStage.m
//  DrawLinesApp
//
//  Created by Jonathan Fox on 4/15/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "DLAStageLines.h"

@implementation DLAStageLines


-(void)doTouch:(NSSet *)touches{
    UITouch * touch = [touches allObjects] [0];
    CGPoint location = [touch locationInView:self];
    [self.lines lastObject][@"points"][1] = [NSValue valueWithCGPoint:location];

    [self setNeedsDisplay];

}
@end
