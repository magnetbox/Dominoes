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

@protocol NewGameViewControllerDelegate <NSObject, UITextFieldDelegate>
- (void)newGameViewControllerDidCancel:(NewGameViewController *)controller;
- (void)newGameViewController:(NewGameViewController *)controller didAddGame:(Game *)game;
@end

@interface NewGameViewController : UITableViewController <NewGameViewControllerDelegate>
{
    NSMutableArray *defaultGame;
    NSMutableArray *defaultGamePlayers;
    NSMutableArray *defaultGameSettings;
    NSNumber *defaultGamePlayersTurn;
    BOOL defaultGameSave;
}
@property (nonatomic, retain) NSMutableArray *defaultGame;
@property (nonatomic, retain) NSMutableArray *defaultGamePlayers;
@property (nonatomic, retain) NSMutableArray *defaultGameSettings;
@property (nonatomic, retain) NSNumber *defaultGamePlayersTurn;
@property (nonatomic) BOOL defaultGameSave;

@property (nonatomic, weak) id <NewGameViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
