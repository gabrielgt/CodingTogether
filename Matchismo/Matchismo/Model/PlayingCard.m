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

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if (otherCards.count == 1)
    {
        PlayingCard *otherCard = [otherCards lastObject];
        
        if ([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        else if (otherCard.rank == self.rank)
        {
            score = 4;
        }
    }
    else if (otherCards.count == 2)
    {
        PlayingCard *secondCard = [otherCards objectAtIndex:0];
        PlayingCard *thirdCard = [otherCards objectAtIndex:1];
        score += [self match:@[secondCard]];
        score += [self match:@[thirdCard]];
        score += [secondCard match:@[thirdCard]];
    }
    
    return score;
}



@end
