//
//  _rdMasterViewController.m
//  3rd
//
//  Created by BINGCHEN YU on 1/30/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import "_rdMasterViewController.h"

#import "TaskDataController.h"
#import "NewTask.h"
#import "AddDataController.h"
//#import "TaskDataController.m"

/*
@interface _rdMasterViewController () {
    NSMutableArray *_objects;
}
@end
*/
@implementation _rdMasterViewController

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if([[segue identifier] isEqualToString:@"ReturnInput"]){
        AddDataController *addController =[segue sourceViewController];
        if(addController.task){
            [self.dataController addNewTask:addController.task];
            [[self tableView] reloadData];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)cancle:(UIStoryboardSegue *)segue
{
    if([[segue identifier] isEqualToString:@"CancleInput"]){
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.dataController = [[TaskDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    NSLog(@"View did load");
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    if ([fileManager fileExistsAtPath:plistPath] == YES)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        //[self dataController].masterTaskList = [dict objectForKey:@"text"];
        NSLog(@"%@",[self dataController].masterTaskList);
     
        //[self.tableView reloadData];
    }
    /*
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"Entering Background");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    NSMutableArray *temp = [self dataController].masterTaskList;
    NSLog(@"%@",temp);
    [[NSDictionary dictionaryWithObject:temp forKey:@"text"] writeToFile:plistPath atomically:YES];
}

/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for at index path");
    static NSString *CellIdentifier = @"TaskCell";
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSLog(@"%@", cell);
    NewTask *sightingAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
    
    // generate the cell under two different contidtions
    if ([[self dataController].masterTaskList[indexPath.row] complete] == NO) {
        [[cell textLabel] setText:sightingAtIndex.name];
        [[cell detailTextLabel] setText:@"."];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
        
        NSDictionary* attributes = @{
    NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]
        };
        
        NSAttributedString* attrText = [[NSAttributedString alloc] initWithString:[[self dataController].masterTaskList[indexPath.row] name] attributes:attributes];
        [[cell textLabel] setAttributedText:attrText];
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self.dataController masterTaskList] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row selected");
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", cell);
    if([[self dataController].masterTaskList[indexPath.row] complete] == NO)
    {
        [self.dataController.masterTaskList[indexPath.row] setComplete:YES];
    }
    else
    {
        [self.dataController.masterTaskList[indexPath.row] setComplete:NO];
    }
    
    [self.tableView reloadData];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

    //[[cell textLabel] setAttributedText:attrText];
     
    //NSString *CellIdentifier = @"TaskCell";
    

    
    //[self.tableView cellForRowAtIndexPath:indexPath];
    //NSLog(attrText);
    //[self.tableView reloadData];
    //[self viewDidLoad] ;
    /*
     *detailViewController = [[ alloc] initWithNibName:@"" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        _rdDetailViewController *detailController = [segue destinationViewController];
        detailController.detailItem = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}
*/
@end
