//
//  DetailViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "DetailViewController.h"
#import "Game.h"
#import "KeypadViewController.h"
#import "PlayerCell.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize selected, game, keypad;

#pragma mark - Managing the detail item

/*
- (Game *)loadGame:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:key];
    Game *aGame = (Game *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return aGame;
}

- (void)setGame:(Game *)aGame {
    NSLog(@"SAVE");
    // save the game object
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:aGame];
    [prefs setObject:myEncodedObject forKey:@"myEncodedObjectKey"];
}
*/

- (void)buttonPressed:(id)sender {
    NSLog(@"DIGIT PRESSED: %d", [sender tag]);
    NSInteger total = [keypad.display.text intValue];
    keypad.display.text = [NSString stringWithFormat:@"%d", total+[sender tag]];
}

- (void)clearDisplay {
    NSLog(@"CLEAR");
    keypad.display.text = @"0";
}

- (void)endTurn:(id)sender {
    NSLog(@"DONE");
    [self updatePlayerScore:[self.game gamePlayersTurn]];
    [self.game setGamePlayersTurn:[self.game gamePlayersTurn] + 1];
    if ([self.game gamePlayersTurn]>([[self.game gamePlayers] count]-1)) {
        [self.game setGamePlayersTurn:0];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.game gamePlayersTurn] inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    [self clearDisplay];
}

- (void)updatePlayerScore:(int)player
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:player inSection:0];
	PlayerCell* cell = (PlayerCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSInteger newValue = [self.keypad.display.text intValue]+[cell.scoreLabel.text intValue];
    [cell.scoreLabel setText:[NSString stringWithFormat:@"%d", newValue]];
    cell.progressBar.progress = (float) newValue / [self.game.gameEndScore intValue];
}

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
    NSLog(@"END SCORE: %@",self.game.gameEndScore);
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern4.png"]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    keypad = [[KeypadViewController alloc] init];
    [self.view addSubview:keypad.view];
    
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
    
	PlayerCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[PlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString *playerName = [[self.game gamePlayers] objectAtIndex:indexPath.row];    
    NSNumber* playerScore = [[self.game gamePlayersScore] objectAtIndex:indexPath.row];
    NSNumber* gameEndScore = [self.game gameEndScore];
    NSInteger gamePlayersTurn = [self.game gamePlayersTurn];
    NSString *playerScoreString = [playerScore stringValue];
    
    cell.nameLabel.text = playerName;
    cell.scoreLabel.text = playerScoreString;
    cell.progressBar.progress = (float) [playerScore intValue] / [gameEndScore intValue];
    
    if (indexPath.row == gamePlayersTurn) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
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
    self.keypad = nil;
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
