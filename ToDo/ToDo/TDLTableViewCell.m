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
{
    UIImageView * profileImage;
    UILabel * profileName;
    UILabel * profileURL;
}
    
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        
        profileImage.layer.cornerRadius = 30;
        profileImage.layer.masksToBounds = YES;
        
        [self.contentView addSubview:profileImage];

        
        profileName = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 30)];
        
        profileName.textColor = [UIColor darkGrayColor];
        profileName.font = [UIFont systemFontOfSize: 20];

        
        [self.contentView addSubview:profileName];
        
        profileURL = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 30)];
        
        profileURL.textColor = [UIColor lightGrayColor];
        profileURL.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:profileURL];
        
        
    }
    return self;
}


- (void) setProfileInfo:(NSDictionary *)profileInfo  // _ is only used in these two methods inside the {}. Setter
{
    
    profileImage.image = profileInfo[@"image"];
    profileName.text = profileInfo[@"name"];
    
//  profileURL.text = [profileInfo objectForKey:@"github"];
    profileURL.text = profileInfo[@"github"];

    
    
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
