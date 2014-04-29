//
//  TDLTableViewCell.m
//  To Do 2
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLCell.h"
#import "MOVE.h"

@implementation TDLCell
{
    UIButton * priorityLow;
    UIButton * priorityMed;
    UIButton * priorityHigh;
}

#pragma mark - Set Cell style for BGView/nameLabel/Strike/CircleButtons

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width -20, 40)];
        self.bgView.layer.cornerRadius = 6;
        self.backgroundColor = [UIColor colorWithRed:0.937f green:0.965f blue:0.820f alpha:1.0f];
        
        [self.contentView addSubview:self.bgView];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        [self.bgView addSubview:self.nameLabel];
        
        self.strikeThrough = [[UIView alloc] initWithFrame:CGRectMake(5, 22, self.frame.size.width - 30, 1)];
        self.strikeThrough.backgroundColor = [UIColor whiteColor];
        self.strikeThrough.alpha = 0;
        [self.bgView addSubview:self.strikeThrough];
        
        self.circleButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 50, 10, 20, 20)];
        self.circleButton.layer.cornerRadius = 10;
        self.circleButton.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:self.circleButton];
    }
    return self;
}

-(void) resetLayout{
//    if (self.swiped) {
//        [self createCircleButtons];
//        self.swiped = YES;
//    }else{
    self.bgView.frame = CGRectMake(10, 5, self.frame.size.width-20, 40);
    [priorityLow removeFromSuperview];
    [priorityMed removeFromSuperview];
    [priorityHigh removeFromSuperview];
    self.swiped = NO;
//    }
}


- (void)createCircleButtons{
    priorityLow = [[UIButton alloc] initWithFrame:CGRectMake(200, 10, 30, 30)];
    priorityLow.tag = 1;
    priorityLow.alpha = 0;
    [priorityLow setTitle:@"L" forState:UIControlStateNormal];
    [priorityLow addTarget:self action:@selector(pressPriorityButton:) forControlEvents:UIControlEventTouchUpInside];
    priorityLow.backgroundColor = YELLOW_COLOR;
    priorityLow.layer.cornerRadius = 15;
    
    [self.contentView addSubview:priorityLow];
    
    
    priorityMed = [[UIButton alloc] initWithFrame:CGRectMake(240, 10, 30, 30)];
    priorityMed.tag = 2;
    priorityMed.alpha = 0;
    [priorityMed setTitle:@"M" forState:UIControlStateNormal];
    [priorityMed addTarget:self action:@selector(pressPriorityButton:) forControlEvents:UIControlEventTouchUpInside];
    
    priorityMed.backgroundColor = ORANGE_COLOR;
    priorityMed.layer.cornerRadius = 15;
    
    [self.contentView addSubview:priorityMed];
    
    priorityHigh = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 30, 30)];
    priorityHigh.tag = 3;
    priorityHigh.alpha = 0;
    [priorityHigh setTitle:@"H" forState:UIControlStateNormal];
    [priorityHigh addTarget:self action:@selector(pressPriorityButton:) forControlEvents:UIControlEventTouchUpInside];
    priorityHigh.backgroundColor = RED_COLOR;
    priorityHigh.layer.cornerRadius = 15;
    
    [self.contentView addSubview:priorityHigh];

}

- (void)pressPriorityButton:(id)sender{
    
    UIButton * button = (UIButton *) sender;   // something to do with the : (pressPriorityButton:) as the sender
    
    [self.delegate setItemPriority:(int)button.tag withItem:self];
    
}


#pragma mark - Show circle buttons when cell slides over

-(void)showCircleButtons
{
    [self createCircleButtons];
    
    [MOVE animateView:priorityLow properties:@{@"alpha":@1, @"duration":@0.2,@"delay":@0.3}];
    [MOVE animateView:priorityMed properties:@{@"alpha":@1, @"duration":@0.2,@"delay":@0.2}];
    [MOVE animateView:priorityHigh properties:@{@"alpha":@1, @"duration":@0.2,@"delay":@0.1}];
}

#pragma mark - Hide circle buttons when cell slides over

-(void)hideCircleButtons
{
    [MOVE animateView:priorityLow properties:@{@"alpha":@0, @"duration":@0.2,@"delay":@0.0,@"remove":@YES}];
    [MOVE animateView:priorityMed properties:@{@"alpha":@0, @"duration":@0.2,@"delay":@0.1,@"remove":@YES}];
    [MOVE animateView:priorityHigh properties:@{@"alpha":@0, @"duration":@0.2,@"delay":@0.2,@"remove":@YES}];

}

-(void)showDeleteButton{
    
    priorityHigh = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 30, 30)];
    priorityHigh.alpha = 0;
    priorityHigh.backgroundColor = RED_COLOR;
    priorityHigh.layer.cornerRadius = 15;
    [priorityHigh setTitle:@"X" forState:UIControlStateNormal];
    priorityHigh.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
    priorityHigh.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [priorityHigh addTarget:self action:@selector(pressDeleteButton) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:priorityHigh];
    
     [MOVE animateView:priorityHigh properties:@{@"alpha":@1, @"duration":@0.2,@"delay":@0.3}];
    
}

- (void)pressDeleteButton{
    [self.delegate deleteItem:self];
}


-(void)hideDeleteButton{
       [MOVE animateView:priorityHigh properties:@{@"alpha":@0, @"duration":@0.2,@"delay":@0.0,@"remove":@YES}];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
