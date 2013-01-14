//
//  MasterViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "NewGameViewController.h"
#import "AppDelegate.h"

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate, NewGameViewControllerDelegate> {
    AppDelegate *appDelegate;
    UITableView *gameList;
    ADBannerView *bannerView;
}

@property (nonatomic, retain) UITableView *gameList;
@property (nonatomic, retain) ADBannerView *bannerView;

@end
