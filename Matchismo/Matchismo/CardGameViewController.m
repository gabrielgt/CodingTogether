//
//  CardGameViewController.m
//  Matchismo
//
//  Created by gabriel on 1/29/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (strong, nonatomic) UIImage *cardBackImage;
@property (strong, nonatomic) NSMutableArray *explanationHistoryArray;
@property (weak, nonatomic) IBOutlet UISlider *explanationHistorySlider;
@end

@implementation CardGameViewController

- (IBAction)flipCard:(UIButton *)sender
{
    self.modeSelector.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
        {
            Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
            [cardButton setTitle:card.contents
                        forState:UIControlStateSelected];
            [cardButton setTitle:card.contents
                        forState:UIControlStateSelected|UIControlStateDisabled];
            cardButton.selected = card.isFaceUp;
            cardButton.enabled = !card.isUnplayable;
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
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    [self.explanationHistoryArray addObject:[self buildExplanationString]];
    [self.explanationHistorySlider setMaximumValue:self.explanationHistoryArray.count-1];
    [self setExplanationHistorySliderValue:self.explanationHistorySlider.maximumValue];
}

- (NSString *)buildExplanationString
{
    switch (self.game.lastAction)
    {
        case None:
            return @"Let's start again";
            break;
        case FlippedDown:
            return [NSString stringWithFormat:@"Flipped down %@",
                    self.game.lastCardsPlayed.lastObject];
            break;
        case FlippedUp:
            return [NSString stringWithFormat:@"Flipped up %@",
                    self.game.lastCardsPlayed.lastObject];
            break;
        case Matched:
            return [NSString stringWithFormat:@"Matched %@ for %d points",
                    [self.game.lastCardsPlayed componentsJoinedByString:@" & "]
                    , self.game.lastPartialScore];
            break;
        case Missmatched:
            return [NSString stringWithFormat:@"%@ don't match! %d point penalty!",
                    [self.game.lastCardsPlayed componentsJoinedByString:@" & "],
                    self.game.lastPartialScore];
            break;
    }
}

- (IBAction)dealCards:(UIButton *)sender
{
    self.game = nil;
    self.game.gameMode = self.modeSelector.selectedSegmentIndex + 2;
    [self updateUI];
    self.modeSelector.enabled = YES;
    self.explanationHistoryArray = nil;
    self.explanationHistorySlider.value = 0;
    self.explanationHistorySlider.maximumValue = 0;
}

- (IBAction)modeChanged:(UISegmentedControl *)sender
{
    self.game.gameMode = sender.selectedSegmentIndex + 2;
}

- (UIImage *)cardBackImage
{
    if (!_cardBackImage)
    {
        _cardBackImage = [UIImage imageNamed:@"cardback.png"];
    }
    return _cardBackImage;
}

- (IBAction)explanationHistoryChanged:(UISlider *)sender
{
    [self setExplanationHistorySliderValue:sender.value];
}

- (NSMutableArray *)explanationHistoryArray
{
    if (!_explanationHistoryArray)
    {
        _explanationHistoryArray = [[NSMutableArray alloc] init];
        if (self.explanationLabel.text)
            [_explanationHistoryArray addObject:self.explanationLabel.text];
        else
            [_explanationHistoryArray addObject:@"Are you ready?"];
            
    }
    return _explanationHistoryArray;
}

- (void)setExplanationHistorySliderValue:(int)value
{
    self.explanationLabel.text = self.explanationHistoryArray[value];
    self.explanationHistorySlider.value = value;
    if (value < self.explanationHistoryArray.count - 1)
    {
        self.explanationLabel.alpha = 0.5;
    }
    else
    {
        self.explanationLabel.alpha = 1;
    }
}

@end
