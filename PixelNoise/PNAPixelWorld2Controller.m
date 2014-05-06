//
//  PNAPixelWorld2Controller.m
//  PixelNoise
//
//  Created by Jonathan Fox on 5/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PNAPixelWorld2Controller.h"
#import "PNAPixelSounds.h"

@interface PNAPixelWorld2Controller () <UICollisionBehaviorDelegate>

@property (nonatomic) UIGravityBehavior * gravity;
@property (nonatomic) UIDynamicAnimator * animator;
@property (nonatomic) UICollisionBehavior * collision;

@property (nonatomic) UIDynamicItemBehavior * shardBehavior;
@property (nonatomic) UICollisionBehavior * shardCollision;

@end

@implementation PNAPixelWorld2Controller
{
    PNAPixelSounds * sounds;
    
    NSArray * splatterDirections;
    
    int waterLevel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        sounds = [[PNAPixelSounds alloc]init];
        
        splatterDirections = @[
                              [NSValue valueWithCGPoint:CGPointMake(-0.1, -0.1)],
                              [NSValue valueWithCGPoint:CGPointMake(-0.05, -0.1)],
                              [NSValue valueWithCGPoint:CGPointMake(0.0, -0.1)],
                              [NSValue valueWithCGPoint:CGPointMake(0.05, -0.1)],
                              [NSValue valueWithCGPoint:CGPointMake(0.1, -0.1)]
                              ];
        
        waterLevel = 470;

        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        self.gravity = [[UIGravityBehavior alloc] init];
        [self.animator addBehavior:self.gravity];
        
        self.collision = [[UICollisionBehavior alloc]init];
        self.collision.translatesReferenceBoundsIntoBoundary = YES;
        self.collision.collisionDelegate = self;
        [self.animator addBehavior:self.collision];

        self.shardBehavior = [[UIDynamicItemBehavior alloc]init];
        self.shardBehavior.density = 20;
        [self.animator addBehavior:self.shardBehavior];
        
        self.shardCollision = [[UICollisionBehavior alloc]init];
        self.shardCollision.translatesReferenceBoundsIntoBoundary = YES;
        self.shardCollision.collisionDelegate = self;
        [self.animator addBehavior:self.collision];
        
        [self.collision addBoundaryWithIdentifier:@"floor"fromPoint:CGPointMake(0, waterLevel+10) toPoint:CGPointMake(320, waterLevel+10)];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
        [self createBlockWithLocataion:[touch locationInView:self.view]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
        [self createBlockWithLocataion:[touch locationInView:self.view]];
}

-(void)createBlockWithLocataion:(CGPoint)location
{
   // if([[self.view subviews] count]>10) return;
    
    UIView *block = [[UIView alloc] initWithFrame:CGRectMake(location.x, location.y, 10, 10)];
    block.backgroundColor = [UIColor blueColor];
    block.layer.cornerRadius = 5;
    [self.view addSubview:block]; // must add to subview before gravity and collision
    
    [self.gravity addItem:block];
    [self.collision addItem:block];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([(NSString *)identifier isEqualToString:@"floor"])
        
    waterLevel -= 1;
    
    [self.collision addBoundaryWithIdentifier:@"floor"fromPoint:CGPointMake(0, waterLevel+10) toPoint:CGPointMake(320, waterLevel+10)];
    
    UIView *water = [[UIView alloc] initWithFrame:CGRectMake(0, waterLevel, 320, 200)];
    water.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:water];
    
    if ([behavior isEqual:self.collision])
    {
    [sounds playSoundWithName:@"drip"];

    [self createShardWithLocation:p];

    UIView * collidedBlock = (UIView *)item;
    
    [self.gravity removeItem:collidedBlock];
    [self.collision removeItem:collidedBlock];
    [collidedBlock removeFromSuperview];
    
    
    }
    
    if ([behavior isEqual:self.shardCollision])
    {
    UIView * collidedShard = (UIView *)item;
    
    [self.gravity removeItem:collidedShard];
    [self.shardBehavior removeItem:collidedShard];
    [self.collision removeItem:collidedShard];
    
    [collidedShard removeFromSuperview];
    }
}

-(void)createShardWithLocation:(CGPoint)location
{
    for (NSValue *pointValue in splatterDirections) {
        CGPoint direction = [pointValue CGPointValue];
        
        UIView *shard = [[UIView alloc] initWithFrame:CGRectMake(location.x + (direction.x * 200), location.y - 50, 7, 7)];
        shard.layer.cornerRadius = 3.5;
       
        shard.backgroundColor = [UIColor blueColor];
        
        [self.view addSubview:shard]; // must add to subview before gravity and collision
        
        [self.gravity addItem:shard];
        [self.shardCollision addItem:shard];
        [self.shardBehavior addItem:shard];

        UIPushBehavior * pusher = [[UIPushBehavior alloc]initWithItems:@[shard] mode:UIPushBehaviorModeInstantaneous];
        
        [self.animator addBehavior:pusher];
        
        pusher.pushDirection = CGVectorMake(direction.x, direction.y);
    }
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
