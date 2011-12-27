//
//  GamesViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/26/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDataFileName   @"games"
#define kDataKey    @"Data"

@interface GamesViewController : UITableViewController

-(NSString *)dataFilePath;

@end
