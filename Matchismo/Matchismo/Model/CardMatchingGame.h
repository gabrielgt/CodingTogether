//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by gabriel on 03/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) int score;

@property (nonatomic,readonly) enum ActionType lastAction;

@property (nonatomic, readonly) NSMutableArray *lastCardsPlayed;

@property (nonatomic, readonly) int lastPartialScore;

enum ActionType
{
    FlippedUp,
    FlippedDown,
    Matched,
    Missmatched,
    None
};

@end
