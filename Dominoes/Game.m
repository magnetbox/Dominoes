//
//  Game.m
//  Dominoes
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize gameId=gId;
@synthesize gameTitle=gTitle;
@synthesize gameEndScore=gEndScore;
@synthesize gameSurface=gSurface;
@synthesize gamePlayers=gPlayers;
@synthesize gamePlayersTurn=gPlayersTurn;
@synthesize gameMoves=gMoves;
@synthesize gameActive=gActive;

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:gId forKey:kGameIdKey];
    [aCoder encodeObject:gTitle forKey:kGameTitleKey];
    [aCoder encodeInt:gEndScore forKey:kGameEndScoreKey];
    [aCoder encodeInt:gSurface forKey:kGameSurfaceKey];
    [aCoder encodeObject:gPlayers forKey:kGamePlayersKey];
    [aCoder encodeInt:gPlayersTurn forKey:kGamePlayersTurnKey];    
    [aCoder encodeObject:gMoves forKey:kGameMovesKey];
    [aCoder encodeBool:gActive forKey:kGameActiveKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        gId = [aDecoder decodeIntForKey:kGameIdKey];
        gTitle = [aDecoder decodeObjectForKey:kGameTitleKey];
        gEndScore = [aDecoder decodeIntForKey:kGameEndScoreKey];
        gSurface = [aDecoder decodeIntForKey:kGameSurfaceKey];
        gPlayers = [aDecoder decodeObjectForKey:kGamePlayersKey];
        gPlayersTurn = [aDecoder decodeIntForKey:kGamePlayersTurnKey];
        gMoves = [aDecoder decodeObjectForKey:kGameMovesKey];
        gActive = [aDecoder decodeBoolForKey:kGameActiveKey];
    }
    return self;
}

@end
