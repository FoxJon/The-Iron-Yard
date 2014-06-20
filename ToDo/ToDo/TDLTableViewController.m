//
//  TDLTableViewController.m
//  ToDo
//
//  Created by Jonathan Fox on 4/2/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCell.h"
#import "TDLGitHubRequest.h"
#import "TDLSingleton.h"


@implementation TDLTableViewController

{
    UITextField * nameField;
    UINavigationController * navController;
}

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self)
    {
        UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newUser)];
        self.navigationItem.leftBarButtonItem = addButton;
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField{         // for the return button
    [self newUser];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 170, 35)];
    self.navigationItem.titleView = nameField;
    
    nameField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    nameField.layer.cornerRadius = 6;
    nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    nameField.leftViewMode = UITextFieldViewModeAlways;
    nameField.placeholder = @"Enter here";
    nameField.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    nameField.delegate = self;
    
    self.tableView.rowHeight = 100;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    header.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = header;
    //[self.tableView setTableHeaderView:header]  is the same thing
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    footer.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footer;
    
    
    UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 30)];
    
    titleHeader.text = @"Github Users";
    titleHeader.textColor = [UIColor lightGrayColor];
    titleHeader.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
    titleHeader.layer.cornerRadius = 6;
    titleHeader.layer.masksToBounds = YES;
    
    [header addSubview:titleHeader];

    
    
//    listItems = [@[
//                   @{@"name" : @"Ali_Houshmand", @"avatar_url" :[UIImage imageNamed:@"AliHoushmand"], @"html_url" : @"https://github.com/HoushmandA06"},
//                   @{@"name" : @"Ashby_Thornwell", @"avatar_url" : [UIImage imageNamed:@"AshbyThornwell"], @"html_url" : @"https://github.com/athornwell"},
//                   @{@"name" : @"Austen_Johnson", @"avatar_url" : [UIImage imageNamed:@"AustenJohnson"], @"html_url" : @"https://github.com/ajohnson21"},
//                   @{@"name" : @"Austin_Nolan", @"avatar_url" :[UIImage imageNamed:@"AustinNolan"], @"html_url" : @"https://github.com/adnolan99"},
//                   @{@"name" : @"Derek_Weber", @"avatar_url" : [UIImage imageNamed:@"DerekWeber"], @"html_url" : @"https://github.com/dweber03"},
//                   @{@"name" : @"Ed_Salter", @"avatar_url" : [UIImage imageNamed:@"EdSalter"], @"html_url" : @"https://github.com/MadArkitekt"},
//                   @{@"name" : @"Heidi_Proske", @"avatar_url" : [UIImage imageNamed:@"HeidiProske"], @"html_url" : @"https://github.com/justagirlcoding"},
//                   @{@"name" : @"Jeff_King", @"avatar_url" : [UIImage imageNamed:@"JeffKing"], @"html_url" : @"https://github.com/rampis"},
//                   @{@"name" : @"Jeffery_Moulds", @"avatar_url" : [UIImage imageNamed:@"JefferyMoulds"], @"html_url" : @"https://github.com/jdmgithub"},
//                   @{@"name" : @"Jisha_Obukwelu", @"avatar_url" : [UIImage imageNamed:@"JishaObukwelu"], @"html_url" : @"https://github.com/Jiobu"},
//                   @{@"name" : @"John_Yam", @"avatar_url" : [UIImage imageNamed:@"JohnYam"], @"html_url" : @"https://github.com/yamski"},
//                   @{@"name" : @"Jon_Fox", @"avatar_url" : [UIImage imageNamed:@"JonFox"], @"html_url" : @"https://github.com/FoxJon"},
//                   @{@"name" : @"Savitha_Reddy", @"avatar_url" : [UIImage imageNamed:@"SavithaReddy"], @"html_url" : @"https://github.com/savithareddy"},
//                   @{@"name" : @"TJ_Mercer", @"avatar_url" : [UIImage imageNamed:@"TJMercer"], @"html_url" : @"https://github.com/gwanunig14"},
//                   @{@"name" : @"Teddy_Conyers", @"avatar_url" : [UIImage imageNamed:@"TeddyConyers"], @"html_url" : @"https://github.com/talented76"},
//                   @{@"name" : @"Jo_Albright", @"avatar_url" : [UIImage imageNamed:@"JoAlbright"], @"html_url" : @"https://github.com/joalbright"},
//                   ]mutableCopy];
    
    NSMutableArray * listItems = [@[
                   @{
                       @"name" : @"Jon Fox",
                       @"avatar_url" : @"https://avatars1.githubusercontent.com/u/7116114?s=460",
                       @"html_url" : @"https://github.com/FoxJon",
                       @"location" : @"Chicago, IL"
                       },
                   @{
                       @"name" : @"John Yam",
                       @"avatar_url" : @"https://avatars1.githubusercontent.com/u/2688381?s=460",
                       @"html_url" : @"https://github.com/yamski",
                       @"location" : @"Atlanta, GA"
                       },
                   @{
                       @"name" : @"John Yam",
                       @"avatar_url" : @"https://avatars1.githubusercontent.com/u/2688381?s=460",
                       @"html_url" : @"https://github.com/yamski",
                       @"location" : @"Atlanta, GA"
                       }
                   
                   ] mutableCopy];
    
