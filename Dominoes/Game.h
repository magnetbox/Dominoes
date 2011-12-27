//
//  Game.h
//  Dominoes
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding, NSCopying> {
    NSInteger gameId;
    NSString *gameTitle;
    NSInteger gameEndScore;
    NSInteger gameSurface;
    NSArray *gamePlayers;
    NSInteger gamePlayersTurn;
    NSArray *gameMoves;
    BOOL gameActive;
}

@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, retain) NSString *gameTitle;
@property (nonatomic, assign) NSInteger gameEndScore;
@property (nonatomic, assign) NSInteger gameSurface;
@property (nonatomic, retain) NSArray *gamePlayers;
@property (nonatomic, assign) NSInteger gamePlayersTurn;
@property (nonatomic, retain) NSArray *gameMoves;
@property (nonatomic) BOOL gameActive;

// Returns how many games are in the list.
- (int)gameCount;

// Returns the Gane object at the specified position in the list.
- (Game*)gameAtIndex:(int)index;

// Deletes a Game object from the list.
- (void)removeGameAtIndex:(int)index;

@end
