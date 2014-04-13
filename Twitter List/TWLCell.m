//
//  TWLCell.m
//  Twitter List
//
//  Created by Jonathan Fox on 4/13/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TWLCell.h"

@implementation TWLCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 30)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        [self.contentView addSubview:self.nameLabel];
        
        self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 200, 30)];
        self.locationLabel.textColor = [UIColor whiteColor];
        self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        [self.contentView addSubview:self.locationLabel];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 200, 30)];
        self.descriptionLabel.textColor = [UIColor whiteColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [self.contentView addSubview:self.descriptionLabel];

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
