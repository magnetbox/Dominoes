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

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:gameId forKey:@"gameID"];
    [aCoder encodeObject:gameTitle forKey:@"gameTitle"];
    [aCoder encodeInt:gameEndScore forKey:@"gameEndScore"];
    [aCoder encodeInt:gameSurface forKey:@"gameSurface"];
    [aCoder encodeObject:gamePlayers forKey:@"gamePlayers"];
    [aCoder encodeInt:gamePlayersTurn forKey:@"gamePlayersTurn"];    
    [aCoder encodeObject:gameMoves forKey:@"gameMoves"];
    [aCoder encodeBool:gameActive forKey:@"gameActive"];
} // encodeWithCoder

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [aDecoder decodeIntForKey:@"gameID"];
        [aDecoder decodeObjectForKey:@"gameTitle"];
        [aDecoder decodeIntForKey:@"gameEndScore"];
        [aDecoder decodeIntForKey:@"gameSurface"];
        [aDecoder decodeObjectForKey:@"gamePlayers"];
        [aDecoder decodeIntForKey:@"gamePlayersTurn"];
        [aDecoder decodeObjectForKey:@"gameMoves"];
        [aDecoder decodeBoolForKey:@"gameActive"];
    }
    return (self);
} // initWithCoder

@end
