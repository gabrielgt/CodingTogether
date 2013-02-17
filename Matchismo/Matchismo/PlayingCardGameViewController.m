//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by gabriel on 13/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface PlayingCardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.numberOfCards
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}



@end
