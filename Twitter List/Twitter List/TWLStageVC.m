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
                            @"name": @"Jo Albright",
                            @"location": @"Atlanta, GA",
                            @"description": @"Co-Founder & iOS Developer for HighFive | iOS Instructor @TheIronYard"}
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
