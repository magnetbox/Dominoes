//
//  DetailViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "DetailViewController.h"
#import "Game.h"
#import <QuartzCore/QuartzCore.h>

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

-(id)setupDotStyle:(UIView*)dot{
    dot.layer.cornerRadius = 4;
    dot.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:92.0f/255.0f blue:105.0f/255.0f alpha:1.0f];
    dot.layer.shadowColor = [UIColor whiteColor].CGColor;
    dot.layer.shadowOpacity = 0.8;
    dot.layer.shadowRadius = 2;
    dot.layer.shadowOffset = CGSizeMake(0,2.0f);
    dot.layer.masksToBounds = NO;
    return dot;
}

-(id)setupButtonStyle:(UIButton*)button{
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [button setTitleColor:[UIColor colorWithRed:82.0f/255.0f green:92.0f/255.0f blue:105.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:1.0f alpha:0.8f] forState:UIControlStateNormal];
    [button.titleLabel setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    button.layer.cornerRadius = 3;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOpacity = 0.7;
    button.layer.shadowRadius = 2;
    button.layer.shadowOffset = CGSizeMake(0,2.0f);
    button.layer.masksToBounds = NO;
    return button;
}

- (void)drawKeypad
{
    UIView *keypad = [[UIView alloc] initWithFrame:CGRectMake(0,self.tableView.frame.size.height-170,self.tableView.frame.size.width,170)];
    keypad.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,10,50,50)];
    pointsLabel.backgroundColor = [UIColor clearColor];
    pointsLabel.text = @"Points to add:";
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont boldSystemFontOfSize:12.0];
    pointsLabel.numberOfLines = 0;
    [keypad addSubview:pointsLabel];

    UILabel *pointsToAdd = [[UILabel alloc] initWithFrame:CGRectMake(75,10,500,50)];
    pointsToAdd.backgroundColor = [UIColor clearColor];
    pointsToAdd.text = @"0";
    pointsToAdd.textColor = [UIColor whiteColor];
    pointsToAdd.font = [UIFont boldSystemFontOfSize:34.0];
    [keypad addSubview:pointsToAdd];

    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    undoButton.frame = CGRectMake(140,15,65,40);
    [undoButton setTitle:@"undo" forState:UIControlStateNormal];
    [self setupButtonStyle:undoButton];
    [keypad addSubview:undoButton];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(215,15,65,40);
    [doneButton setTitle:@"done" forState:UIControlStateNormal];
    [self setupButtonStyle:doneButton];
    [keypad addSubview:doneButton];

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(15,70,40,40);
    [self setupButtonStyle:button1];
    [keypad addSubview:button1];

    UIView *dot1 = [[UIView alloc] initWithFrame:CGRectMake(16,16,8,8)];
    [self setupDotStyle:dot1];
    [button1 addSubview:dot1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(65,70,40,40);
    [self setupButtonStyle:button2];
    [keypad addSubview:button2];

    UIView *dot21 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot21];
    [button2 addSubview:dot21];
    UIView *dot22 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot22];
    [button2 addSubview:dot22];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(115,70,40,40);
    [self setupButtonStyle:button3];
    [keypad addSubview:button3];
    
    UIView *dot31 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot31];
    [button3 addSubview:dot31];
    UIView *dot32 = [[UIView alloc] initWithFrame:CGRectMake(16,16,8,8)];
    [self setupDotStyle:dot32];
    [button3 addSubview:dot32];
    UIView *dot33 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot33];
    [button3 addSubview:dot33];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(165,70,40,40);
    [self setupButtonStyle:button4];
    [keypad addSubview:button4];

    UIView *dot41 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot41];
    [button4 addSubview:dot41];
    UIView *dot42 = [[UIView alloc] initWithFrame:CGRectMake(26,6,8,8)];
    [self setupDotStyle:dot42];
    [button4 addSubview:dot42];
    UIView *dot43 = [[UIView alloc] initWithFrame:CGRectMake(6,26,8,8)];
    [self setupDotStyle:dot43];
    [button4 addSubview:dot43];
    UIView *dot44 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot44];
    [button4 addSubview:dot44];

    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(215,70,40,40);
    [self setupButtonStyle:button5];
    [keypad addSubview:button5];
    
    UIView *dot51 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot51];
    [button5 addSubview:dot51];
    UIView *dot52 = [[UIView alloc] initWithFrame:CGRectMake(26,6,8,8)];
    [self setupDotStyle:dot52];
    [button5 addSubview:dot52];
    UIView *dot53 = [[UIView alloc] initWithFrame:CGRectMake(16,16,8,8)];
    [self setupDotStyle:dot53];
    [button5 addSubview:dot53];
    UIView *dot54 = [[UIView alloc] initWithFrame:CGRectMake(6,26,8,8)];
    [self setupDotStyle:dot54];
    [button5 addSubview:dot54];
    UIView *dot55 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot55];
    [button5 addSubview:dot55];
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(265,70,40,40);
    [self setupButtonStyle:button6];
    [keypad addSubview:button6];
    
    UIView *dot61 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot61];
    [button6 addSubview:dot61];
    UIView *dot62 = [[UIView alloc] initWithFrame:CGRectMake(26,6,8,8)];
    [self setupDotStyle:dot62];
    [button6 addSubview:dot62];
    UIView *dot63 = [[UIView alloc] initWithFrame:CGRectMake(6,16,8,8)];
    [self setupDotStyle:dot63];
    [button6 addSubview:dot63];
    UIView *dot64 = [[UIView alloc] initWithFrame:CGRectMake(6,26,8,8)];
    [self setupDotStyle:dot64];
    [button6 addSubview:dot64];
    UIView *dot65 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot65];
    [button6 addSubview:dot65];
    UIView *dot66 = [[UIView alloc] initWithFrame:CGRectMake(26,16,8,8)];
    [self setupDotStyle:dot66];
    [button6 addSubview:dot66];
    
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
