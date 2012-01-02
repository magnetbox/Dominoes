//
//  NewGameViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/30/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "NewGameViewController.h"
#import "Game.h"

@implementation NewGameViewController

@synthesize delegate;
@synthesize defaults, defaultPlayers, defaultSettings, defaultSettingsLabels;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    defaultPlayers = [[NSMutableArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
    defaultSettings = [[NSMutableArray alloc] initWithObjects:@"Park bench", @"500", @"First to 500",@"Yes", nil];    
    defaultSettingsLabels = [[NSMutableArray alloc] initWithObjects:@"Surface", @"End score", @"Game title",@"Defaults", nil];    
    defaults = [[NSMutableArray alloc] initWithObjects:defaultPlayers, defaultSettings, nil];
    
    /*
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Start"
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(startNewGame:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    */
    
    //self.tableView.editing = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self defaults] count];
    return sections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionHeader = nil;
	
	if(section == 0) {
		sectionHeader = @"Players";
	}
	if(section == 1) {
		sectionHeader = @"Settings";
	}
	
	return sectionHeader;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [[self defaults] objectAtIndex:section];
    NSInteger rows = [sectionContents count];
	
    return rows;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{    
    if(indexPath.section==0){
        NSString* PlayerCellIdentifier = @"SettingCell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:PlayerCellIdentifier];

        NSArray *sectionContents = [self.defaults objectAtIndex:indexPath.section];
        NSString* cellText = [sectionContents objectAtIndex:[indexPath row]];    
        
        cell.textLabel.text = @"Player";
        cell.detailTextLabel.text = cellText;
        
        return cell;
        
    } else {
        NSString* SettingCellIdentifier = @"SettingCell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier];

        NSString* cellLabel = [self.defaultSettingsLabels objectAtIndex:[indexPath row]];   
        
        NSArray *sectionContents = [self.defaults objectAtIndex:indexPath.section];
        NSString* cellText = [sectionContents objectAtIndex:[indexPath row]];    

        cell.textLabel.text = cellLabel;
        cell.detailTextLabel.text = cellText;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section==0) {
        return YES;
    } else {
        return NO;
    }
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - NewGameViewControllerDelegate

- (IBAction)cancel:(id)sender
{
    NSLog(@"Cancel!");
    [self.delegate newGameViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    NSLog(@"Done!");
    
    Game *game = [[Game alloc] init];
    game.gameTitle = @"Game title";
    [self.delegate newGameViewController:self didAddGame:game];
}

@end
