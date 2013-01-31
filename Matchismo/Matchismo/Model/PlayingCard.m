//
//  PlayingCard.m
//  Matchismo
//
//  Created by gabriel on 30/01/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit=_suit;

+ (NSArray *)validSuits
{
    return @[@"♠", @"♣", @"♥", @"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
             @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return PlayingCard.rankStrings.count-1;
}

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%@%@", self.rankString, self.suit];
}

- (NSString *)rankString
{
    return [PlayingCard rankStrings][self.rank];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    if (_suit) return _suit;
    return @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank<=[PlayingCard maxRank])
        _rank = rank;
}

@end
