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
@synthesize defaultGame, defaultGamePlayers, defaultGameSettings, defaultGameSave, defaultGamePlayersTurn, imgPicker;

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
            defaultGamePlayers = [[NSMutableArray alloc] initWithArray:[defaultGame objectAtIndex:0]];
            defaultGameSettings = [[NSMutableArray alloc] initWithArray:[defaultGame objectAtIndex:1]];
            defaultGameSave = NO;
            defaultGamePlayersTurn = 0;
        } else {
            NSLog(@"NO ARCHIVED DATA");
            defaultGame = [[NSMutableArray alloc] init];
        }
    } else {
        NSLog(@"NO DEFAULT GAME DATA, SET IT AND SAVE IT");
        defaultGamePlayers = [[NSMutableArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
        defaultGameSettings = [[NSMutableArray alloc] initWithObjects:@"Default", [NSNumber numberWithInt:500], @"First to 500", [UIImage imageNamed:@"pattern2.png"], nil];
        defaultGame = [[NSMutableArray alloc] initWithObjects:defaultGamePlayers, defaultGameSettings, nil];
        defaultGameSave = NO;
        defaultGamePlayersTurn = 0;
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
    if (section==0) {
        //return 1 extra row for add player button
        return [defaultGamePlayers count]+1;
    } else {
        return [sectionContents count];
    }
}

 - (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{    
    if(indexPath.section==0){
        
        NSString *cellIdentifier = @"PlayerCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(120,12,178,30)];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            inputField.textColor = [UIColor colorWithRed:51.0f/255.0f green:82.0f/255.0f blue:115.0f/255.0f alpha:1];
            inputField.adjustsFontSizeToFitWidth = YES;
            inputField.keyboardType = UIKeyboardTypeDefault;
            inputField.returnKeyType = UIReturnKeyDone;
            inputField.tag = indexPath.row;
            //NSLog(@"inputField TAG: %i",inputField.tag);
            
            [cell addSubview:inputField];
        }

        if (indexPath.section==0 && indexPath.row==defaultGamePlayers.count) {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.textLabel.text = @"+ Add player";
            return cell;
        }

        cell.textLabel.text = @"Name";
        inputField.text = [defaultGamePlayers objectAtIndex:indexPath.row];
        inputField.delegate = self;
        return cell;
        
    } else {
        
        if (indexPath.row == 2 ) {
            
            NSString *cellIdentifier = @"SettingCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
            cell.textLabel.text = @"Background";
            cell.detailTextLabel.text = [defaultGameSettings objectAtIndex:0];
            return cell;
            
        } else if (indexPath.row == 0) {
            
            NSString *cellIdentifier = @"ScoreCell";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            UITextField *scoreInputField = [[UITextField alloc] initWithFrame:CGRectMake(120,12,178,30)];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                scoreInputField.textColor = [UIColor colorWithRed:51.0f/255.0f green:82.0f/255.0f blue:115.0f/255.0f alpha:1];
                scoreInputField.adjustsFontSizeToFitWidth = YES;
                scoreInputField.keyboardType = UIKeyboardTypeNumberPad;
                scoreInputField.returnKeyType = UIReturnKeyDone;
                scoreInputField.textAlignment = UITextAlignmentRight;
                scoreInputField.tag = 201;
                [cell addSubview:scoreInputField];
            }
            
            cell.textLabel.text = @"Play to score";
            scoreInputField.text = [NSString stringWithFormat:@"%i", [[defaultGameSettings objectAtIndex:1] integerValue]];
            scoreInputField.delegate = self;
            return cell;
            
        } else if (indexPath.row == 1) {
            
            NSString *cellIdentifier = @"TitleCell";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(120,12,178,30)];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                inputField.textColor = [UIColor colorWithRed:51.0f/255.0f green:82.0f/255.0f blue:115.0f/255.0f alpha:1];
                inputField.adjustsFontSizeToFitWidth = YES;
                inputField.keyboardType = UIKeyboardTypeDefault;
                inputField.returnKeyType = UIReturnKeyDone;
                inputField.textAlignment = UITextAlignmentRight;
                inputField.tag = 202;                
                [cell addSubview:inputField];
            }
            
            cell.textLabel.text = @"Title";
            inputField.text = [defaultGameSettings objectAtIndex:2];
            inputField.delegate = self;
            NSLog(@"TITLE CELL: %@",inputField.text);
            return cell;
            
        } else {

            NSString *cellIdentifier = @"SettingSaveCell";            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return cell;
            
        }
        
    }    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag==201) {
        NSNumber *gameES = [NSNumber numberWithInt:[textField.text intValue]];
        [defaultGameSettings replaceObjectAtIndex:1 withObject:gameES];
        NSLog(@"MODIFIED END SCORE: %@",gameES);
        if ([[defaultGameSettings objectAtIndex:2] hasPrefix:@"First to"]) {
            NSLog(@"TITLE HASN'T BEEN MODIFIED, SO UPDATE IT WITH NEW SCORE");
            NSString *newTitle = [NSString stringWithFormat:@"First to %@",textField.text];
            [defaultGameSettings replaceObjectAtIndex:2 withObject:newTitle];
            UITextField *titleField = (UITextField *)[self.view viewWithTag:202];
            titleField.text = newTitle;
        }
    } else if (textField.tag==202) {
        [defaultGameSettings replaceObjectAtIndex:2 withObject:textField.text];
        NSLog(@"MODIFIED TITLE: %@",[defaultGameSettings objectAtIndex:2]);
    } else {
        [defaultGamePlayers replaceObjectAtIndex:textField.tag withObject:textField.text];
        NSLog(@"MODIFIED TAG: %d",textField.tag);
        NSLog(@"MODIFIED PLAYER %d: %@",textField.tag,[defaultGamePlayers objectAtIndex:textField.tag]);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [defaultGameSettings replaceObjectAtIndex:3 withObject:pickedImage];
    [defaultGameSettings replaceObjectAtIndex:0 withObject:@"Custom"];
    [picker dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.view endEditing:YES];
        [defaultGamePlayers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[self.tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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
    if (indexPath.section==0 && indexPath.row==[defaultGamePlayers count]) {
        [defaultGamePlayers addObject:[NSString stringWithFormat:@"Player %d",indexPath.row+1]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[defaultGamePlayers count]-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
    if (indexPath.section==1 && indexPath.row==2) {
        NSLog(@"SELECTED SURFACE PICKER");
        
        imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing = NO;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:imgPicker animated:YES];
        
    }
    if (indexPath.section==1 && indexPath.row==3) {
        NSLog(@"SELECTED SAVE AS NEW DEFAULTS");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Do you want to save these players and settings as your new game defaults?"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"No"
                              otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        defaultGameSave = YES;
    } else {
        defaultGameSave = NO;
    }
}

#pragma mark - NewGameViewControllerDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancel:(id)sender
{
    NSLog(@"CANCEL!");
    [self.delegate newGameViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    NSLog(@"DONE!");
    
    // get the field values    
    Game *game = [[Game alloc] init];
    game.gamePlayers = defaultGamePlayers;
    game.gameSurface = [defaultGameSettings objectAtIndex:3];
    game.gameEndScore = [defaultGameSettings objectAtIndex:1];
    game.gameTitle = [defaultGameSettings objectAtIndex:2];
    game.gamePlayersTurn = defaultGamePlayersTurn;

    game.gamePlayersScore = [[NSMutableArray alloc] init];
    int i;
    for (i=0; i<[game.gamePlayers count]; i++) {
        [game.gamePlayersScore addObject:[NSNumber numberWithInt:0]];
    }
    
    game.gameActive = YES;
    
    // save the values as the defaults
    if(defaultGameSave){
        NSLog(@"SAVE THE DEFAULTS");
        NSMutableArray *newDefaultGame = [[NSMutableArray alloc] initWithObjects:defaultGamePlayers, defaultGameSettings, nil];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:newDefaultGame] forKey:@"defaultGame"];
    } else {
        NSLog(@"DON'T SAVE THE DEFAULTS");
    }
    
    // go back to the master view
    [self.delegate newGameViewController:self didAddGame:game];

}

- (void)backgroundTap 
{
    NSLog(@"TAP!");
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
