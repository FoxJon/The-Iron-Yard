//
//  TDLTableViewCell.m
//  ToDo
//
//  Created by Jonathan Fox on 4/3/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell

{
    UIImageView * profileImage;
    UILabel * profileName;
    UILabel * profileURL;
    UILabel * profileLocation;
    
}
    
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier // used w/o storyboard
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupCell];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder                             // used with storyboard
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    
    profileImage.layer.cornerRadius = 30;
    profileImage.layer.masksToBounds = YES;
    
    [self.contentView addSubview:profileImage];
    
    
    profileName = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 30)];
    
    profileName.textColor = [UIColor darkGrayColor];
    profileName.font = [UIFont systemFontOfSize: 20];
    
    
    [self.contentView addSubview:profileName];
    
    profileURL = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 200, 30)];
    
    profileURL.textColor = [UIColor lightGrayColor];
    profileURL.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:profileURL];
    
    profileLocation = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 200, 30)];
    profileLocation.textColor = [UIColor lightGrayColor];
    profileLocation.font = [UIFont systemFontOfSize:14];


    
    
    [self.contentView addSubview:profileLocation];


}


- (void) setProfileInfo:(NSDictionary *)profileInfo  // Setter
{
    NSURL * imageURL = [NSURL URLWithString:profileInfo[@"avatar_url"]];
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];

    UIImage * image = [UIImage imageWithData:imageData];
   
    profileImage.image = image;
    
    profileName.text = profileInfo[@"name"];
    
//  profileURL.text = [profileInfo objectForKey:@"github"];
    profileURL.text = profileInfo[@"html_url"];

    if([profileInfo[@"location"] isEqualToString:@""])
        profileLocation.text = @"Somewhere Unknown";
    else
        profileLocation.text = profileInfo[@"location"];
    
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
