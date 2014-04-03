//
//  TDLTableViewCell.m
//  ToDo
//
//  Created by Jonathan Fox on 4/3/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
