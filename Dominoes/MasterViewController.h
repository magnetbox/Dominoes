//
//  MasterViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewGameViewController.h"
#import "AppDelegate.h"

@interface MasterViewController : UITableViewController <NewGameViewControllerDelegate>{
    AppDelegate *appDelegate;
}

@end
