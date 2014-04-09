//
//  TDLTableViewCell.m
//  To Do 2
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-20, 40)];
        self.bgView.layer.cornerRadius = 6;
        
        [self.contentView addSubview:self.bgView];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 20)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeuve-UltraLight" size:26];
        
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
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
