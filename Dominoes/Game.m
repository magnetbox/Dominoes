//
//  Game.m
//  Dominoes
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize gameId;
@synthesize gameTitle;
@synthesize gameEndScore;
@synthesize gameSurface;
@synthesize gamePlayers;
@synthesize gamePlayersScore;
@synthesize gamePlayersTurn;
@synthesize gameMoves;
@synthesize gameActive;

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:(int)self.gameId forKey:@"GameId"];
    [aCoder encodeObject:self.gameTitle forKey:@"GameTitle"];
    [aCoder encodeObject:self.gameEndScore forKey:@"GameEndScore"];
    [aCoder encodeObject:self.gameSurface forKey:@"GameSurface"];
    [aCoder encodeObject:self.gamePlayers forKey:@"GamePlayers"];
    [aCoder encodeObject:self.gamePlayersScore forKey:@"GamePlayersScore"];
    [aCoder encodeInt:(int)self.gamePlayersTurn forKey:@"GamePlayersTurn"];
    [aCoder encodeObject:self.gameMoves forKey:@"GameMoves"];
    [aCoder encodeBool:self.gameActive forKey:@"GameActive"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.gameId             = [aDecoder decodeIntForKey:@"GameId"];
        self.gameTitle          = [aDecoder decodeObjectForKey:@"GameTitle"];
        self.gameEndScore       = [aDecoder decodeObjectForKey:@"GameEndScore"];
        self.gameSurface        = [aDecoder decodeObjectForKey:@"GameSurface"];
        self.gamePlayers        = [aDecoder decodeObjectForKey:@"GamePlayers"];
        self.gamePlayersScore   = [aDecoder decodeObjectForKey:@"GamePlayersScore"];
        self.gamePlayersTurn    = [aDecoder decodeIntForKey:@"GamePlayersTurn"];
        self.gameMoves          = [aDecoder decodeObjectForKey:@"GameMoves"];
        self.gameActive         = [aDecoder decodeBoolForKey:@"GameActive"];
    }
    return self;
}

/*
- (id)copyWithZone:(NSZone *)zone {
    Game *copy = [[[self class] allocWithZone:zone] init];
    copy.gameId = self.gameId;
    copy.gameTitle = [self.gameTitle copyWithZone:zone];
    copy.gameEndScore = self.gameEndScore;
    copy.gameSurface = self.gameSurface;
    copy.gamePlayers = [self.gamePlayers copyWithZone:zone];
    copy.gamePlayersTurn = self.gamePlayersTurn;
    copy.gameMoves = [self.gameMoves copyWithZone:zone];
    copy.gameActive = self.gameActive;
    return copy;
}
*/

@end
