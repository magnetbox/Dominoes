//
//  AppDelegate.h
//  Dominoes
//
//  Created by Ben Tesch on 11/22/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GamesViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window;
    GamesViewController *gamesViewController;
}

@property (strong, nonatomic) UIWindow *window;

@end
