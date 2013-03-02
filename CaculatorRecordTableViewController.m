//
//  CaculatorRecordTableViewController.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-24.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorRecordTableViewController.h"

@interface CaculatorRecordTableViewController ()

@property UIBarButtonItem* editBarButton;
@property UIBarButtonItem* selectAllBarButton;
@property UIBarButtonItem* deleteBarButton;
@property UIBarButtonItem* cancelBarButton;

@property BOOL isSelectedAll;

@end

@implementation CaculatorRecordTableViewController

@synthesize caculatorModel;

@synthesize editBarButton = _editBarButton;
@synthesize selectAllBarButton = _selectAllBarButton;
@synthesize deleteBarButton = _deleteBarButton;
@synthesize cancelBarButton = _cancelBarButton;

@synthesize isSelectedAll = _isSelectedAll;

- (NSUInteger) recordIndexInModel:(NSIndexPath*) indexPathInTable
{
    NSInteger index = indexPathInTable.item;
    NSUInteger reversedIndex = [self.caculatorModel recordsCount] - 1 - index;
    return reversedIndex;
}

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

    [self.navigationController setNavigationBarHidden:FALSE];
//    [self initCustomNavigationBar];
    _selectAllBarButton = [[UIBarButtonItem alloc] initWithTitle:@"SelectAll" style:UIBarButtonItemStylePlain target:self action:@selector(onSelectAllBarButtonClicked)];
    _editBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onEditBarButtonClicked)];
    _deleteBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(onDeleteBarButtonClicked)];
    _cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = _editBarButton;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelectionDuringEditing = TRUE;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,5)];

    _isSelectedAll = FALSE;
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
    NSUInteger index = [self recordIndexInModel:indexPath];
    CaculatorRecord* record = [self.caculatorModel recordAtIndex:index];
    [cell updateCellWithRecord:record];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.isEditing)
    {
        [self setIsSelectedAll:FALSE];
        
        NSArray* selectedRows = [self.tableView indexPathsForSelectedRows];
        if (0 < selectedRows.count)
        {
            self.navigationItem.rightBarButtonItems = @[_deleteBarButton, _selectAllBarButton];
        }
        else
        {
            self.navigationItem.rightBarButtonItems = @[_cancelBarButton, _selectAllBarButton];
        }
    }
    else
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.tableView.isEditing)
    {
        NSArray* selectedRows = [self.tableView indexPathsForSelectedRows];
        
        if (0 < selectedRows.count)
        {
            self.navigationItem.rightBarButtonItems = @[_deleteBarButton, _selectAllBarButton];
        }
        else
        {
            self.navigationItem.rightBarButtonItems = @[_cancelBarButton, _selectAllBarButton];
        }
        
        if ([self.caculatorModel recordsCount] == selectedRows.count)
        {
            [self setIsSelectedAll:TRUE];
        }
        else
        {
            [self setIsSelectedAll:FALSE];
        }
    }
    else
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    }
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

-(void) onSelectAllBarButtonClicked
{
    if (self.isSelectedAll)
    {
        NSUInteger rowCount = [self.caculatorModel recordsCount];
        for (NSInteger integer = 0; integer < rowCount; integer++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:integer inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:TRUE];
        }
        
        self.navigationItem.rightBarButtonItems = @[_cancelBarButton, _selectAllBarButton];
        [self setIsSelectedAll:FALSE];
    }
    else
    {
        NSUInteger rowCount = [self.caculatorModel recordsCount];
        for (NSInteger integer = 0; integer < rowCount; integer++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:integer inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:TRUE scrollPosition:UITableViewScrollPositionNone];
        }

        self.navigationItem.rightBarButtonItems = @[_deleteBarButton, _selectAllBarButton];
        [self setIsSelectedAll:TRUE];
    }
}

-(void) onEditBarButtonClicked
{
    if (!self.tableView.editing)
    {
        self.navigationItem.rightBarButtonItems = @[_cancelBarButton, _selectAllBarButton];
        [self.tableView setEditing:TRUE animated:TRUE];
    }
}

-(void) onDeleteBarButtonClicked
{
    if (self.tableView.editing)
    {
        NSArray* selectedRows = [self.tableView indexPathsForSelectedRows];
        for (NSInteger index = selectedRows.count - 1; index >= 0 ; index--)
        {
            NSIndexPath* indexPath = [selectedRows objectAtIndex:index];
            NSUInteger recordIndex = [self recordIndexInModel:indexPath];
            [self.caculatorModel deleteRecord:recordIndex];
        }
        
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView setEditing:FALSE animated:TRUE];
        self.navigationItem.rightBarButtonItems = @[_editBarButton];
        
        [self setIsSelectedAll:FALSE];
    }
}

-(void) onCancelBarButtonClicked
{
    if (self.tableView.editing)
    {
        [self setIsSelectedAll:FALSE];
        [self.tableView setEditing:FALSE animated:TRUE];
        self.navigationItem.rightBarButtonItems = @[_editBarButton];
    }
}

@end
