//
//  NewGameViewController.m
//  Dominoes
//
//  Created by Ben Tesch on 12/30/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "NewGameViewController.h"
#import "Game.h"
#import "PlayersSectionController.h"
#import "SettingsSectionController.h"

@implementation NewGameViewController

@synthesize delegate;
@synthesize defaultGame, defaultGamePlayers, defaultGameSettings, defaultGameSave;

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

    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *defaultGameArraySavedArray = [currentDefaults objectForKey:@"defaultGame"];
    if (defaultGameArraySavedArray != nil)
    {
        NSLog(@"HAS DEFAULT GAME DATA, LOAD IT");
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:defaultGameArraySavedArray];
        if (oldSavedArray != nil) {
            NSLog(@"FOUND ARCHIVED DATA");
            defaultGame = [[NSMutableArray alloc] initWithArray:oldSavedArray];
            defaultGamePlayers = [defaultGame objectAtIndex:0];
            defaultGameSettings = [defaultGame objectAtIndex:1];
            defaultGameSave = NO;
        } else {
            NSLog(@"NO ARCHIVED DATA");
            defaultGame = [[NSMutableArray alloc] init];
        }
    } else {
        NSLog(@"NO DEFAULT GAME DATA, SET IT AND SAVE IT");
        defaultGamePlayers = [[NSArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
        defaultGameSettings = [[NSArray alloc] initWithObjects:@"Park bench", @"500", @"First to 500", @"Yes", nil];
        defaultGame = [[NSMutableArray alloc] initWithObjects:defaultGamePlayers, defaultGameSettings, nil];
        defaultGameSave = YES;
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:defaultGame] forKey:@"defaultGame"];
    }

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
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
    return [defaultGame count];
}

/*
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	id<SectionController> sectionController = [sectionControllers objectAtIndex:section];
	return [sectionController tableView:table numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	id<SectionController> sectionController = [sectionControllers objectAtIndex:indexPath.section];
	return [sectionController tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	id<SectionController> sectionController = [sectionControllers objectAtIndex:section];
	if ([sectionController respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
		return [sectionController tableView:tableView titleForHeaderInSection:section];
	}
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	id<SectionController> sectionController = [sectionControllers objectAtIndex:section];
	if ([sectionController respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
		return [sectionController tableView:tableView titleForFooterInSection:section];
	}
	return nil;
}
*/

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
    NSArray *sectionContents = [[self defaultGame] objectAtIndex:section];
    NSInteger rows = [sectionContents count];
	
    return rows;
}

 - (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{    
    if(indexPath.section==0){
        
        NSString *cellIdentifier = @"PlayerCell";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        UITextField *inputField;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            inputField = [[UITextField alloc] initWithFrame:CGRectMake(120,12,185,30)];
            inputField.textColor = [UIColor colorWithRed:51.0f/255.0f green:82.0f/255.0f blue:115.0f/255.0f alpha:1];
            inputField.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:inputField];
        }
        inputField.keyboardType = UIKeyboardTypeDefault;
        inputField.returnKeyType = UIReturnKeyDone;
        
        NSString* rowLabel = [NSString stringWithFormat:@"Player %i", indexPath.row+1];
        cell.textLabel.text = rowLabel;
        inputField.placeholder = rowLabel;
        inputField.delegate = self;
        
        return cell;
        
    } else {
        
        if (indexPath.row < 3) {
            
            NSString *cellIdentifier = @"SettingCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Surface";
                cell.detailTextLabel.text = [defaultGameSettings objectAtIndex:0];
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"Play to score";
                cell.detailTextLabel.text = [defaultGameSettings objectAtIndex:1];
            } else if (indexPath.row == 2) {
                cell.textLabel.text = @"Title";
                cell.detailTextLabel.text = [defaultGameSettings objectAtIndex:2];
            }
            return cell;
            
        } else {

            NSString *cellIdentifier = @"SettingSaveCell";            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            UISwitch *saveSwitch = (UISwitch *)[cell viewWithTag:1];
            if(defaultGameSave){
                [saveSwitch setOn:YES animated:NO];
            } else {
                [saveSwitch setOn:NO animated:NO];
            }
            [saveSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            
            return cell;
            
        }
        
    }    
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    if(switchControl.on){
        defaultGameSave = YES;
    } else {
        defaultGameSave = NO;
    }
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
}

/*
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

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
		[self.nameTextField becomeFirstResponder];
}
*/

#pragma mark - NewGameViewControllerDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancel:(id)sender
{
    NSLog(@"Cancel!");
    [self.delegate newGameViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    NSLog(@"Done!");
    
    Game *game = [[Game alloc] init];
    game.gameTitle = [defaultGameSettings objectAtIndex:2];
    
    if(defaultGameSave){
        NSLog(@"SAVE THE DEFAULTS");
        NSArray *newDefaultGamePlayers = [[NSArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
        NSArray *newDefaultGameSettings = [[NSArray alloc] initWithObjects:@"Park bench 2", @"500", @"First to 500", @"No", nil];
        NSMutableArray *newDefaultGame = [[NSMutableArray alloc] initWithObjects:newDefaultGamePlayers, newDefaultGameSettings, nil];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:newDefaultGame] forKey:@"defaultGame"];
    } else {
        NSLog(@"DON'T SAVE THE DEFAULTS");
    }
    
    [self.delegate newGameViewController:self didAddGame:game];

}

- (void)backgroundTap 
{
    NSLog(@"Tap!");
    NSArray *subviews = [self.view subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        } else {
            [self.view endEditing:YES];
        }
    }
}

@end
