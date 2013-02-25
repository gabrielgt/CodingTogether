//
//  PlayingCardMatchingGame.m
//  Matchismo
//
//  Created by gabriel on 25/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "PlayingCardMatchingGame.h"

#define MATCH_BONUS 10
#define MISMATCH_PENALTY 3
#define FLIP_COST 2
#define MODE_PENALTY 2

@implementation PlayingCardMatchingGame

- (NSInteger) matchBonus
{
    return MATCH_BONUS;
}

- (NSInteger) mismatchPenalty
{
    return MISMATCH_PENALTY;
}

- (NSInteger) flipCost
{
    return FLIP_COST;
}

- (NSInteger) modePenalty
{
    return MODE_PENALTY;
}

@end
