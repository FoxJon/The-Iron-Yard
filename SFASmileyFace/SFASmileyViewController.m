//
//  SFASmileyViewController.m
//  SFASmileyFace
//
//  Created by Jonathan Fox on 5/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SFASmileyViewController.h"
#import "SFADisplayViewController.h"
#import "SFAData.h"

@interface SFASmileyViewController ()

@end

@implementation SFASmileyViewController
{
    UIImageView * square;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSArray * smilies = @[@"smilies1", @"smilies2", @"smilies3", @"smilies4", @"smilies5", @"smilies6", @"smilies7", @"smilies8", @"smilies9"];
         NSArray * redAngries = @[@"angry1", @"angry2", @"angry3", @"angry4", @"angry5", @"angry6", @"angry7", @"angry8", @"angry9"];
        
        NSMutableArray * taggedSmilies = [@[]mutableCopy];

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
                
                UIButton * colorButton = [[UIButton alloc]initWithFrame:CGRectMake(gridX+8, gridY+8, 48, 48)];
                [colorButton addTarget:self action:@selector(addSelector:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([SFAData mainData].color == 0) {
                    [colorButton setImage:[UIImage imageNamed: smilies[r*3+c]] forState:UIControlStateNormal];
                } else if ([SFAData mainData].color == 1){
                [colorButton setImage:[UIImage imageNamed: redAngries[r*3+c]] forState:UIControlStateNormal];
                }
                
                colorButton.tag = (r*3)+c;
                
                [taggedSmilies addObject:colorButton];
                
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
    
    [SFAData mainData].bigSmiley = (int)sender.tag;
        
    [sender insertSubview:square atIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)selectSmileyVC
{
    SFADisplayViewController *dvc = [[SFADisplayViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{return YES;}

@end
