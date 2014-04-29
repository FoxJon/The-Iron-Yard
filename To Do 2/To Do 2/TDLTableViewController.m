//
//  TDLTableViewController.m
//  To Do 2
//
//  Created by Jonathan Fox on 4/8/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLTableViewController.h"
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

#pragma mark - set up tableview/header/textfield/circle buttons

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        priorityColors = @[TAN_COLOR, YELLOW_COLOR, ORANGE_COLOR, RED_COLOR];
        
        listItems = [@[
                       @{@"name" : @"make app", @"priority": @0, @"constant": @1},
                       @{@"name" : @"write more code", @"priority": @1, @"constant": @1},
                       @{@"name" : @"                 fix bugs", @"priority": @2,  @"constant": @2},
                       @{@"name" : @"write even more code", @"priority": @3,  @"constant": @3}
                       
                       ]mutableCopy];
        
        self.view.backgroundColor = [UIColor colorWithRed:0.937f green:0.965f blue:0.820f alpha:1.0f];
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.tableView.rowHeight = 50;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        header.backgroundColor = [UIColor colorWithRed:0.937f green:0.965f blue:0.820f alpha:1.0f];
        self.tableView.tableHeaderView = header;
        
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 180, 30)];
        
        nameField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        nameField.layer.cornerRadius = 6;
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        nameField.leftViewMode = UITextFieldViewModeAlways;
        nameField.tintColor = [UIColor whiteColor];   // changes cursor color
        nameField.tintColor = [UIColor whiteColor];   // changes cursor color

        nameField.placeholder = @"Add To Do Item";
        
        
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

-(void)deleteItem:(TDLCell *)cell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    [listItems removeObjectAtIndex:indexPath.row];

    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


-(void)setItemPriority:(int)priority withItem:(TDLCell *)cell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    NSDictionary * listItem = listItems[indexPath.row];
    
    NSDictionary * updateListItem = @{
                       @"name" : listItem[@"name"],
                       @"priority" : @(priority),
                       @"constant" : @(priority)
                       };


    //remove old dictionary for cell
    [listItems removeObjectAtIndex:indexPath.row];

    // add new dictionary for cell
    [listItems insertObject:updateListItem atIndex:indexPath.row];

    cell.bgView.backgroundColor = priorityColors[priority];
    
    [MOVE animateView:cell.bgView  properties:@{@"x":@10, @"duration":@0.5}];
    [cell hideCircleButtons];
    cell.swiped = NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Add new items to the list

- (void)addNewListItem:(id)sender{
    
    UIButton * button = (UIButton *)sender;
    NSString * name = nameField.text;
    nameField.text = @"";
    
    if(![name isEqualToString:@""]){
        [listItems insertObject:@{@"name" : name, @"priority": @(button.tag),@"constant": @(button.tag)} atIndex:0];
    }
    NSLog(@"%@", sender);
    [nameField resignFirstResponder];
    [self.tableView reloadData];
}

#pragma mark - text field palceholder disappear/reappear

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textColor = [UIColor whiteColor];                 //typing color
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Add To Do Item";
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

#pragma mark - recycle the cells

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    TDLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
        cell = [[TDLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    [cell resetLayout];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  // No highlight!
    
    cell.delegate = self;   // view controller says to TDLCell, "I will be your delegate!"
    
#pragma mark - place items and set priority colors into the cells
    
    NSDictionary * listItem = listItems[indexPath.row];
    
//    cell.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];

    cell.bgView.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    cell.nameLabel.text = listItem[@"name"];

#pragma mark - show strikethrough if priority is 0/circles if priority is 1
    
    if ([listItem[@"priority"] intValue] == 0)
    {
        cell.strikeThrough.alpha = 1;
        cell.circleButton.alpha = 0;
    } else {
        cell.strikeThrough.alpha = 0;
        cell.circleButton.alpha = 1;
    }

#pragma mark - Swipe gestures

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [cell addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [cell addGestureRecognizer:swipeRight];
    
    return cell;
}

# pragma mark - Click cell for selection/disable click if slid left

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * listItem = listItems[indexPath.row];
    
    // get cell from tbv at row
    TDLCell * cell = (TDLCell *) [tableView cellForRowAtIndexPath:indexPath];
    
   if (cell.swiped)
    {
        return;
    }
    
#pragma mark - strikethrough
    
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
#pragma mark - update list items
    
    NSDictionary * updateListItem = listItem;
    
    //create new dictionary with the done priority
    if ([listItem[@"priority"] intValue])
    {
        cell.bgView.backgroundColor = priorityColors[0];
        cell.strikeThrough.alpha = 1;
        cell.circleButton.alpha = 0;
        updateListItem = @{
                        @"name" : listItem[@"name"],
                        @"priority" : @0,
                        @"constant" :listItem [@"constant"]
                        };
    }else{
        cell.bgView.backgroundColor = priorityColors[[listItem[@"constant"] intValue]];
        cell.strikeThrough.alpha = 0;
        cell.circleButton.alpha = 1;
        updateListItem = @{
                           @"name" : listItems[indexPath.row][@"name"],
                           @"priority" : listItems[indexPath.row][@"constant"],                         @"constant" :listItems[indexPath.row][@"constant"]
                           };
    }
    
    //remove old dictionary for cell
    [listItems removeObjectAtIndex:indexPath.row];
    
    // add new dictionary for cell
    [listItems insertObject:updateListItem atIndex:indexPath.row];
}

#pragma mark - Swipe Cell

-(void)swipeCell:(UISwipeGestureRecognizer *)gesture{
    
    TDLCell * cell = (TDLCell *)gesture.view;
    
    NSInteger index = [self.tableView indexPathForCell:cell].row;

    NSDictionary * listItem = listItems[index];

    
//    NSInteger index = [self.tableView indexPathForCell:cell.row];
    
    //    gesture.direction == left : 2
    //    gesture.direction == right : 1
    //    gesture.direction == left && priority == 0 : 12
    //    gesture.direction == right && priority == 0 : 11
    
    //swipe left or right
    
    int completed;
    
//    if([listItem[@"priority"] intValue] == 0)
//    {
//        complete = 10;
//    }else{
//        complete = 0;
//    }
    
    completed = ([listItem[@"priority"] intValue] == 0) ? 10 : 0; // this says the above code
    
    
    switch (gesture.direction + completed) {
        case 1:
            NSLog(@"Swiping right");
            
            [MOVE animateView:cell.bgView properties:@{@"x": @10,@"duration" : @0.5}];
            [cell hideCircleButtons];
            cell.swiped = NO;
            break;
        case 2:
            NSLog(@"Swiping left");
            
            [MOVE animateView:cell.bgView properties:@{@"x": @-110,@"duration" : @0.5}];
            [cell showCircleButtons];
            cell.swiped = YES;
            break;
            
        case 11: // right
            [MOVE animateView:cell.bgView properties:@{@"x": @10,@"duration" : @0.5}];
            [cell hideDeleteButton];
            cell.swiped = NO;
            break;
            
        case 12:// left
            [MOVE animateView:cell.bgView properties:@{@"x": @-40,@"duration" : @0.3}];
            [cell showDeleteButton];
            cell.swiped = YES;
            break;
        
        default:
            break;
    }
}


#pragma mark - Remove status bar

- (BOOL)prefersStatusBarHidden
    {return YES;}

#pragma mark - Show Delete if striken and slid left

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
//}

#pragma mark - Move Row

//- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    
//    if (sourceIndexPath == destinationIndexPath) return;  //  return stops the method from running
//    
//}

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
