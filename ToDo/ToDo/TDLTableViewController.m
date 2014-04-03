//
//  TDLTableViewController.m
//  ToDo
//
//  Created by Jonathan Fox on 4/2/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCell.h"

@implementation TDLTableViewController

{
    NSArray * listItems;    // This is a declaration
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {

        listItems = @[
                      @{@"name" : @"Ali_Houshmand", @"image" :[UIImage imageNamed:@"AliHoushmand"]},
                      @{@"name" : @"Ashby_Thornwell", @"image" : [UIImage imageNamed:@"AshbyThornwell"]},
                      @{@"name" : @"Austen_Johnson", @"image" : [UIImage imageNamed:@"AustenJohnson"]},
                      @{@"name" : @"Austin_Nolan", @"image" :[UIImage imageNamed:@"AustinNolan"]},
                      @{@"name" : @"Derek_Weber", @"image" : [UIImage imageNamed:@"DerekWeber"]},
                      @{@"name" : @"Ed_Salter", @"image" : [UIImage imageNamed:@"EdSalter"]},
                      @{@"name" : @"Heidi_Proske", @"image" : [UIImage imageNamed:@"HeidiProske"]},
                      @{@"name" : @"Jeff_King", @"image" : [UIImage imageNamed:@"JeffKing"]},
                      @{@"name" : @"Jeffery_Moulds", @"image" : [UIImage imageNamed:@"JefferyMoulds"]},
                      @{@"name" : @"Jisha_Obukwelu", @"image" : [UIImage imageNamed:@"JishaObukwelu"]},
                      @{@"name" : @"John_Yam", @"image" : [UIImage imageNamed:@"JohnYam"]},
                      @{@"name" : @"Jon_Fox", @"image" : [UIImage imageNamed:@"JonFox"]},
                      @{@"name" : @"Savitha_Reddy", @"image" : [UIImage imageNamed:@"SavithaReddy"]},
                      @{@"name" : @"TJ_Mercer", @"image" : [UIImage imageNamed:@"TJMercer"]},
                      @{@"name" : @"Teddy_Conyers", @"image" : [UIImage imageNamed:@"TeddyConyers"]},
                      ];
        

        self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
        self.tableView.rowHeight = 50;
        self.tableView.backgroundColor = [UIColor darkGrayColor];
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        header.backgroundColor = [UIColor greenColor];
        self.tableView.tableHeaderView = header;
        //[self.tableView setTableHeaderView:header]  is the same thing
        
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        footer.backgroundColor = [UIColor greenColor];
        self.tableView.tableFooterView = footer;


        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 300, 30)];
        
        titleHeader.text = @"My Class";
        titleHeader.textColor = [UIColor whiteColor];
        
        [header addSubview:titleHeader];
        
        
        
        
        
    }
    return self;
}

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

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //if (cell == nil)
        cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    int index = indexPath.row;                                      //Literal

    cell.backgroundColor = [UIColor blueColor];
    
    NSDictionary * listItem = listItems[index];                     // literal
    
    cell.profileInfo = listItem;

    return cell;
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
