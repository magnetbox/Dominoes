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

@synthesize gameList, bannerView;

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
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    /*
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
    
     */
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSData *myDecodedObjectActive = [prefs objectForKey:[NSString stringWithFormat:@"activeGames"]];
    if (myDecodedObjectActive != nil) {
        NSLog(@"ACTIVE OBJECT IS NOT NIL");
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObjectActive];
        if (oldSavedArray != nil) {
            NSLog(@"ACTIVE ARRAY IS NOT NIL");
            appDelegate.activeGames = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        } else {
            NSLog(@"ACTIVE ARRAY IS NIL");
            appDelegate.activeGames = [[NSMutableArray alloc] init];
        }
    } else {
        NSLog(@"ACTIVE OBJECT IS NIL");
        appDelegate.activeGames = [[NSMutableArray alloc] init];
    }
    
    NSData *myDecodedObjectInactive = [prefs objectForKey:[NSString stringWithFormat:@"inactiveGames"]];
    if (myDecodedObjectInactive != nil) {
        NSLog(@"INACTIVE OBJECT IS NOT NIL");
        NSArray *oldSavedArray2 = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObjectInactive];
        if (oldSavedArray2 != nil) {
            NSLog(@"INACTIVE ARRAY IS NOT NIL");
            [appDelegate setInactiveGames:[[NSMutableArray alloc] initWithArray:oldSavedArray2]];
        } else {
            NSLog(@"INACTIVE ARRAY IS NIL");
            [appDelegate setInactiveGames:[[NSMutableArray alloc] init]];
        }
    } else {
        NSLog(@"INACTIVE OBJECT IS NIL");
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:appDelegate.activeGames, appDelegate.inactiveGames, nil];
    //NSLog(@"%@",array);
    [appDelegate setAllGames:array];

    // add table of games
    gameList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    gameList.delegate = self;
    gameList.dataSource = self;
    gameList.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:gameList];
    
    // add banner ad
    [self createBannerView];
    
}

- (void)createBannerView {
    Class cls = NSClassFromString(@"ADBannerView");
    if (cls) {
        ADBannerView *adView = [[cls alloc] initWithFrame:CGRectZero];
        adView.requiredContentSizeIdentifiers = [NSSet setWithObjects:
                                                 ADBannerContentSizeIdentifierPortrait,
                                                 ADBannerContentSizeIdentifierLandscape,
                                                 nil];
        
        // Set the current size based on device orientation
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        adView.delegate = self;
        adView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        
        // Set initial frame to be offscreen
        CGRect bannerFrame = adView.frame;
        bannerFrame.origin.y = self.view.frame.size.height;
        adView.frame = bannerFrame;
        
        self.bannerView = adView;
        [self.view addSubview:adView];
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSLog(@"GOT A BANNER");
    [self showBanner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"BANNER FAIL");
    [self hideBanner];
}

- (void)showBanner {
    CGFloat fullViewHeight = self.view.frame.size.height;
    CGRect tableFrame = self.gameList.frame;
    CGRect bannerFrame = self.bannerView.frame;
    
    // Shrink the tableview to create space for banner
    tableFrame.size.height = fullViewHeight - bannerFrame.size.height;
    
    // Move banner onscreen
    bannerFrame.origin.y = fullViewHeight - bannerFrame.size.height;
    
    NSLog(@"%f %f %f",fullViewHeight,tableFrame.size.height,bannerFrame.size.height);
    
    [UIView beginAnimations:@"showBanner" context:NULL];
    self.gameList.frame = tableFrame;
    self.bannerView.frame = bannerFrame;
    [UIView commitAnimations];
}

- (void)hideBanner {
    
    // Grow the tableview to occupy space left by banner
    CGFloat fullViewHeight = self.view.frame.size.height;
    CGRect tableFrame = self.gameList.frame;
    tableFrame.size.height = fullViewHeight;
    
    // Move the banner view offscreen
    CGRect bannerFrame = self.bannerView.frame;
    bannerFrame.origin.y = fullViewHeight;
    
    self.gameList.frame = tableFrame;
    self.bannerView.frame = bannerFrame;
}

- (void)changeBannerOrientation:(UIInterfaceOrientation)toOrientation {
    NSLog(@"CHANGE ORIENTATION");
    if (UIInterfaceOrientationIsLandscape(toOrientation)) {
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    } else {
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    if (bannerView) {
        [self changeBannerOrientation:toInterfaceOrientation];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (bannerView) {
        [self showBanner];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    if (self.bannerView) {
        bannerView.delegate = nil;
        self.bannerView = nil;
    }
    self.gameList = nil;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [self.gameList indexPathForSelectedRow];
    [self.gameList reloadData];
    if(indexPath) {
        [self.gameList selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    if (bannerView) {
        UIInterfaceOrientation orientation = self.interfaceOrientation;
        [self changeBannerOrientation:orientation];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSIndexPath *indexPath = [self.gameList indexPathForSelectedRow];
    if(indexPath) {
        [self.gameList deselectRowAtIndexPath:indexPath animated:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)setupNewGame:(id)sender
{
    NewGameViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"newGameView"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)newGameViewController:(NewGameViewController *)controller didAddGame:(Game *)game
{
    [appDelegate.activeGames insertObject:game atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:appDelegate.activeGames] forKey:@"activeGames"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.gameList insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.gameList reloadData];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)newGameViewControllerDidCancel:(NewGameViewController *)controller
{
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
    if (section==0) {
        //return 1 extra row for new game button in active games section
        return [sectionContents count]+1;
    } else {
        return [sectionContents count];
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	NSString* CellIdentifier = [NSString stringWithFormat:@"Cell-%i-%i", indexPath.section, indexPath.row];
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSArray *sectionContents = [appDelegate.allGames objectAtIndex:indexPath.section];
    //NSLog(@"ROWS: %d",[sectionContents count]);
    
    if (indexPath.section==0 && indexPath.row==sectionContents.count) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"+ New game";
        return cell;
    }
    
    Game* game = [sectionContents objectAtIndex:[indexPath row]];
	cell.textLabel.text = game.gameTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0 && indexPath.row==[appDelegate.activeGames count]) {
        [self performSegueWithIdentifier:@"setupNewGame" sender:self];
    } else {
        DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"gameView"];
        Game *selectedGame = [[appDelegate.allGames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        controller.game = selectedGame;        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
     if (indexPath.section==0) {
         [appDelegate.activeGames removeObjectAtIndex:indexPath.row];
         [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:appDelegate.activeGames] forKey:@"activeGames"];
     } else {
         [appDelegate.inactiveGames removeObjectAtIndex:indexPath.row];
         [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:appDelegate.activeGames] forKey:@"inactiveGames"];
     }
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

@end
