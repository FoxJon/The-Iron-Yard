//
//  BBALevelController.m
//  BrickBreaker
//
//  Created by Jonathan Fox on 4/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//  TEST

#import "BBALevelController.h"
#import "move.h"
#import "BBAGameData.h"
#import "BBAViewController.h"


@interface BBALevelController () <UICollisionBehaviorDelegate, AVAudioPlayerDelegate>

//@property (nonatomic) AVAudioPlayer * player;
@property (nonatomic) NSMutableArray * players;


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
    int points;
    int brickCount;
    int brickCols;
    int brickRows;
    UIView * ball;
    UIView * newBall;
    UILabel * scoreLabel;
    UILabel * livesLabel;
    int lives;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.bricks = [@[]mutableCopy];
        self.balls = [@[]mutableCopy];
        self.players = [@[]mutableCopy];

        
        paddleWidth = 80;
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
        [self.view addGestureRecognizer:tap];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panScreen:)];
        [self.view addGestureRecognizer:pan];
        
    }
    return self;
}

-(void)playSoundWithName:(NSString *)soundName
{
    NSString * file = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    
    NSURL * url = [[NSURL alloc]initFileURLWithPath:file];
    
    AVAudioPlayer * player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    player.delegate = self;
    
    [self.players addObject:player];
    
    [player play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.players removeObjectIdenticalTo:player];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) resetLevel
{
    [BBAGameData mainData].currentScore = 0;
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self createPaddle];
    [self createBricks];
    [self createBall];
    
    self.collider = [[UICollisionBehavior alloc]initWithItems:[self allItems]];
    
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
   
//    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.height;

    [self.collider addBoundaryWithIdentifier:@"ceiling" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(w, 0)];
    [self.collider addBoundaryWithIdentifier:@"leftWall" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, h)];
    [self.collider addBoundaryWithIdentifier:@"rightWall" fromPoint:CGPointMake(w, 0) toPoint:CGPointMake(w, h)];
    [self.collider addBoundaryWithIdentifier:@"floor" fromPoint:CGPointMake(0, h + 10) toPoint:CGPointMake(w, h + 10)];
    
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
    if([item1 isEqual:self.paddle] || [item2 isEqual:self.paddle])
    {
        [self playSoundWithName:@"retro_click"];
        
    }
    
    UIView * tempBrick;
    for (UIView * brick in self.bricks)
    {
        if([item1 isEqual:brick] || [item2 isEqual:brick])
        {
            if (brick.alpha == 0.5)
            {
                tempBrick = brick;
                [brick removeFromSuperview];       //this is the brick space
                [self.collider removeItem:brick];
                
                brickCount += 1;
                [self statsLogger];
                
                points += brick.tag;
                [self statsLogger];
                [self pointLabelWithBrick:brick];
                
                NSInteger currentScore = [BBAGameData mainData].currentScore;
                [BBAGameData mainData].currentScore = currentScore + brick.tag;
            }
            else
            {
            brick.alpha = 0.5;
            }
        }
    }
    
    if(tempBrick != nil)
    {
        [self playSoundWithName:@"electric_alert"];
        [self.bricks removeObjectIdenticalTo:tempBrick];
    }
    
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([(NSString *)identifier isEqualToString:@"floor"])
     {
        // NSLog(@"FLOOR");

         ball = (UIView *)item;
         newBall = (UIView *)item;

         [ball removeFromSuperview];
         [self.collider removeItem:ball];
         [self.balls removeObject:ball];
         
         [newBall removeFromSuperview];
         [self.collider removeItem:newBall];
         [self.balls removeObject:newBall];
         
         lives += 1;
         [self statsLogger];
         
         int totalLives = 3;
         totalLives -= lives;
    //     NSLog(@"LIVES = %d", totalLives);
         [self.delegate addLives:totalLives];
         if (totalLives == 0) {
             [self.delegate gameDone:points];
         }else
         {
         [self createNewBall];
         }
     }
}

-(void) statsLogger

{
  //  NSLog(@"Total bricks = %d", brickCount);

    if (brickCount == brickCols * brickRows) {
        [self.delegate gameDone:points];
    }

 //   NSLog(@"SCORE = %d", points);
    [self.delegate addPoints:points];

}


