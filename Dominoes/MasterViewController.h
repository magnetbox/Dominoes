//
//  MasterViewController.h
//  Dominoes
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <StoreKit/StoreKit.h>
#import "NewGameViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, NewGameViewControllerDelegate> {
    AppDelegate *appDelegate;
    UITableView *gameList;
    ADBannerView *bannerView;
    UIAlertView *askToPurchase;
}

@property (nonatomic, retain) UITableView *gameList;
@property (nonatomic, retain) ADBannerView *bannerView;
- (BOOL)connected;

@end
