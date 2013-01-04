//
//  MasterViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Game.h"

@implementation MasterViewController

#pragma mark - tableview stuff

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [appDelegate.allGames count];
    return sections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionHeader = nil;
	
	if(section == 0) {
		sectionHeader = @"In progress";
	}
	if(section == 1) {
		sectionHeader = @"Completed";
	}
	
	return sectionHeader;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [appDelegate.allGames objectAtIndex:section];
    /*
     if ([sectionContents count]==0) {
        return 1;
    }
     */
    return [sectionContents count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	NSString* CellIdentifier = [NSString stringWithFormat:@"Cell-%i-%i", indexPath.section, indexPath.row];
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSArray *sectionContents = [appDelegate.allGames objectAtIndex:indexPath.section];
    //NSLog(@"ROWS: %d",[sectionContents count]);
    
    if ([sectionContents count]==0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"No games";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        return cell;
    }

    Game* game = [sectionContents objectAtIndex:[indexPath row]];
	cell.textLabel.text = game.gameTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    

    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"gameView"];

    // set title of next view controller
    Game *selectedGame = [[appDelegate.allGames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    controller.game = selectedGame;

    [self.navigationController pushViewController:controller animated:YES];

}   

- (void)setupNewGame:(id)sender
{
    NewGameViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"newGameView"];    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    appDelegate.activeGames = [NSMutableArray arrayWithCapacity:10];
    Game* activeGame = [[Game alloc] init];
    activeGame.gameTitle = @"Active 1";
    activeGame.gamePlayers = [[NSMutableArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
    activeGame.gamePlayersScore = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    activeGame.gameEndScore = [NSNumber numberWithInt:500];
    activeGame.gameActive = YES;
    activeGame.gamePlayersTurn = 0;
    [appDelegate.activeGames addObject:activeGame];
    
    appDelegate.inactiveGames = [NSMutableArray arrayWithCapacity:10];
    Game* inactiveGame = [[Game alloc] init];
    inactiveGame.gameTitle = @"First to 500";
    inactiveGame.gamePlayers = [[NSMutableArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
    inactiveGame.gamePlayersScore = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    inactiveGame.gameEndScore = [NSNumber numberWithInt:500];
    inactiveGame.gameActive = NO;
    inactiveGame.gamePlayersTurn = 0;
    [appDelegate.inactiveGames addObject:inactiveGame];
    
    inactiveGame = [[Game alloc] init];
    inactiveGame.gameTitle = @"First to 121";
    inactiveGame.gamePlayers = [[NSMutableArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
    inactiveGame.gamePlayersScore = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    inactiveGame.gameEndScore = [NSNumber numberWithInt:121];
    inactiveGame.gameActive = NO;
    inactiveGame.gamePlayersTurn = 0;
    [appDelegate.inactiveGames addObject:inactiveGame];
    
    inactiveGame = [[Game alloc] init];
    inactiveGame.gameTitle = @"First to 100";
    inactiveGame.gamePlayers = [[NSMutableArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
    inactiveGame.gamePlayersScore = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    inactiveGame.gameEndScore = [NSNumber numberWithInt:100];
    inactiveGame.gameActive = NO;
    inactiveGame.gamePlayersTurn = 0;
    [appDelegate.inactiveGames addObject:inactiveGame];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSLog(@"HERE");
    
    NSData *myDecodedObjectActive = [prefs objectForKey:[NSString stringWithFormat:@"activeGames"]];
    if (myDecodedObjectActive == nil) {
        NSLog(@"OBJECT NOT NIL");
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObjectActive];
        if (oldSavedArray != nil) {
            NSLog(@"ARRAY NOT NIL");
            appDelegate.activeGames = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        } else {
            NSLog(@"ARRAY NIL");
            appDelegate.activeGames = [[NSMutableArray alloc] init];
        }
    }
    
    NSData *myDecodedObjectInactive = [prefs objectForKey:[NSString stringWithFormat:@"inactiveGames"]];
    if (myDecodedObjectInactive == nil) {
        NSLog(@"OBJECT NOT NIL");
        NSArray *oldSavedArray2 = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObjectInactive];
        if (oldSavedArray2 != nil) {
            NSLog(@"ARRAY NOT NIL");
            [appDelegate setInactiveGames:[[NSMutableArray alloc] initWithArray:oldSavedArray2]];
        } else {
            NSLog(@"ARRAY NIL");
            [appDelegate setInactiveGames:[[NSMutableArray alloc] init]];
        }
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:appDelegate.activeGames, appDelegate.inactiveGames, nil];
    NSLog(@"%@",array);
    [appDelegate setAllGames:array];
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
    [self.tableView reloadData];
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)newGameViewControllerDidCancel:(NewGameViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)newGameViewController:(NewGameViewController *)controller didAddGame:(Game *)game
{
    
    [appDelegate.activeGames addObject:game];
    NSLog(@"%@",appDelegate.activeGames);
    NSInteger insertAtRow = [appDelegate.activeGames count] - 1;
    if (insertAtRow<0) {
        insertAtRow = 0;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:insertAtRow inSection:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:appDelegate.activeGames] forKey:@"activeGames"];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"setupNewGame"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		NewGameViewController *newGameViewController = [[navigationController viewControllers] objectAtIndex:0];
		newGameViewController.delegate = self;
	}
}

@end
