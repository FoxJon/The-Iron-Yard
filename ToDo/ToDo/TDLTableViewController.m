//
//  TDLTableViewController.m
//  ToDo
//
//  Created by Jonathan Fox on 4/2/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewController.h"


@implementation TDLTableViewController

{
    //NSArray * listItems;        // This is a declaration
    NSArray * listItems;
    NSArray * listImages;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        //listItems = [[NSArray alloc]initWithObjects:@"Monday", @"Tuesday", @"Wednesday", nil];                    // Long way. Only need to alloc/init this one time. Pointer above sees this.
        // NSLog(@"List Items: %@...%@ %@", listItems, listItems[0], @"This concludes my list!");
        
        //listItems = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];       // The short way. A "literal"
        //for (NSString *day in listItems)
        //{
        //    NSLog(@"%@", day);
        //}
        
        listItems = @[@"Ali_Houshmand", @"Ashby_Thornwell", @"Austen_Johnson", @"Austin_Nolan", @"Derek_Weber", @"Ed_Salter", @"Heidi_Proske", @"Jeff_King", @"Jeffery_Moulds", @"Jisha_Obukwelu", @"John_Yam", @"Jon_Fox", @"Savitha_Reddy", @"TJ_Mercer", @"Teddy_Conyers"];
        listImages = @[[UIImage imageNamed:@"AliHoushmand"],
                       [UIImage imageNamed:@"AshbyThornwell"],
                       [UIImage imageNamed:@"AustenJohnson"],
                       [UIImage imageNamed:@"AustinNolan"],
                       [UIImage imageNamed:@"DerekWeber"],
                       [UIImage imageNamed:@"EdSalter"],
                       [UIImage imageNamed:@"HeidiProske"],
                       [UIImage imageNamed:@"JeffKing"],
                       [UIImage imageNamed:@"JefferyMoulds"],
                       [UIImage imageNamed:@"JishaObukwelu"],
                       [UIImage imageNamed:@"JohnYam"],
                       [UIImage imageNamed:@"JonFox"],
                       [UIImage imageNamed:@"SavithaReddy"],
                       [UIImage imageNamed:@"TJMercer"],
                       [UIImage imageNamed:@"TeddyConyers"]];
        
        self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
        self.tableView.rowHeight = 25;
        self.tableView.backgroundColor = [UIColor darkGrayColor];
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        header.backgroundColor = [UIColor greenColor];
        self.tableView.tableHeaderView = header;
        //[self.tableView setTableHeaderView:header]  is the same thing
        
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        footer.backgroundColor = [UIColor greenColor];
        self.tableView.tableFooterView = footer;


        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
        
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    int index = [indexPath row];
 
    // Configure the cell...
    // NSString * names = listItems[index];
    
    cell.textLabel.text = listItems[index];
    cell.imageView.image = listImages[index];
    cell.backgroundColor = [UIColor blueColor];

    
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