-(void)pointLabelWithBrick:(UIView *)brick
{
    UILabel * pointLabel = [[UILabel alloc] initWithFrame:brick.frame];
    pointLabel.text = [NSString stringWithFormat:@"+%d",(int)brick.tag];
    pointLabel.textAlignment = NSTextAlignmentCenter;
    pointLabel.backgroundColor = [UIColor clearColor];
    pointLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:pointLabel];

    
    [UIView animateWithDuration:0.4 animations:^{
        pointLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [pointLabel removeFromSuperview];
    }];
    
    //[MOVE animateView:pointLabel properties:@{@"alpha":@0, @"duration":@0.6,@"delay":@0.0,@"remove":@YES}];
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
    self.paddle = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - paddleWidth)/2, SCREEN_HEIGHT - 60, paddleWidth, 6)];
   
    self.paddle.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.paddle.layer.cornerRadius = 3;
    
    [self.view addSubview:self.paddle];
    
    self.attacher = [[UIAttachmentBehavior alloc] initWithItem:self.paddle attachedToAnchor:CGPointMake(CGRectGetMidX(self.paddle.frame),CGRectGetMidY(self.paddle.frame))];
    
    [self.animator addBehavior:self.attacher];
}


-(void)createBricks
{
    brickCols = 10;
    brickRows = 4;
    
    float brickWidth = (SCREEN_WIDTH - (brickCols + 1)) / brickCols;
    float brickHeight = 20;
    
    
    for (int c = 0; c < brickCols; c++)
    {
        for (int r = 0; r < brickRows; r++)
        {
            
            float brickX = ((brickWidth + 1) * c);
            float brickY = ((brickHeight + 1) * r);
            
            UIView * brick = [[UIView alloc]initWithFrame:CGRectMake(brickX, brickY, brickWidth, brickHeight)];
            
            brick.layer.cornerRadius = 4;
            brick.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.7];
            
            int random = arc4random_uniform(5) * 50;
            brick.tag = random;
            
            [self.view addSubview:brick];
            [self.bricks addObject:brick];
        }
    }
}

-(void)createNewBall
{
    
    CGRect frame = self.paddle.frame;
    
    newBall = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x + 35, frame.origin.y - 12, 10, 10)];

    newBall.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    newBall.layer.cornerRadius = 5;
    
    [self.view addSubview:newBall];
    
    //Add ball to balls array
    [self.balls addObject:newBall];
    
    // Start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:self.balls mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(-0.02, -0.02);  // + is down, - is up. object mass makes diff
    self.pusher.active = YES;
    
    [self.animator addBehavior:self.pusher];
    
    self.collider = [[UICollisionBehavior alloc]initWithItems:[self allItems]];

    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
    
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.height;
    
    [self.collider addBoundaryWithIdentifier:@"ceiling" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(w, 0)];
    [self.collider addBoundaryWithIdentifier:@"leftWall" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, h)];
    [self.collider addBoundaryWithIdentifier:@"rightWall" fromPoint:CGPointMake(w, 0) toPoint:CGPointMake(w, h)];
    [self.collider addBoundaryWithIdentifier:@"floor" fromPoint:CGPointMake(0, h + 10) toPoint:CGPointMake(w, h + 10)];
    
    [self.animator addBehavior:self.collider];

    
    //////////////////////////////////////////////
    
    self.ballsDynamicProperties = [self createPropertiesForItems:self.balls];
    
    self.ballsDynamicProperties.elasticity = 1.0;
    self.ballsDynamicProperties.resistance = 0.0;
}


-(void)createBall
{
    CGRect frame = self.paddle.frame;
    
    ball = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x + 35, frame.origin.y - 12, 10, 10)];
    
    ball.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    ball.layer.cornerRadius = 5;
    
    [self.view addSubview:ball];
    
    //Add ball to balls array
    [self.balls addObject:ball];
    
    // Start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:self.balls mode: UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(-0.02, -0.02);  // + is down, - is up. object mass makes diff
    self.pusher.active = YES;
        
    [self.animator addBehavior:self.pusher];
}


-(void)tapScreen:(UITapGestureRecognizer *)gr
{
    CGPoint location = [gr locationInView:self.view];
    
    self.attacher.anchorPoint = CGPointMake(location.x, self.attacher.anchorPoint.y);
}


-(void)panScreen:(UIPanGestureRecognizer *)gr
{
    CGPoint location = [gr locationInView:self.view];
    
    self.attacher.anchorPoint = CGPointMake(location.x, self.attacher.anchorPoint.y);
}


@end
