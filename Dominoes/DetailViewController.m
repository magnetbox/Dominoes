//
//  DetailViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "DetailViewController.h"
#import "Game.h"
#import "KeypadView.h"
#import "PlayerCell.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize selected, game, keypad, playerList;

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
    NSLog(@"END TURN");
    
    // update score display
    [self updatePlayerScore:[self.game gamePlayersTurn]];

    // select next player
    [self.game setGamePlayersTurn:[self.game gamePlayersTurn] + 1];
    if ([self.game gamePlayersTurn]>([[self.game gamePlayers] count]-1)) {
        [self.game setGamePlayersTurn:0];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.game gamePlayersTurn] inSection:0];
    [playerList selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    [self clearDisplay];

    // if someone has reached the end score, the game is done so set it to be inactive
    int i;
    for (i=0; i<[self.game.gamePlayersScore count]; i++) {
        int pScore = [[self.game.gamePlayersScore objectAtIndex:i] intValue];
        if (pScore >= [self.game.gameEndScore intValue] && self.game.gameActive==YES) {
            NSLog(@"GAME OVER");
            self.game.gameActive = NO;
            NSLog(@"I1: %@",appDelegate.inactiveGames);
            [appDelegate.inactiveGames addObject:self.game];
            NSLog(@"I2: %@",appDelegate.inactiveGames);
            NSLog(@"A1: %@",appDelegate.activeGames);
            [appDelegate.activeGames removeObject:self.game];
            NSLog(@"A2: %@",appDelegate.activeGames);
        }
    }
    
    // save data
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedActive = [NSKeyedArchiver archivedDataWithRootObject:appDelegate.activeGames];
    [userDefault setObject:myEncodedActive forKey:[NSString stringWithFormat:@"activeGames"]];
    NSData *myEncodedInactive = [NSKeyedArchiver archivedDataWithRootObject:appDelegate.inactiveGames];
    [userDefault setObject:myEncodedInactive forKey:[NSString stringWithFormat:@"inactiveGames"]];
    NSLog(@"SAVED TO USERDEFAULTS");
}

- (void)updatePlayerScore:(int)player
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:player inSection:0];
	PlayerCell* cell = (PlayerCell *)[playerList cellForRowAtIndexPath:indexPath];
    NSInteger newValue = [keypad.display.text intValue]+[cell.scoreLabel.text intValue];
    [cell.scoreLabel setText:[NSString stringWithFormat:@"%d", newValue]];
    [self.game.gamePlayersScore replaceObjectAtIndex:player withObject:[NSNumber numberWithInt:newValue]];
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
    //NSLog(@"ACTIVE: %c",self.game.gameActive);
    
    int keypadHeight = 210;

    playerList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 440) style:UITableViewStylePlain];
    playerList.backgroundColor = [UIColor clearColor];
    playerList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [playerList setContentInset:UIEdgeInsetsMake(0,0,keypadHeight,0)];

    [playerList setAutoresizesSubviews:YES];
    [playerList setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [playerList setDelegate:self];
    [playerList setDataSource:self];
    
    // add keypad to view
    keypad = [[KeypadView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-keypadHeight, self.view.frame.size.width, self.view.frame.size.height)];
    
    // set background image, failing to default image if saved image is gone
    UIImage *bgImage = self.game.gameSurface;
    if (bgImage == nil || ![bgImage isKindOfClass:[UIImage class]]) {
        bgImage = [UIImage imageNamed:@"pattern2.png"];
    }
    
    // vertically center image
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.f);
    CGFloat newHeight = (self.view.frame.size.width * bgImage.size.height)/bgImage.size.width;
    [bgImage drawInRect:CGRectMake(0.f, ((self.view.frame.size.height-44.0f)/2)-(newHeight/2), self.view.frame.size.width, newHeight)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:resultImage];

    [self.view addSubview:playerList];
    [self.view addSubview:keypad];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[self.game gamePlayers] count];
    NSLog(@"PLAYERS: %d",rows);
    return rows;
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
    self.game.gamePlayersTurn = indexPath.row;
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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
