//
//  DetailViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "KeypadViewController.h"

@interface DetailViewController : UITableViewController {
    KeypadViewController *keypad;
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Game *game;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (retain, nonatomic) NSString *selected;

@property (nonatomic, retain) KeypadViewController *keypad;

@end
