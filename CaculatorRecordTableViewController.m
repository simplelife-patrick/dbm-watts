//
//  CaculatorRecordTableViewController.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-24.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorRecordTableViewController.h"

@interface CaculatorRecordTableViewController ()

@end

@implementation CaculatorRecordTableViewController

@synthesize caculatorModel;

@synthesize deleteEnabled;
@synthesize multiselectEnabled;
@synthesize deletingRecords = _deletingRecords;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
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

    [self.navigationController setNavigationBarHidden:FALSE];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,5)];
//    [self initCustomNavigationBar];
    
    _deletingRecords = [NSMutableArray arrayWithCapacity:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.caculatorModel recordsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CaculatorRecordTableViewCell";
    CaculatorRecordTableViewCell *cell = (CaculatorRecordTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CaculatorRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(CaculatorRecordTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.item;
    NSUInteger reversedIndex = [self.caculatorModel recordsCount] - 1 - index;
    CaculatorRecord* record = [self.caculatorModel recordAtIndex:reversedIndex];
    [cell updateCellWithRecord:record];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)initCustomNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    bar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bar.layer.borderWidth = UI_CACULATOR_BUTTON_BORDERWIDTH;
    bar.layer.cornerRadius = UI_CACULATOR_BUTTON_CORNERRADIUS;
    bar.frame = CGRectMake(5, 5, 310, 44);
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(0, 2, 60, 28)];
    [left setBackgroundImage:[UIImage imageNamed:@"barbuttonitem.png"] forState:UIControlStateNormal];
    [left setBackgroundImage:[UIImage imageNamed:@"barbuttonitem.png"] forState:UIControlStateHighlighted];
    [left addTarget:self action:@selector(backToNavigationController) forControlEvents:UIControlEventTouchUpInside];
    [left setTitle:@"Back" forState:UIControlStateNormal];
    [left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [left setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [left.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    
//    left.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    left.layer.borderWidth = UI_CACULATOR_BUTTON_BORDERWIDTH;
    left.layer.cornerRadius = UI_CACULATOR_BUTTON_CORNERRADIUS;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    
    [item setLeftBarButtonItem:leftButton];
    [bar pushNavigationItem:item animated:NO];
    [self.view addSubview:bar];
}

- (void)backToNavigationController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

@end
