//
//  MasterViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "MasterViewController.h"
#import "Game.h"
#import "DetailViewController.h"

@implementation MasterViewController

@synthesize allGames, activeGames, inactiveGames;

#pragma mark - tableview stuff

- (id)initWithCoder:(NSCoder*)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		activeGames = [NSMutableArray arrayWithCapacity:10];
		Game* activeGame = [[Game alloc] init];
		activeGame.gameTitle = @"Active 1";
		[activeGames addObject:activeGame];        

        inactiveGames = [NSMutableArray arrayWithCapacity:10];
		Game* inactiveGame = [[Game alloc] init];
		inactiveGame.gameTitle = @"Inactive 1";
		[inactiveGames addObject:inactiveGame];

        inactiveGame = [[Game alloc] init];
		inactiveGame.gameTitle = @"Inactive 2";
		[inactiveGames addObject:inactiveGame];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:activeGames, inactiveGames, nil];
        [self setAllGames:array];
    }
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self allGames] count];
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

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [[self allGames] objectAtIndex:section];
    NSInteger rows = [sectionContents count];
	
    return rows;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	NSString* CellIdentifier = [NSString stringWithFormat:@"Cell-%i-%i", indexPath.section, indexPath.row];
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSArray *sectionContents = [self.allGames objectAtIndex:indexPath.section];
    Game* game = [sectionContents objectAtIndex:[indexPath row]];

	cell.textLabel.text = game.gameTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    

    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"gameView"];

    // set title of next view controller
    controller.selected = [[[self.allGames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] gameTitle];

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
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    /*
    // handled in storyboard
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                    style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"New"
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(setupNewGame:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    */
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
    [self.activeGames addObject:game];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.activeGames count] - 1 inSection:0];
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
