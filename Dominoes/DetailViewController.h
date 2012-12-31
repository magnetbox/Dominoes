//
//  DetailViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "KeypadView.h"

@protocol KeypadViewControllerDelegate <UITableViewDelegate>
- (void)buttonPressed:(id)sender;
- (void)clearDisplay;
- (void)endTurn:(id)sender;
@end

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    KeypadView *keypad;
    UITableView *playerList;
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Game *game;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (retain, nonatomic) NSString *selected;

@property (nonatomic, retain) UIView *keypad;
@property (nonatomic, retain) UITableView *playerList;

- (void)updatePlayerScore:(int)player;

@end
