//
//  TLATableViewCell.m
//  TweetLike
//
//  Created by Jonathan Fox on 4/23/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TLATableViewCell.h"

@implementation TLATableViewCell
{
    UILabel * caption;
    UILabel * likes;
    UIImageView * heartIcon;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        heartIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 20, 20)];
        heartIcon.image = [UIImage imageNamed:@"heart"];
        [self.contentView addSubview:heartIcon];
        
        likes = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, 30, 80)];
        likes.backgroundColor = [UIColor clearColor];
        likes.textColor = [UIColor lightGrayColor];
        likes.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:likes];
        
        caption = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 220, 80)];
        caption.backgroundColor = [UIColor clearColor];
        caption.textColor = [UIColor lightGrayColor];
        caption.lineBreakMode = NSLineBreakByWordWrapping;
        likes.textAlignment = NSTextAlignmentCenter;
        caption.font = [UIFont systemFontOfSize:13];
        caption.numberOfLines = 0;
        [self.contentView addSubview:caption];
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

- (void)setTweetInfo:(NSDictionary *)tweetInfo
{
    _tweetInfo = tweetInfo;
    
    caption.text = tweetInfo[@"caption"];
    
    likes.text = [tweetInfo[@"likes"] stringValue];
}

@end
