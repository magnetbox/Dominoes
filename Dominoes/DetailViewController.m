//
//  DetailViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "DetailViewController.h"
#import "Game.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize selected, game;

#pragma mark - Managing the detail item

/*
 - (void)setGame:(Game *)game {
    
}
*/

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    /*
     if (self.detailItem) {
     self.detailDescriptionLabel.text = [self.detailItem description];
     }
     */
    self.title = self.game.gameTitle;
    game = self.game;
    NSLog(@"TITLE: %@",self.title);
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern4.png"]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self drawKeypad];
    
}

- (void)drawKeypad
{
    UIView *keypad = [[UIView alloc] initWithFrame:CGRectMake(0,self.tableView.frame.size.height-200,self.tableView.frame.size.width,200)];
    keypad.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,10,50,50)];
    pointsLabel.backgroundColor = [UIColor clearColor];
    pointsLabel.text = @"Points to add:";
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont boldSystemFontOfSize:12.0];
    pointsLabel.numberOfLines = 0;
    [keypad addSubview:pointsLabel];

    UILabel *pointsToAdd = [[UILabel alloc] initWithFrame:CGRectMake(100,10,50,50)];
    pointsToAdd.backgroundColor = [UIColor clearColor];
    pointsToAdd.text = @"15";
    pointsToAdd.textColor = [UIColor whiteColor];
    pointsToAdd.font = [UIFont boldSystemFontOfSize:34.0];
    [keypad addSubview:pointsToAdd];

    UIButton *undoButton = [[UIButton alloc] initWithFrame:CGRectMake(150,10,70,50)];
    [undoButton setTitle:@"undo" forState:UIControlStateNormal];
    undoButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [keypad addSubview:undoButton];
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(220,10,70,50)];
    [doneButton setTitle:@"done" forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [keypad addSubview:doneButton];

    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10,100,30,30)];
    [button1 setTitle:@"1" forState:UIControlStateNormal];
    [keypad addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50,100,30,30)];
    [button2 setTitle:@"2" forState:UIControlStateNormal];
    [keypad addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(90,100,30,30)];
    [button3 setTitle:@"3" forState:UIControlStateNormal];
    [keypad addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(130,100,30,30)];
    [button4 setTitle:@"4" forState:UIControlStateNormal];
    [keypad addSubview:button4];
    
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(170,100,30,30)];
    [button5 setTitle:@"5" forState:UIControlStateNormal];
    [keypad addSubview:button5];
    
    UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(210,100,30,30)];
    [button6 setTitle:@"6" forState:UIControlStateNormal];
    [keypad addSubview:button6];
    
    [self.view addSubview:keypad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[self.game gamePlayers] count];
    //NSInteger rows = [sectionContents count];
	
    NSLog(@"PLAYERS: %d",rows);
    return rows;

    //NSInteger rows = [self.game.gamePlayers count];
    //return rows;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	NSString* CellIdentifier = [NSString stringWithFormat:@"Cell-%i", indexPath.row];
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    NSString *playerName = [[self.game gamePlayers] objectAtIndex:indexPath.row];
    NSLog(@"PLAYER %d: %@", indexPath.row, playerName);
	
    cell.textLabel.text = playerName;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor whiteColor];

    cell.detailTextLabel.text = [[self.game gamePlayersScore] objectAtIndex:indexPath.row];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:34.0];
    cell.detailTextLabel.textColor = [UIColor whiteColor];

    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
	
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
