//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by gabriel on 03/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "CardMatchingGame.h"

#define MATCH_BONUS 10
#define MISMATCH_PENALTY 3
#define FLIP_COST 2
#define MODE_PENALTY 2

@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,readwrite) enum ActionType lastAction;
@property (nonatomic, readwrite) NSMutableArray *lastCardsPlayed;
@property (nonatomic, readwrite) NSInteger lastPartialScore;
@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self && deck.count >= cardCount)
    {
        for (int i=0; i<cardCount; i++)
        {
            self.cards[i] = [deck drawRandomCard];
        }
        
        self.lastPartialScore = 0;
        self.lastAction = None;
        self.gameMode = 2;
    }
    else
    {
        self = nil;
    }
    
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<self.cards.count) ? self.cards[index]:nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.lastPartialScore = 0;
    self.lastAction = None;
    
    if (!card.isUnplayable)
    {
        [self.lastCardsPlayed removeAllObjects];
        [self.lastCardsPlayed addObject:card];
        self.lastAction = FlippedDown;
        
        if (!card.isFaceUp)
        {
            self.lastAction = FlippedUp;
            NSMutableArray *otherCardsFlippedUp = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [otherCardsFlippedUp addObject:otherCard];
                }
            }
        
            if (otherCardsFlippedUp.count == self.gameMode - 1)
            {
                int matchScore = [card match:otherCardsFlippedUp];
                if (matchScore>0)
                {
                    card.unplayable = YES;
                    self.lastPartialScore +=
                        (matchScore * self.matchBonus) -
                        (self.gameMode * self.modePenalty);
                    self.lastAction = Matched;
                    for (Card *otherCard in otherCardsFlippedUp)
                    {
                        otherCard.unplayable = YES;
                        [self.lastCardsPlayed addObject:otherCard];
                    }
                }
                else
                {
                    for (Card *otherCard in otherCardsFlippedUp)
                    {
                        otherCard.faceUp = NO;
                        [self.lastCardsPlayed addObject:otherCard];
                    }
                    
                    self.lastPartialScore -= self.mismatchPenalty +
                        (self.gameMode * self.modePenalty);
                    self.lastAction = Missmatched;
                }
            }
        
            self.lastPartialScore -= self.flipCost;
        }
        self.score += self.lastPartialScore;
        card.faceUp = !card.isFaceUp;
    }
}

- (NSMutableArray *)lastCardsPlayed
{
    if (!_lastCardsPlayed)
    {
        _lastCardsPlayed = [[NSMutableArray alloc] init];
    }
    return _lastCardsPlayed;
}

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
