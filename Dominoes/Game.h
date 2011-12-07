//
//  Game.h
//  Dominoes
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding, NSCopying> {
    NSInteger *gId;
    NSString *gTitle;
    NSInteger *gEndScore;
    NSInteger *gSurface;
    NSArray *gPlayers;
    NSInteger *gPlayersTurn;
    NSArray *gMoves;
    BOOL *gActive;
}

@property (nonatomic, assign) NSInteger *gameId;
@property (nonatomic, retain) NSString *gameTitle;
@property (nonatomic, assign) NSInteger *gameEndScore;
@property (nonatomic, assign) NSInteger *gameSurface;
@property (nonatomic, retain) NSArray *gamePlayers;
@property (nonatomic, assign) NSInteger *gamePlayersTurn;
@property (nonatomic, retain) NSArray *gameMoves;
@property (nonatomic) BOOL *gameActive;

#pragma mark NSCoding

#define kGameIdKey          @"ID"
#define kGameTitleKey       @"Title"
#define kGameEndScoreKey    @"EndScore"
#define kGameSurfaceKey     @"Surface"
#define kGamePlayersKey     @"Players"
#define kGamePlayersTurnKey @"PlayersTurn"
#define kGameMovesKey       @"Moves"
#define kGameActiveKey      @"Active"

- (void) encodeWithCoder:(NSCoder *)aCoder;
- (id) initWithCoder:(NSCoder *)aDecoder;

@end
