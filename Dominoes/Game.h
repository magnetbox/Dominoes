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
    UIImage *gameSurface;
    NSArray *gamePlayers;
    NSMutableArray *gamePlayersScore;
    NSInteger gamePlayersTurn;
    NSMutableArray *gameMoves;
    BOOL gameActive;
}

@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, retain) NSString *gameTitle;
@property (nonatomic, retain) NSNumber *gameEndScore;
@property (nonatomic, retain) UIImage *gameSurface;
@property (nonatomic, retain) NSArray *gamePlayers;
@property (nonatomic, retain) NSMutableArray *gamePlayersScore;
@property (nonatomic, assign) NSInteger gamePlayersTurn;
@property (nonatomic, retain) NSMutableArray *gameMoves;
@property (nonatomic) BOOL gameActive;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
