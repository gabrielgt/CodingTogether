//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by gabriel on 13/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"


@interface PlayingCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) UIImage *cardBackImage;
@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[PlayingCardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
        _game.gameMode = 2;
    }
    return _game;
}

- (void)updateUISubClass
{
    for(UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (!cardButton.selected)
        {
            [cardButton setImage:self.cardBackImage forState:UIControlStateNormal];
        }
        else
        {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        
    }
}

- (UIImage *)cardBackImage
{
    if (!_cardBackImage)
    {
        _cardBackImage = [UIImage imageNamed:@"cardback.png"];
    }
    return _cardBackImage;
}

@end
