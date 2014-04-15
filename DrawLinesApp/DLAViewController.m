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
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view = [[DLAStageLines alloc] initWithFrame:self.view.frame];
//        self.view = [[DLAStageScribble alloc] initWithFrame:self.view.frame];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scribbleView = [[DLAStageScribble alloc] initWithFrame:self.view.frame];
    
    //scribbleView.lineColor = [UIColor blueColor];
    
    [self.view addSubview:scribbleView];
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(55, (SCREEN_HEIGHT * 0.80), 210, 50)];
    
    slider.minimumValue = 2.0;
    slider.maximumValue = 30.0;
    
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
}

-(void)changeSize:(UISlider *)sender{
    scribbleView.lineWidth = sender.value;
}

-(void)changeColor:(UIButton *)sender{
    scribbleView.lineColor = sender.backgroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