//    NSLog(@"%@", listItems);
//    NSLog(@"%@", listItems[1]);
//    NSLog(@"%@", listItems[1][@"name"]);

    
//    [self loadListItems];

    
    //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) newUser{
    
    NSString * userName = nameField.text;
    
    nameField.text = @"";
    
   // NSLog(@"%@", userName);
    
  //  NSLog(@"clicking");
    
    //[listItems addObject:@{@"name" : userName,@"avatar_url" : [UIImage imageNamed:@"unknown"],@"html_url" : [NSString stringWithFormat:@"https://github.com/%@", userName]}];
    
    NSDictionary * userInfo = [TDLGitHubRequest getUserWithUserName:userName];
    
    if ([[userInfo allKeys] count] > 4)
    {
        [[TDLSingleton sharedCollection] addListItem:userInfo];
    } else {
    //    NSLog(@"not enough data");
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Bad Information" message:@"Unable to add user." delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
        
        [alertView show];
    }
    [nameField resignFirstResponder];
    [self.tableView reloadData];
    
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
 //   return [listItems count];
    return [[[TDLSingleton sharedCollection] allListItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil){
        cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.index = indexPath.row;
//    cell.profileInfo = [self getListItem:indexPath.row];

    return cell;
}

#pragma mark - Clickable method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary * listItem = [[TDLSingleton sharedCollection] allListItems][indexPath.row];
    
   // NSLog(@"%@", [listItem objectForKey:@"html_url"]);
    
    UIViewController * webController = [[UIViewController alloc]init];
    
    UIWebView * webView = [[UIWebView alloc] init];
    
    webController.view = webView;
    
    [self.navigationController pushViewController:webController animated:YES];
    
    NSURL *url = [NSURL URLWithString:listItem[@"html_url"]];             //allocating a class method
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];          //allocating a class method
    
    [webView loadRequest:request];
    
    
    // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[listItem objectForKey:@"html_url"]]]];

}

#pragma - Delete Row

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

//    [listItems removeObjectAtIndex:indexPath.row];
    
//    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    [[TDLSingleton sharedCollection] removeListItemAtIndex:indexPath.row];
//    [listItems removeObjectIdenticalTo:listItem];
    
//    [self.tableView reloadData];
    
    TDLTableViewCell * cell = (TDLTableViewCell * )[tableView cellForRowAtIndexPath:indexPath];
    cell.alpha = 0;
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
//    [self saveData];
}


#pragma - Move Row

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    
//    if (sourceIndexPath == destinationIndexPath) return;  //  return stops the method from running
//    
//    NSDictionary * sourceItem = [self getListItem:sourceIndexPath.row];
//    
//    NSDictionary * toItem = [self getListItem:destinationIndexPath.row];
//    
//    [listItems removeObjectIdenticalTo:sourceItem];
//    [listItems insertObject:sourceItem atIndex:[listItems indexOfObject:toItem]];
//    
//    [self saveData];
//
//}


//- (NSDictionary *)getListItem:(NSInteger)row
//{
//    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
//    return reverseArray[row];
//    
//}


#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"preparing for segue: %@", segue.identifier);
//    
//    if ([segue.identifier isEqualToString:@"showGitHub"]) {

//        (TDLWebViewController *)segue.destinationViewControllern loadRequest:
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
//        [segue.destinationViewController setGitHubUrl:];
    //}
//}


@end
