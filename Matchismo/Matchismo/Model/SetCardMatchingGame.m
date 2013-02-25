//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by gabriel on 25/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "SetCardMatchingGame.h"

@implementation SetCardMatchingGame

#define MATCH_BONUS 20
#define MISMATCH_PENALTY 2
#define FLIP_COST 2
#define MODE_PENALTY 1

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
