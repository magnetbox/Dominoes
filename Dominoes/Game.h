//
//  Game.h
//  Dominoes
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding> {
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

#define kGameIdKey      @"ID"
#define kGameTitleKey   @"Title"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:kTitleKey];
    [encoder encodeFloat:_rating forKey:kRatingKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    float rating = [decoder decodeFloatForKey:kRatingKey];
    return [self initWithTitle:title rating:rating];
}

@end
