//
//  Game.h
//  Dominoes
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding> {
    NSInteger gameId;
    NSString *gameTitle;
    NSNumber *gameEndScore;
    NSString *gameSurface;
    NSArray *gamePlayers;
    NSArray *gamePlayersScore;
    NSNumber *gamePlayersTurn;
    NSArray *gameMoves;
    BOOL gameActive;
}

@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, retain) NSString *gameTitle;
@property (nonatomic, retain) NSNumber *gameEndScore;
@property (nonatomic, retain) NSString *gameSurface;
@property (nonatomic, retain) NSArray *gamePlayers;
@property (nonatomic, retain) NSArray *gamePlayersScore;
@property (nonatomic, retain) NSNumber *gamePlayersTurn;
@property (nonatomic, retain) NSArray *gameMoves;
@property (nonatomic) BOOL gameActive;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
