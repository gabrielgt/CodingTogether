//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by gabriel on 17/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation SetCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[SetCardDeck alloc] init]];
        _game.gameMode = 3;
    }
    return _game;
}

- (void)updateUISubClass
{
    for(UIButton *cardButton in self.cardButtons)
    {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons
                                                indexOfObject:cardButton]];
        
        [cardButton setAttributedTitle:[self attributedStringFromCard:card]
                    forState:UIControlStateNormal|UIControlStateSelected];
        [cardButton setAttributedTitle:[self attributedStringFromCard:card]
                              forState:UIControlStateNormal];
        cardButton.hidden = card.isUnplayable;
        
        if (!cardButton.selected)
        {
            [cardButton setBackgroundColor:[UIColor grayColor]];
           
        }
        else
        {
            [cardButton setBackgroundColor:[UIColor blueColor]];
        }
        
    }
}

- (NSMutableAttributedString *)attributedStringFromCard: (SetCard *)card
{
    NSRange range = NSMakeRange(0, [card.contents length]);
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]
                                       initWithString:card.contents];
    UIColor *color;
    switch (card.color)
    {
        case Green: color = [UIColor greenColor]; break;
        case Purple: color = [UIColor purpleColor]; break;
        case Red: color = [UIColor redColor]; break;
        default: color = [UIColor yellowColor]; break;
    }
    
    
    switch (card.shading)
    {
        case Open: [color colorWithAlphaComponent:0.3]; break;
        case Striped: [color colorWithAlphaComponent:0.6]; break;
        default: [color colorWithAlphaComponent:1]; break;
    }
    
    [attriString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attriString;
}

@end
