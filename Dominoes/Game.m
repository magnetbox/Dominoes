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
@synthesize gamePlayersTurn;
@synthesize gameMoves;
@synthesize gameActive;

- (NSString*)description
{
	return [NSString stringWithFormat:@"%@ %@", [super description], self.gameTitle];
}

#pragma mark NSCoding

#define kGameId             @"GameId"
#define kGameTitle          @"GameTitle"
#define kGameEndScore       @"GameEndScore"
#define kGameSurface        @"GameSurface"
#define kGamePlayers        @"GamePlayers"
#define kGamePlayersTurn    @"GamePlayersTurn"
#define kGameMoves          @"GameMoves"
#define kGameActive         @"GameActive"

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:gameId forKey:kGameId];
    [aCoder encodeObject:gameTitle forKey:kGameTitle];
    [aCoder encodeInt:gameEndScore forKey:kGameEndScore];
    [aCoder encodeInt:gameSurface forKey:kGameSurface];
    [aCoder encodeObject:gamePlayers forKey:kGamePlayers];
    [aCoder encodeInt:gamePlayersTurn forKey:kGamePlayersTurn];    
    [aCoder encodeObject:gameMoves forKey:kGameMoves];
    [aCoder encodeBool:gameActive forKey:kGameActive];
} // encodeWithCoder

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [aDecoder decodeIntForKey:kGameId];
        [aDecoder decodeObjectForKey:kGameTitle];
        [aDecoder decodeIntForKey:kGameEndScore];
        [aDecoder decodeIntForKey:kGameSurface];
        [aDecoder decodeObjectForKey:kGamePlayers];
        [aDecoder decodeIntForKey:kGamePlayersTurn];
        [aDecoder decodeObjectForKey:kGameMoves];
        [aDecoder decodeBoolForKey:kGameActive];
    }
    return self;
} // initWithCoder

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

@end
