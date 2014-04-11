//
//  TDLTableViewCell.h
//  To Do 2
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TDLCellDelegate;

@interface TDLCell : UITableViewCell

@property (nonatomic, assign) id<TDLCellDelegate> delegate;

@property (nonatomic) UILabel * nameLabel;
@property (nonatomic) UIView * bgView;
@property (nonatomic) UIButton * circleButton;
@property (nonatomic) UIView * strikeThrough;
@property (nonatomic) BOOL swiped;                  //starts out as false

-(void) resetLayout;

-(void)showCircleButtons;
-(void)hideCircleButtons;

-(void)showDeleteButton;
-(void)hideDeleteButton;

@end

@protocol TDLCellDelegate <NSObject>

- (void)deleteItem:(TDLCell *)cell;
- (void)setItemPriority:(int)priority withItem:(TDLCell *)cell;

@optional

-(void)optionalMethod;


@end
