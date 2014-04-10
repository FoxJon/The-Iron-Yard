//
//  TDLTableViewCell.h
//  To Do 2
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDLTableViewCell : UITableViewCell

@property (nonatomic) UILabel * nameLabel;
@property (nonatomic) UIView * bgView;
@property (nonatomic) UIButton * circleButton;
@property (nonatomic) UIView * strikeThrough;

-(void)showCircleButtons;
-(void)hideCircleButtons;

@end
