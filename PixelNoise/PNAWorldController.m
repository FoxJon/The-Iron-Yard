//
//  PNAWorldController.m
//  PixelNoise
//
//  Created by Jonathan Fox on 5/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PNAWorldController.h"
#import "PNAPixelSounds.h"

@interface PNAWorldController () <UICollisionBehaviorDelegate>

@property (nonatomic) UIGravityBehavior * gravity;
@property (nonatomic) UIDynamicAnimator * animator;
@property (nonatomic) UICollisionBehavior * collision;
@property (nonatomic) UIPushBehavior * pusher;
@property (nonatomic) NSMutableArray * squares;
@property (nonatomic) NSMutableArray * smallSquares;



@end

@implementation PNAWorldController
{
    UIView * square;
    PNAPixelSounds * sounds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.squares = [@[]mutableCopy];
        self.smallSquares = [@[]mutableCopy];
        sounds = [[PNAPixelSounds alloc]init];

    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *myTouch =[[event allTouches] anyObject];
    CGPoint location = [myTouch locationInView:self.view];
    
    square = [[UIView alloc] initWithFrame:CGRectMake(location.x, location.y, 10, 10)];
    square.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:square];
 //   [self.squares addObject:square];

    // Do any additional setup after loading the view.
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    [self.animator addBehavior:self.gravity];
    
    self.collision = [[UICollisionBehavior alloc]initWithItems:@[square]];
    self.collision.collisionDelegate = self;
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    
    self.collision.collisionMode = UICollisionBehaviorModeBoundaries;
    
    [self.animator addBehavior:self.collision];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
     [sounds playSoundWithName:@"blip_click"];
      NSLog(@"FLOOR");
    
    [self.collision removeItem:square];
    [square removeFromSuperview];

    CGRect frame = square.frame;

        UIView *smallSquare1 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 8, 8)];
        smallSquare1.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:smallSquare1];
//        [self.smallSquares addObject:smallSquare];
        self.gravity = [[UIGravityBehavior alloc] initWithItems:@[smallSquare1]];
        [self.animator addBehavior:self.gravity];
        self.pusher = [[UIPushBehavior alloc] initWithItems:@[smallSquare1] mode: UIPushBehaviorModeInstantaneous];
        self.pusher.pushDirection = CGVectorMake(-0.002, -0.01);  // + is down, - is up. object mass makes diff
        [self.animator addBehavior:self.pusher];
    
    UIView *smallSquare2 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 8, 8)];
    smallSquare2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:smallSquare2];
    //        [self.smallSquares addObject:smallSquare];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[smallSquare2]];
    [self.animator addBehavior:self.gravity];
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[smallSquare2] mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(-0.004, -0.01);  // + is down, - is up. object mass makes diff
    [self.animator addBehavior:self.pusher];
    
    UIView *smallSquare3 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 8, 8)];
    smallSquare3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:smallSquare3];
    //        [self.smallSquares addObject:smallSquare];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[smallSquare3]];
    [self.animator addBehavior:self.gravity];
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[smallSquare3] mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(-0.009, -0.01);  // + is down, - is up. object mass makes diff
    [self.animator addBehavior:self.pusher];
    
    UIView *smallSquare4 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 8, 8)];
    smallSquare4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:smallSquare4];
    //        [self.smallSquares addObject:smallSquare];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[smallSquare4]];
    [self.animator addBehavior:self.gravity];
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[smallSquare4] mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(0.002, -0.01);  // + is down, - is up. object mass makes diff
    [self.animator addBehavior:self.pusher];
    
    UIView *smallSquare5 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 8, 8)];
    smallSquare5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:smallSquare5];
    //        [self.smallSquares addObject:smallSquare];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[smallSquare5]];
    [self.animator addBehavior:self.gravity];
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[smallSquare5] mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(0.004, -0.01);  // + is down, - is up. object mass makes diff
    [self.animator addBehavior:self.pusher];
    
    UIView *smallSquare6 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 8, 8)];
    smallSquare6.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:smallSquare6];
    //        [self.smallSquares addObject:smallSquare];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[smallSquare6]];
    [self.animator addBehavior:self.gravity];
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[smallSquare6] mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(0.009, -0.01);  // + is down, - is up. object mass makes diff
    [self.animator addBehavior:self.pusher];

    
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
