//
//  TDLTableViewCell.m
//  ToDo
//
//  Created by Jonathan Fox on 4/3/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell

//@synthesize profileInfo = _profileInfo;     // this line is needed if you overwrite both setter and getter methods


//@synthesize profile = _profile;   // these items are all set automatically when you set @property in the .h file
//- (NSDictionary *)profile
//{
//    return _profile;
//}
//
//- (void) setProfile:(NSDictionary *)profile
//{
//   _profile = profile;
//}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}


- (void) setProfileInfo:(NSDictionary *)profileInfo  // _ is only used in these two methods inside the {}. Setter
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    
    imageView.image = profileInfo[@"image"];
    imageView.layer.cornerRadius = 15;
    imageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:imageView];
    
    UILabel * labelView = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
    labelView.text = profileInfo[@"name"];
    
    [self.contentView addSubview:labelView];
    
    
    
    _profileInfo = profileInfo;
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
