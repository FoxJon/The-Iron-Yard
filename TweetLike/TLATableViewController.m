//
//  TLATableViewController.m
//  TweetLike
//
//  Created by Jonathan Fox on 4/23/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TLATableViewController.h"
#import "TLATableViewCell.h"

@interface TLATableViewController () <UITextFieldDelegate>

@end

@implementation TLATableViewController
{
//    NSMutableArray * tweetItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.tweetItems = [
                      // starts array
                      @[
                        //starts dictionary at index 0
//                        @{
//                            @"likes":@32,
//                            @"caption":@"No more shall I go on, without first looking ahead"},
//                        //starts dictionary at index 1
//                        @{
//                            @"likes":@75,
//                            @"caption":@"I like to eat chocolates while reading romance novels"},
                        ]mutableCopy];

        
        self.tableView.separatorColor = [UIColor blueColor];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

        self.tableView.rowHeight = 80;
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textColor = [UIColor whiteColor];                 //typing color
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Add To Do Item";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)prefersStatusBarHidden {return YES;}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tweetItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) cell = [[TLATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.tweetInfo = self.tweetItems[indexPath.row];
    
    return cell;
}

- (void)createNewTweet:(NSString *)tweet
{
    if ([tweet isEqualToString:@"'"]) return;
    
    [self.tweetItems insertObject:@{
                                   @"likes" : @0,
                                   @"caption": tweet
                                   }atIndex:0];
    [self.tableView reloadData];
}


-(BOOL)isTweetItemsEmpty
{
    return ([self.tweetItems count] == 0);
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

@end
