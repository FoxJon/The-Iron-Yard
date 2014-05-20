//
//  SFAColorViewController.m
//  SFASmileyFace
//
//  Created by Jonathan Fox on 5/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SFAColorViewController.h"
#import "SFASmileyViewController.h"
#import "SFAData.h"

@interface SFAColorViewController ()

@end

@implementation SFAColorViewController
{
    UIImageView * square;
    UIButton * colorButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSArray * colors = @[@"colors1", @"colors2", @"colors3", @"colors4", @"colors5", @"colors6", @"colors7", @"colors8", @"colors9"];
        
        NSMutableArray * taggedColors = [@[]mutableCopy];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        UIView * frame = [[UIView alloc]initWithFrame:CGRectMake(64, 192, 192, 192)];
        [self.view addSubview:frame];
        
        [super viewDidLoad];

        int gridCols = 3;
        int gridRows = 3;
        
        float colorWidth = 48;
        float colorHeight = 48;
        
        for (int c = 0; c < gridCols; c++)
        {
            for (int r = 0; r < gridRows; r++)
            {
                float gridX = ((colorWidth+16) * c);
                float gridY = ((colorHeight+16) * r);
                
                colorButton = [[UIButton alloc]initWithFrame:CGRectMake(gridX+8, gridY+8, 48, 48)];
                [colorButton addTarget:self action:@selector(addSelector:) forControlEvents:UIControlEventTouchUpInside];
                [colorButton setImage:[UIImage imageNamed: colors[r*3+c]] forState:UIControlStateNormal];
                
                colorButton.tag = (r*3)+c;
                
                [taggedColors addObject:colorButton];
                
                //NSLog(@"%i", (int)colorButton.tag);
                [frame addSubview:colorButton];
            }
        }
        
        square = [[UIImageView alloc]initWithFrame:CGRectMake(-8, -8, 64, 64)];
        square.image = [UIImage imageNamed:@"squares.png"];
        
        UIButton * arrow = [[UIButton alloc]initWithFrame:CGRectMake(144, 486, 24, 40)];
        arrow.backgroundColor = [UIColor lightGrayColor];
        [arrow addTarget:self action:@selector(selectSmileyVC) forControlEvents:UIControlEventTouchUpInside];
        [arrow setImage:[UIImage imageNamed: @"arrow.png"] forState:UIControlStateNormal];
        arrow.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:arrow];
    }
    return self;
}

-(void)addSelector:(UIButton *)sender
{
    NSLog(@"%i", (int)sender.tag);

    [SFAData mainData].color = (int)sender.tag;
    
    [sender insertSubview:square atIndex:0];
    
}

-(void)selectSmileyVC
{
    SFASmileyViewController *svc = [[SFASmileyViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:svc animated:YES];
}


- (void)viewDidLoad
{
  
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{return YES;}


@end
