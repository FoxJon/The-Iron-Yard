//
//  TDLTableViewController.m
//  To Do 2
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCell.h"
#import "MOVE.h"


@implementation TDLTableViewController

{
    UITextField * nameField;
    UIButton * priorityLow;
    UIButton * priorityMed;
    UIButton * priorityHigh;
    NSMutableArray * listItems;
    NSArray * priorityColors;
    
}

#pragma - set up tableview/header/textfield/circle buttons

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        priorityColors = @[TAN_COLOR, YELLOW_COLOR, ORANGE_COLOR, RED_COLOR];
        
        listItems = [@[
//                       @{@"name" : @"make app", @"priority": @0},
//                       @{@"name" : @"write more code", @"priority": @1},
//                       @{@"name" : @"fix bugs", @"priority": @2},
//                       @{@"name" : @"write even more code", @"priority": @3}
                       
                       ]mutableCopy];
        
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.tableView.rowHeight = 50;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        header.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = header;
        
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 180, 30)];
        
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
        
        [header addSubview:priorityHigh];
        //[self.tableView.tableHeaderView addSubview:priorityHigh];
        
        nameField.delegate = self;
        
    }
    return self;
}

#pragma - Add new items to the list

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

#pragma - text field palceholder disappear/reappear

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

#pragma mark - Table view - set up number of rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listItems count];
}

#pragma - recycle the cells

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
        cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  // No highlight!
    
#pragma - place items and set priority colors into the cells
    
    NSDictionary * listItem = listItems[indexPath.row];
    
//    cell.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];

    cell.bgView.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    cell.nameLabel.text = listItem[@"name"];

#pragma - show strikethrough if priority is 0/circles if priority is 1
    
    if ([listItem[@"priority"] intValue] == 0)
    {
        cell.strikeThrough.alpha = 1;
        cell.circleButton.alpha = 0;
    } else {
        cell.strikeThrough.alpha = 0;
        cell.circleButton.alpha = 1;
    }

#pragma - Swipe gestures

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [cell addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [cell addGestureRecognizer:swipeRight];
    
    return cell;
}

# pragma mark - Click cell for selection

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // get cell from tbv at row
    TDLTableViewCell * cell = (TDLTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    //if (<#condition#>) {
//        return;
//    }
    
#pragma - strikethrough
    //set cell backgound to the done color
//    cell.bgView.backgroundColor = priorityColors[0];
//    cell.strikeThrough.alpha = 1;
//    cell.circleButton.alpha = 0;
    
    if (cell.strikeThrough.alpha == 0)
    {
        cell.bgView.backgroundColor = priorityColors[0];
        cell.strikeThrough.alpha = 1;
        cell.circleButton.alpha = 0;
    }else{
        cell.bgView.backgroundColor = priorityColors[1];
        cell.strikeThrough.alpha = 0;
        cell.circleButton.alpha = 1;
    }
    
    
    //create new dictionary with the done priority
    NSDictionary * updateListItem = @{
                                    @"name" : listItems[indexPath.row][@"name"],
                                    @"priority" : @0
                                    };
    
    //remove old dictionary for cell
    [listItems removeObjectAtIndex:indexPath.row];
    
    // add new dictionary for cell
    [listItems insertObject:updateListItem atIndex:indexPath.row];
}

#pragma mark - Swipe Cell

-(void)swipeCell:(UISwipeGestureRecognizer *)gesture{
    
    TDLTableViewCell * cell = (TDLTableViewCell *)gesture.view;
    
//    NSInteger index = [self.tableView indexPathForCell:cell.row];
    
    switch (gesture.direction) {
        case 1:
            NSLog(@"Swiping right");
            
            [MOVE animateView:cell.bgView properties:@{
                                                @"x": @10,
                                                @"duration" : @0.5
                                                }];
            [cell hideCircleButtons];
            break;
        case 2:
            NSLog(@"Swiping left");
            
            [MOVE animateView:cell.bgView properties:@{
                                                       @"x": @-110,
                                                       @"duration" : @0.5
                                                       }];
            [cell showCircleButtons];
            
            break;
        default:
            break;
    }
}


#pragma mark - Remove status bar

- (BOOL)prefersStatusBarHidden
    {return YES;}

#pragma - Delete Row

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [listItems removeObjectAtIndex:indexPath.row];
//
//    TDLTableViewCell * cell = (TDLTableViewCell * )[tableView cellForRowAtIndexPath:indexPath];
//    cell.alpha = 0;
//
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//    [self saveData];
//
//}

#pragma - Move Row

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    if (sourceIndexPath == destinationIndexPath) return;  //  return stops the method from running
    
}

#pragma mark - Save data


//- (void)saveData{
//    NSString * path = [self listArchivePath];
//    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:listItems];
//    [data writeToFile:path options:NSDataWritingAtomic error:nil];
//}
//
//-(NSString *)listArchivePath{
//    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentDirectory = documentDirectories[0];
//    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
//}
//
//- (void) loadListItems{
//    NSString * path = [self listArchivePath];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//        listItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    }
//}

@end
