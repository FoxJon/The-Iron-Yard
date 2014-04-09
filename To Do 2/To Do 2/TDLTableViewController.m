//
//  TDLTableViewController.m
//  To Do 2
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCell.h"


@implementation TDLTableViewController

{
    UITextField * nameField;
    UIButton * priorityLow;
    UIButton * priorityMed;
    UIButton * priorityHigh;
    NSMutableArray * listItems;
    NSArray * priorityColors;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        priorityColors = @[TAN_COLOR, YELLOW_COLOR, ORANGE_COLOR, RED_COLOR];
        
        listItems = [@[
                       @{@"name" : @"make app", @"priority": @0},
                       @{@"name" : @"write more code", @"priority": @1},
                       @{@"name" : @"fix bugs", @"priority": @2},
                       @{@"name" : @"write even more code", @"priority": @3}
                       
                       ]mutableCopy];
        
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.tableView.rowHeight = 50;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        header.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = header;
        
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 160, 30)];
        
        nameField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        nameField.layer.cornerRadius = 6;
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        nameField.leftViewMode = UITextFieldViewModeAlways;
        nameField.tintColor = [UIColor whiteColor];   // changes cursor color
        nameField.tintColor = [UIColor whiteColor];   // changes cursor color

        nameField.placeholder = @"To Do Item";
        
        
        nameField.delegate = self;

        
        [header addSubview:nameField];

        
        priorityLow = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 30, 30)];
        priorityLow.tag = 1;
        [priorityLow setTitle:@"L" forState:UIControlStateNormal];
        [priorityLow addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        priorityLow.backgroundColor = YELLOW_COLOR;
        priorityLow.layer.cornerRadius = 15;
        
        [header addSubview:priorityLow];

        
        priorityMed = [[UIButton alloc] initWithFrame:CGRectMake(240, 20, 30, 30)];
        priorityMed.tag = 2;
        [priorityMed setTitle:@"M" forState:UIControlStateNormal];
        [priorityMed addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];

        priorityMed.backgroundColor = ORANGE_COLOR;
        priorityMed.layer.cornerRadius = 15;
        
        [header addSubview:priorityMed];
        
        priorityHigh = [[UIButton alloc] initWithFrame:CGRectMake(280, 20, 30, 30)];
        priorityHigh.tag = 3;
        [priorityHigh setTitle:@"H" forState:UIControlStateNormal];
        [priorityHigh addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        priorityHigh.backgroundColor = RED_COLOR;
        priorityHigh.layer.cornerRadius = 15;
        
//        [header addSubview:priorityHigh];
        [self.tableView.tableHeaderView addSubview:priorityHigh];
        
        nameField.delegate = self;
        
    }
    return self;
}


- (void)addNewListItem:(id)sender{
    
    UIButton * button = (UIButton *)sender;
    NSString * name = nameField.text;
    nameField.text = @"";
    
    if(![name isEqualToString:@""]){
        [listItems insertObject:@{@"name" : name, @"priority": @(button.tag)} atIndex:0];
    }
    NSLog(@"%@", sender);
    [nameField resignFirstResponder];
    [self.tableView reloadData];
}

//- (void) newItem{
//    
//    NSString * itemName = nameField.text;
//    
//    nameField.text = @"";
//    
//    [nameField resignFirstResponder];
//    
//    [listItems insertObject:itemName atIndex:0];
//    
//    NSLog(@"%@", listItems);
//    
//    NSLog(@"clicking");
//    
//    [self.tableView reloadData];
//    
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{         // for the return button
//    [self newItem];
//    return YES;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textColor = [UIColor whiteColor];                 //typing color
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"To Do Item";

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    NSDictionary * listItem = listItems[indexPath.row];
    
//    cell.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];

    cell.bgView.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];

    cell.nameLabel.text = listItem[@"name"];

    
    return cell;
}

#pragma - Delete Row

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [listItems removeObjectAtIndex:indexPath.row];

    TDLTableViewCell * cell = (TDLTableViewCell * )[tableView cellForRowAtIndexPath:indexPath];
    cell.alpha = 0;
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self saveData];

}

#pragma - Move Row

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    if (sourceIndexPath == destinationIndexPath) return;  //  return stops the method from running

    [self saveData];
    
}

#pragma mark - Save data


- (void)saveData{
    NSString * path = [self listArchivePath];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:listItems];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}

-(NSString *)listArchivePath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
}

- (void) loadListItems{
    NSString * path = [self listArchivePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        listItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}


@end
