//
//  TDLTableViewCell.m
//  ToDo
//
//  Created by Jonathan Fox on 4/3/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell

@synthesize profileInfo = _profileInfo;     // this line is needed if you overwrite both setter and getter methods


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

- (NSDictionary *)profileInfo   // Not necessary. This is overwriting nil to a standard value. Getter
{
    if (_profileInfo == nil)
    {
        _profileInfo = @{@"name": @"Someone", @"image":[UIImage imageNamed:@"default"]};
    }
    return _profileInfo;

}

- (void) setProfile:(NSDictionary *)profileInfo  // _ is only used in these two methods inside the {}. Setter
{
    if(profileInfo != nil) _profileInfo = profileInfo;
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
