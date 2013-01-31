//
//  CardGameViewController.m
//  Matchismo
//
//  Created by gabriel on 1/29/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) PlayingCardDeck *deck;
@end

@implementation CardGameViewController

- (IBAction)flipCard:(UIButton *)sender
{
    if (!sender.selected)
    {
        if (self.deck.count>0)
        {
            [sender setTitle:self.deck.drawRandomCard.contents.description forState:UIControlStateSelected];
        }
        else
        {
            [sender setTitle:@"😢" forState:UIControlStateSelected];
        }
    }
    
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (PlayingCardDeck *)deck
{
    if (!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}


@end
