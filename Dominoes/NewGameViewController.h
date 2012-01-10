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
    NSArray *defaults;
    NSArray *defaultPlayers;
    NSArray *defaultSettings;
}
@property (nonatomic, retain) NSArray *defaults;
@property (nonatomic, retain) NSArray *defaultPlayers;
@property (nonatomic, retain) NSArray *defaultSettings;
@property (nonatomic, weak) id <NewGameViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
