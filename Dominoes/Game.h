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
    NSInteger gameEndScore;
    NSString *gameSurface;
    NSArray *gamePlayers;
    NSInteger gamePlayersTurn;
    NSArray *gameMoves;
    BOOL gameActive;
}

@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, retain) NSString *gameTitle;
@property (nonatomic, assign) NSInteger gameEndScore;
@property (nonatomic, retain) NSString *gameSurface;
@property (nonatomic, retain) NSArray *gamePlayers;
@property (nonatomic, assign) NSInteger gamePlayersTurn;
@property (nonatomic, retain) NSArray *gameMoves;
@property (nonatomic) BOOL gameActive;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
