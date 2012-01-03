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

@interface NewGameViewController : UITableViewController <NewGameViewControllerDelegate>
{
    NSMutableArray *defaults;
    NSMutableArray *defaultPlayers;
    NSMutableArray *defaultSettings;
    NSMutableArray *defaultSettingsLabels;
}
@property (nonatomic, retain) NSMutableArray *defaults;
@property (nonatomic, retain) NSMutableArray *defaultPlayers;
@property (nonatomic, retain) NSMutableArray *defaultSettings;
@property (nonatomic, retain) NSMutableArray *defaultSettingsLabels;
@property (nonatomic, weak) id <NewGameViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
