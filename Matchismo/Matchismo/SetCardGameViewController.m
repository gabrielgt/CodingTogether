//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by gabriel on 17/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCardMatchingGame.h"
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
        _game = [[SetCardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[SetCardDeck alloc] init]];
        _game.gameMode = 3;
    }
    return _game;
}

- (void)dealCardsSubClass
{
    self.game.gameMode = 3;
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
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
           
        }
        else
        {
            [cardButton setBackgroundColor:[UIColor grayColor]];
        }
        
    }
}

- (NSMutableAttributedString *)attributedStringFromCard: (SetCard *)card
{
    NSRange range = NSMakeRange(0, [card.contents length]);
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]
                                       initWithString:card.contents];
    UIColor *fillColor;
    UIColor *strokeColor;
    switch (card.color)
    {
        case Green: strokeColor = [UIColor greenColor]; break;
        case Purple: strokeColor = [UIColor purpleColor]; break;
        case Red: strokeColor = [UIColor redColor]; break;
        default: strokeColor = [UIColor yellowColor]; break;
    }
    
    switch (card.shading)
    {
        case Open: fillColor = [strokeColor colorWithAlphaComponent:0]; break;
        case Striped: fillColor = [strokeColor colorWithAlphaComponent:0.5]; break;
        default: fillColor = [strokeColor colorWithAlphaComponent:1]; break;
    }
    
    [attriString addAttribute:NSForegroundColorAttributeName value:fillColor range:range];
    [attriString addAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
    [attriString addAttribute:NSStrokeWidthAttributeName value:@-10 range:range];
    return attriString;
}

- (NSAttributedString *) attributedDescriptionFromCard: (Card *)card
{
    return [self attributedStringFromCard:(SetCard *)card];
}

- (NSAttributedString *) attributedDescriptionFromCards: (NSArray *)cards
{
    if (cards.count == 0) return NULL;
    
    NSMutableAttributedString *attriString = [self attributedStringFromCard:(SetCard *)cards[0]];
    for (NSUInteger i = 1 ; i<cards.count ; i++)
    {
        [attriString appendAttributedString:[[NSAttributedString alloc] initWithString:@" & "]];
        [attriString appendAttributedString:[self attributedStringFromCard:(SetCard *)cards[i]]];
    }
    
    return attriString;
}

@end
