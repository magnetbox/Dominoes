//
//  MasterViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController
{
    NSMutableArray *allGames;
    NSMutableArray *activeGames;
    NSMutableArray *inactiveGames;
}

@property (nonatomic, retain) NSMutableArray *allGames;
@property (nonatomic, retain) NSMutableArray *activeGames;
@property (nonatomic, retain) NSMutableArray *inactiveGames;

@end
