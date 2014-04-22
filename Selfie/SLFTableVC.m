//
//  SLFTableVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/21/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFTableVC.h"
#import "SLFTableViewCell.h"

@interface SLFTableVC ()

@end

@implementation SLFTableVC
{
NSArray * selfies;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        selfies = @[
                    @{@"image":[UIImage imageNamed:@"JonFox"],
                      @"caption":@"Howdy!"
                      },
                    @{
                      @"image":[UIImage imageNamed:@"AliHoushmand"],
                      @"caption":@"Hey"
                      }
                    ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    header.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = header;
    
    UILabel *selfyLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-25), 0, 100, 40)];
    selfyLabel.text = @"SELFY";
    [header addSubview:selfyLabel];

    UIButton *addButton = [UIButton buttonWithType:
                               UIButtonTypeContactAdd];
    [addButton setFrame:CGRectMake(200, 0, 200, 40)];
    [header addSubview:addButton];
    
    UILabel *settings = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    settings.text = @"\u2699";
    [header addSubview:settings];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [selfies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * selfy = selfies[indexPath.row];
        
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    
    if (cell == nil)
    {
        cell = [[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    
    cell.imageView.image = selfy[@"image"];
    cell.detailTextLabel.text = selfy[@"caption"];


    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSDictionary * listItem = [self getListItem:indexPath.row];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)prefersStatusBarHidden {return YES;}


@end
