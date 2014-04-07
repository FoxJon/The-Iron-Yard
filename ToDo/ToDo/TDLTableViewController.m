//
//  TDLTableViewController.m
//  ToDo
//
//  Created by Jonathan Fox on 4/2/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCell.h"
#import "TDLWebViewController.h"

@implementation TDLTableViewController

{
    NSMutableArray * listItems;    // This is a declaration
    UITextField * nameField;
}

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self)
    {

        
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textColor = [UIColor blackColor];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Enter here";
}


- (void) newUser{
    
    NSString * userName = nameField.text;
    
    nameField.text = @"";
    
    NSLog(@"%@", userName);

    
    NSLog(@"clicking");
    
    [listItems addObject:@{@"name" : userName,@"image" : [UIImage imageNamed:@"unknown"],@"github" : [NSString stringWithFormat:@"https://github.com/%@", userName]}];
   
    [nameField resignFirstResponder];
    [self.tableView reloadData];
    
    NSLog(@"listItems Count : %d", [listItems count]);
    }

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self newUser];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listItems = [@[
                   @{@"name" : @"Ali_Houshmand", @"image" :[UIImage imageNamed:@"AliHoushmand"], @"github" : @"https://github.com/HoushmandA06"},
                   @{@"name" : @"Ashby_Thornwell", @"image" : [UIImage imageNamed:@"AshbyThornwell"], @"github" : @"https://github.com/athornwell"},
                   @{@"name" : @"Austen_Johnson", @"image" : [UIImage imageNamed:@"AustenJohnson"], @"github" : @"https://github.com/ajohnson21"},
                   @{@"name" : @"Austin_Nolan", @"image" :[UIImage imageNamed:@"AustinNolan"], @"github" : @"https://github.com/adnolan99"},
                   @{@"name" : @"Derek_Weber", @"image" : [UIImage imageNamed:@"DerekWeber"], @"github" : @"https://github.com/dweber03"},
                   @{@"name" : @"Ed_Salter", @"image" : [UIImage imageNamed:@"EdSalter"], @"github" : @"https://github.com/MadArkitekt"},
                   @{@"name" : @"Heidi_Proske", @"image" : [UIImage imageNamed:@"HeidiProske"], @"github" : @"https://github.com/justagirlcoding"},
                   @{@"name" : @"Jeff_King", @"image" : [UIImage imageNamed:@"JeffKing"], @"github" : @"https://github.com/rampis"},
                   @{@"name" : @"Jeffery_Moulds", @"image" : [UIImage imageNamed:@"JefferyMoulds"], @"github" : @"https://github.com/jdmgithub"},
                   @{@"name" : @"Jisha_Obukwelu", @"image" : [UIImage imageNamed:@"JishaObukwelu"], @"github" : @"https://github.com/Jiobu"},
                   @{@"name" : @"John_Yam", @"image" : [UIImage imageNamed:@"JohnYam"], @"github" : @"https://github.com/yamski"},
                   @{@"name" : @"Jon_Fox", @"image" : [UIImage imageNamed:@"JonFox"], @"github" : @"https://github.com/FoxJon"},
                   @{@"name" : @"Savitha_Reddy", @"image" : [UIImage imageNamed:@"SavithaReddy"], @"github" : @"https://github.com/savithareddy"},
                   @{@"name" : @"TJ_Mercer", @"image" : [UIImage imageNamed:@"TJMercer"], @"github" : @"https://github.com/gwanunig14"},
                   @{@"name" : @"Teddy_Conyers", @"image" : [UIImage imageNamed:@"TeddyConyers"], @"github" : @"https://github.com/talented76"},
                   @{@"name" : @"Jo_Albright", @"image" : [UIImage imageNamed:@"JoAlbright"], @"github" : @"https://github.com/joalbright"},
                   ]mutableCopy];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    self.tableView.rowHeight = 100;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    header.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = header;
    //[self.tableView setTableHeaderView:header]  is the same thing
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    footer.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footer;
    
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 160, 30)];
    
    nameField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    nameField.layer.cornerRadius = 6;
    nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    nameField.leftViewMode = UITextFieldViewModeAlways;
    nameField.placeholder = @"Enter here";
    nameField.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    nameField.delegate = self;
    
    
    [header addSubview:nameField];
    
    UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 30)];
    
    [submitButton setTitle:@"New User" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor = [UIColor darkGrayColor];
    submitButton.layer.cornerRadius = 6;
    
    [header addSubview:submitButton];
    
    UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 30)];
    
    titleHeader.text = @"Github Users";
    titleHeader.textColor = [UIColor lightGrayColor];
    titleHeader.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
    titleHeader.layer.cornerRadius = 6;
    titleHeader.layer.masksToBounds = YES;
    
    
    
    
    [header addSubview:titleHeader];
    
    
    
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
    
    if (cell == nil)
        cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
       
    cell.profileInfo = [self getListItem:indexPath.row];

    return cell;
}

#pragma mark - Clickable method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    NSLog(@"%@", [listItem objectForKey:@"github"]);
    



}

- (NSDictionary *)getListItem:(NSInteger)row
{
    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
    return reverseArray[row];
    
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"preparing for segue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"showGitHub"]) {
        
//        (TDLWebViewController *)segue.destinationViewControllern loadRequest:<#(NSURLRequest *)#>
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
//        [segue.destinationViewController setGitHubUrl:];
    }
}


@end
