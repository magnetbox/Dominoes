//
//  NewGameViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/30/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@class NewGameViewController;

@protocol NewGameViewControllerDelegate <NSObject>
- (void)newGameViewControllerDidCancel:(NewGameViewController *)controller;
- (void)newGameViewController:(NewGameViewController *)controller didAddGame:(Game *)game;
@end

@protocol SettingsSectionController
@required
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
@end

@interface NewGameViewController : UITableViewController <NewGameViewControllerDelegate>
{
    NSMutableArray *defaults;
    NSMutableArray *defaultPlayers;
    NSMutableArray *defaultSettings;
    NSMutableArray *defaultSettingsLabels;
    NSArray *sectionControllers;
}
@property (nonatomic, retain) NSMutableArray *defaults;
@property (nonatomic, retain) NSMutableArray *defaultPlayers;
@property (nonatomic, retain) NSMutableArray *defaultSettings;
@property (nonatomic, retain) NSMutableArray *defaultSettingsLabels;
@property (nonatomic, weak) id <NewGameViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *surfaceDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *saveDetailLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
