//
//  NewGameViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/30/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGameViewController : UITableViewController
{
    NSMutableArray *defaults;
    NSMutableArray *defaultPlayers;
    NSMutableArray *defaultSettings;
}

@property (nonatomic, retain) NSMutableArray *defaults;
@property (nonatomic, retain) NSMutableArray *defaultPlayers;
@property (nonatomic, retain) NSMutableArray *defaultSettings;

@end
