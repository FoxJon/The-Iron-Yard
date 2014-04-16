//
//  DLAViewController.m
//  DrawLinesApp
//
//  Created by Jonathan Fox on 4/15/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "DLAViewController.h"
#import "DLAStageLines.h"
#import "DLAStageScribble.h"

@interface DLAViewController ()

@end

@implementation DLAViewController
{
    DLAStageScribble * scribbleView;
    UIView * colorsDrawer;
    
    float lineWidth;
    UIColor * lineColor;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lineColor = [UIColor purpleColor];
    lineWidth = 5.0;
    
    [self toggleStage];
    
    [self.view addSubview:scribbleView];
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(55, (SCREEN_HEIGHT * 0.80), 210, 50)];
    
    slider.minimumValue = 2.0;
    slider.maximumValue = 20.0;
    slider.value = lineWidth;
    
    [slider addTarget:self action:@selector(changeSize:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
    
    colorsDrawer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.90, SCREEN_WIDTH, 40)];
    
    NSArray * colors = @[
                         [UIColor colorWithRed:0.251f green:0.251f blue:0.251f alpha:1.0f],
                         [UIColor colorWithRed:0.008f green:0.353f blue:0.431f alpha:1.0f],
                         [UIColor colorWithRed:0.016f green:0.604f blue:0.671f alpha:1.0f],
                         [UIColor colorWithRed:1.000f green:0.988f blue:0.910f alpha:1.0f],
                         [UIColor colorWithRed:1.000f green:0.298f blue:0.153f alpha:1.0f],
                         [UIColor orangeColor],
                         [UIColor yellowColor],
                         [UIColor cyanColor],
                         [UIColor brownColor]
                        ];
    
    float buttonWidth = SCREEN_WIDTH / [colors count];
    
    for (UIColor * color in colors) {
       
        int index = [colors indexOfObject:color];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * index, 0,buttonWidth, 40)];
        
        button.backgroundColor = color;
        
        [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        
        [colorsDrawer addSubview:button];
    }
    
    
    [self.view addSubview:colorsDrawer];
    
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    
    
    UISwitch * toggleSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(5, (SCREEN_HEIGHT * 0.815), 100, 100)];
    [toggleSwitch addTarget:self action:@selector(toggleStage) forControlEvents:UIControlEventTouchUpInside];
    
    toggleSwitch.onTintColor = [UIColor orangeColor];
    
    [self.view addSubview:toggleSwitch];
    
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    
    
    UIButton * undoButton = [[UIButton alloc]initWithFrame:CGRectMake(270, (SCREEN_HEIGHT * 0.825), 25, 25)];
    
    undoButton.backgroundColor = [UIColor lightGrayColor];
    [undoButton addTarget:self action:@selector(undoStage) forControlEvents:UIControlEventTouchUpInside];
    
    [undoButton setImage:[UIImage imageNamed: @"undo.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:undoButton];

    
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    
    
    UIButton * clearButton = [[UIButton alloc]initWithFrame:CGRectMake(295, (SCREEN_HEIGHT * 0.825), 25, 25)];
    
    clearButton.backgroundColor = [UIColor redColor];
    [clearButton addTarget:self action:@selector(clearStage) forControlEvents:UIControlEventTouchUpInside];
    [clearButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self.view addSubview:clearButton];
    

}

- (void)toggleStage{
    
    NSMutableArray * lines = scribbleView.lines;
    
    [scribbleView removeFromSuperview];
    
    if ([scribbleView isMemberOfClass:[DLAStageScribble class]]) {
        scribbleView = [[DLAStageLines alloc] initWithFrame:self.view.frame];
    } else {
        scribbleView = [[DLAStageScribble alloc] initWithFrame:self.view.frame];
    }
    
    scribbleView.lineWidth = lineWidth;
    scribbleView.lineColor = lineColor;
    
    if(lines != nil) scribbleView.lines = lines;
    
    [self.view insertSubview:scribbleView atIndex:0];
}

-(void) clearStage{
    
    [scribbleView clearStage];
    
}

-(void) undoStage{
    
    [scribbleView undo];
}


-(void)changeSize:(UISlider *)sender{
    lineWidth = sender.value;
    scribbleView.lineWidth = lineWidth;
}

-(void)changeColor:(UIButton *)sender{
    lineColor = sender.backgroundColor;
    scribbleView.lineColor = lineColor;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
