//
//  AppDelegate.h
//  Dominoes
//
//  Created by Ben Tesch on 11/22/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *allGames;
    NSMutableArray *activeGames;
    NSMutableArray *inactiveGames;
}

@property (nonatomic, retain) NSMutableArray *allGames;
@property (nonatomic, retain) NSMutableArray *activeGames;
@property (nonatomic, retain) NSMutableArray *inactiveGames;
@property (strong, nonatomic) UIWindow *window;

- (IBAction)setAllGames:(NSMutableArray *)allGames;

@end
