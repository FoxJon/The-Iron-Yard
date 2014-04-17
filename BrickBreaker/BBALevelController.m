//
//  BBALevelController.m
//  BrickBreaker
//
//  Created by Jonathan Fox on 4/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BBALevelController.h"
#import "move.h"

@interface BBALevelController ()

@property (nonatomic) UIView * paddle;
@property (nonatomic) NSMutableArray * balls;
@property (nonatomic) NSMutableArray * bricks;

// dynamics animator
@property (nonatomic) UIDynamicAnimator * animator;

// pushes the ball
@property (nonatomic) UIPushBehavior * pusher;

// handles Collisions
@property (nonatomic) UICollisionBehavior * collider;

// item behavior properties
@property (nonatomic) UIDynamicItemBehavior * paddleDynamicProperties;
@property (nonatomic) UIDynamicItemBehavior * ballsDynamicProperties;
@property (nonatomic) UIDynamicItemBehavior * bricksDynamicProperties;

// item attachment
@property (nonatomic) UIAttachmentBehavior * attacher;

@end

/////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////


@implementation BBALevelController
{
    float paddleWidth;
    float points;
    UIView * tempBrick;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.bricks = [@[]mutableCopy];
        self.balls = [@[]mutableCopy];
        
        paddleWidth = 80;
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) resetLevel
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self createPaddle];
    [self createBricks];
    [self createBall];
    
    self.collider = [[UICollisionBehavior alloc]initWithItems:[self allItems]];
    
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
   
    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:self.collider];
    

//////////////////////////////////////////////

    self.ballsDynamicProperties = [self createPropertiesForItems:self.balls];
    self.bricksDynamicProperties = [self createPropertiesForItems:self.bricks];
    self.paddleDynamicProperties = [self createPropertiesForItems:@[self.paddle]];
    
    self.paddleDynamicProperties.density = 100000;
    self.bricksDynamicProperties.density = 100000;

    self.ballsDynamicProperties.elasticity = 1.0;
    self.ballsDynamicProperties.resistance = 0.0;

}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    
    
        for (UIView * brick in self.bricks)
    {
        if([item1 isEqual:brick] || [item2 isEqual:brick])
        {
            if (brick.alpha == 0.5)
            {
                tempBrick = brick;
                [brick removeFromSuperview];       //this is the brick space
                [self.collider removeItem:brick];
                
                points += 100;
                
                NSLog(@"Total Points = %f", points);
                
                [self pointLabelWithBrick:brick];
            }
            else
            {
            brick.alpha = 0.5;
            }
        }
    }
    
    if(tempBrick != nil) [self.bricks removeObjectIdenticalTo:tempBrick];
}

-(void)pointLabelWithBrick:brick
{
    UILabel * pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(tempBrick.frame.origin.x, 10, 50, 30)];
    pointLabel.text = @"+100";
    pointLabel.textAlignment = NSTextAlignmentCenter;
    pointLabel.backgroundColor = [UIColor clearColor];
    pointLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:pointLabel];
    [MOVE animateView:pointLabel properties:@{@"alpha":@0, @"duration":@0.6,@"delay":@0.0,@"remove":@YES}];
}

-(UIDynamicItemBehavior *) createPropertiesForItems:(NSArray *)items
{
    UIDynamicItemBehavior * properties = [[UIDynamicItemBehavior alloc] initWithItems:items];
    properties.allowsRotation = NO;
    properties.friction = 0.0;
    
    [self.animator addBehavior:properties];
    
    return properties;
}


-(NSArray *) allItems
{
    NSMutableArray * items = [@[self.paddle]mutableCopy];
    
    for (UIView * item  in self.balls) [items addObject:item];
    for (UIView * item  in self.bricks) [items addObject:item];
    
    return items;
}

-(void)createPaddle
{
    self.paddle = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - paddleWidth)/2, SCREEN_HEIGHT - 20, paddleWidth, 6)];
   
    self.paddle.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.paddle.layer.cornerRadius = 3;
    
    [self.view addSubview:self.paddle];
}

-(void)createBricks
{
    int brickCols = 10;
    float brickWidth = (SCREEN_WIDTH - (10 * (brickCols + 1))) / brickCols;
    //float brickWidth = SCREEN_WIDTH / brickCols;

 
    for (int i = 0; i < brickCols; i++)
    {
        float brickX = ((brickWidth + 10) * i) + 10;
        UIView * brick = [[UIView alloc]initWithFrame:CGRectMake(brickX, 10, brickWidth, 30)];
        
        brick.layer.cornerRadius = 6;
        brick.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        
        [self.view addSubview:brick];
        [self.bricks addObject:brick];
    }
}

-(void)createBall
{
    CGRect frame = self.paddle.frame;
    
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x + 35, frame.origin.y - 12, 10, 10)];
    
    ball.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    ball.layer.cornerRadius = 5;
    
    [self.view addSubview:ball];
    
    //Add ball to balls array
    [self.balls addObject:ball];
    
    // Start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:self.balls mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(0.04, 0.04);  // + is down, - is up. object mass makes diff
    self.pusher.active = YES;
    
    [self.animator addBehavior:self.pusher];
    
}





@end
