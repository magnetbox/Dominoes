//
//  NewGameViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/30/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Game.h"

@class NewGameViewController;

@protocol NewGameViewControllerDelegate <NSObject, UITextFieldDelegate>
- (void)newGameViewControllerDidCancel:(NewGameViewController *)controller;
- (void)newGameViewController:(NewGameViewController *)controller didAddGame:(Game *)game;
@end

@interface NewGameViewController : UIViewController <ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NewGameViewControllerDelegate>
{
    NSMutableArray *defaultGame;
    NSMutableArray *defaultGamePlayers;
    NSMutableArray *defaultGameSettings;
    NSInteger defaultGamePlayersTurn;
    BOOL defaultGameSave;
    UITableView *settingsList;
    ADBannerView *bannerView;
}
@property (nonatomic, retain) NSMutableArray *defaultGame;
@property (nonatomic, retain) NSMutableArray *defaultGamePlayers;
@property (nonatomic, retain) NSMutableArray *defaultGameSettings;
@property (nonatomic, assign) NSInteger defaultGamePlayersTurn;
@property (nonatomic) BOOL defaultGameSave;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, retain) UITableView *settingsList;
@property (nonatomic, retain) ADBannerView *bannerView;

@property (nonatomic, weak) id <NewGameViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
