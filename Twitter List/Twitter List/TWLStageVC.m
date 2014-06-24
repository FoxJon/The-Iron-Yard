//
//  TWLRootViewController.m
//  Twitter List
//
//  Created by Jonathan Fox on 4/13/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TWLStageVC.h"
#import "TWLCell.h"

@implementation TWLStageVC
{
    NSMutableArray *listItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        listItems = [@[
                        @{
//                            @"name": @"Jo Albright",
//                            @"location": @"Atlanta, GA",
//                            @"description": @"Co-Founder & iOS Developer for HighFive | iOS Instructor @TheIronYard"}
                            @"created_at": "Sat Apr 12 03:35:47 +0000 2014",
                            @"id": 454825180305817600,
                            @"id_str": "454825180305817600",
                            @"text": "@foxjon123 What an awesome #FirstTweet ! So excited that you are doing things outside of what is being taught @TheIronYard #YouRock",
                            @"source": "<a href=\"http://itunes.apple.com/us/app/twitter/id409789998?mt=12\" rel=\"nofollow\">Twitter for Mac</a>",
                            @"truncated": NO,
                            @"in_reply_to_status_id": 454805152306696200,
                            @"in_reply_to_status_id_str": "454805152306696193",
                            @"in_reply_to_user_id": 2435447227,
                            @"in_reply_to_user_id_str": "2435447227",
                            @"in_reply_to_screen_name": "foxjon123",
                            @"user":  {
                                @"id": 18487945,
                                @"id_str": "18487945",
                                @"name": "Jo Albright",
                                @"screen_name": "Joalbright",
                                @"location": "",
                                @"description": "Co-Founder & iOS Developer for HighFive | iOS Instructor @TheIronYard",
                                @"url": "http://t.co/0j8pzmKFox",
                                @"entities":  {
                                    @"url":  {
                                        @"urls":  [
                                                  {
                                                      @"url": @"http://t.co/0j8pzmKFox",
                                                      @"expanded_url": @"http://jo2.co",
                                                      @"display_url": @"jo2.co",
                                                      @"indices":@"0"
                                                  }
                                            ],
                                    },
                                    @"description":  {
                                        @"urls":null,
                                    }
                                },
            @"protected": NO,
            @"followers_count": 207,
            @"friends_count": 313,
            @"listed_count": 12,
            @"created_at": "Tue Dec 30 20:46:32 +0000 2008",
            @"favourites_count": 26,
            @"utc_offset": -14400,
            @"time_zone": "Eastern Time (US & Canada)",
            @"geo_enabled": YES,
            @"verified": NO,
            @"statuses_count": 201,
            @"lang": "en",
            @"contributors_enabled": NO,
            @"is_translator": NO,
            @"is_translation_enabled": NO,
            @"profile_background_color": "FFFFFF",
            @"profile_background_image_url": "http://pbs.twimg.com/profile_background_images/267632372/logo.jpg",
            @"profile_background_image_url_https": "https://pbs.twimg.com/profile_background_images/267632372/logo.jpg",
            @"profile_background_tile": NO,
            @"profile_image_url": "http://pbs.twimg.com/profile_images/420687815211364352/wF9mtzLq_normal.jpeg",
            @"profile_image_url_https": "https://pbs.twimg.com/profile_images/420687815211364352/wF9mtzLq_normal.jpeg",
            @"profile_banner_url": "https://pbs.twimg.com/profile_banners/18487945/1391875911",
            @"profile_link_color": "00E0E0",
            @"profile_sidebar_border_color": "FFFFFF",
            @"profile_sidebar_fill_color": "F7F7F7",
            @"profile_text_color": "424242",
            @"profile_use_background_image": true,
            @"default_profile": NO,
            @"default_profile_image": NO,
            @"following": NO,
            @"follow_request_sent": NO,
            @"notifications": NO
        },
                            @"geo": null,
                            @"coordinates": null,
                            @"place": null,
                            @"contributors": null,
                            @"retweet_count": 0,
                            @"favorite_count": 0,
                            @"entities":  {
            @"hashtags":  [
                          {
                              @"text": "FirstTweet",
                              @"indices":  [
                                           27,
                                           38
                                           ]
                          },
                          {
                              @"text": "YouRock",
                              @"indices":  [
                                           123,
                                           131
                                           ]
                          }
                          ],
            @"symbols":  [],
            @"urls":  [],
            @"user_mentions":  [
                               {
                                   @"screen_name": "foxjon123",
                                   @"name": "Jon Fox",
                                   @"id": 2435447227,
                                   @"id_str": "2435447227",
                                   @"indices":  [
                                                0,
                                                10
                                                ]
                               },
                               {
                                   @"screen_name": "TheIronYard",
                                   @"name": "The Iron Yard",
                                   @"id": 576311383,
                                   @"id_str": "576311383",
                                   @"indices":  [
                                                110,
                                                122
                                                ]
                               }
                               ]
        },
                            @"favorited": NO,
                            @"retweeted": NO,
                            @"lang": "en"
                        ]mutableCopy];
        
        self.tableView.rowHeight = 100;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        header.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = header;
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
        cell = [[TWLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    NSDictionary * listItem = listItems[indexPath.row];
    
    cell.backgroundColor = [UIColor blueColor];
    
    cell.nameLabel.text = listItem[@"name"];
    cell.locationLabel.text = listItem[@"location"];
    cell.descriptionLabel.text = listItem[@"description"];
    
    return cell;
}



@end
