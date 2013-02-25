//
//  CardGameViewController.m
//  Matchismo
//
//  Created by gabriel on 1/29/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UISlider *explanationHistorySlider;

@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSMutableArray *explanationHistoryArray;
@end

@implementation CardGameViewController

- (IBAction)flipCard:(UIButton *)sender
{
    self.modeSelector.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealCards:(UIButton *)sender
{
    self.game = nil;
    self.game.gameMode = self.modeSelector.selectedSegmentIndex + 2;
    self.modeSelector.enabled = YES;
    self.explanationHistoryArray = nil;
    self.explanationHistorySlider.value = 0;
    self.explanationHistorySlider.maximumValue = 0;
    
    [self dealCardsSubClass];
    [self updateUI];
}

- (void)dealCardsSubClass
{
    
}

- (IBAction)modeChanged:(UISegmentedControl *)sender
{
    self.game.gameMode = sender.selectedSegmentIndex + 2;
}

- (IBAction)explanationHistoryChanged:(UISlider *)sender
{
    [self setExplanationHistorySliderValue:sender.value];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}


- (void)viewDidLoad
{
    [self updateUI];
}


- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
        {
            Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
            cardButton.selected = card.isFaceUp;
            cardButton.enabled = !card.isUnplayable;
        }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    [self.explanationHistoryArray addObject:[self buildExplanationString]];
    [self.explanationHistorySlider setMaximumValue:self.explanationHistoryArray.count-1];
    [self setExplanationHistorySliderValue:self.explanationHistorySlider.maximumValue];
    
    [self updateUISubClass];
}

- (void)updateUISubClass
{
    
}

- (NSAttributedString *)buildExplanationString
{
    NSMutableAttributedString *attriString;
    
    NSString *stringPuntos;
    
    switch (self.game.lastAction)
    {
        case None:
            attriString = [[NSMutableAttributedString alloc] initWithString:@"Let's start again"];
            break;
        case FlippedDown:
            attriString = [[NSMutableAttributedString alloc] initWithString:@"Flipped down "];
            [attriString appendAttributedString:
                [self attributedDescriptionFromCard:self.game.lastCardsPlayed.lastObject]];
            break;
        case FlippedUp:
            attriString = [[NSMutableAttributedString alloc] initWithString:@"Flipped up "];
            [attriString appendAttributedString:
             [self attributedDescriptionFromCard:self.game.lastCardsPlayed.lastObject]];
            break;
        case Matched:
            attriString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [attriString appendAttributedString:
             [self attributedDescriptionFromCards:self.game.lastCardsPlayed]];
            
            stringPuntos = [NSString stringWithFormat:@" %d points", self.game.lastPartialScore];
            [attriString appendAttributedString:[[NSAttributedString alloc] initWithString:stringPuntos]];
            break;
        case Missmatched:
            attriString = [[NSMutableAttributedString alloc] init];
            [attriString appendAttributedString:
             [self attributedDescriptionFromCards:self.game.lastCardsPlayed]];
            [attriString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" don't match!"]];
            
            stringPuntos = [NSString stringWithFormat:@" %d points", self.game.lastPartialScore];
            [attriString appendAttributedString:[[NSAttributedString alloc] initWithString:stringPuntos]];
            break;
    }
    
    NSRange range = NSMakeRange(0, attriString.length);
    return [attriString attributedSubstringFromRange:range];
}

- (NSAttributedString *) attributedDescriptionFromCard: (Card *)card
{
    return [[NSAttributedString alloc] initWithString:card.description];
}

- (NSAttributedString *) attributedDescriptionFromCards: (NSArray *)cards
{
    return [[NSAttributedString alloc] initWithString:[cards componentsJoinedByString:@" & "]];
}

- (NSMutableArray *)explanationHistoryArray
{
    if (!_explanationHistoryArray)
    {
        _explanationHistoryArray = [[NSMutableArray alloc] init];
        if (self.explanationLabel.text)
            [_explanationHistoryArray addObject:self.explanationLabel.attributedText];
        else
            [_explanationHistoryArray addObject:
             [[NSAttributedString alloc] initWithString:@"Are you ready?"]];
            
    }
    return _explanationHistoryArray;
}

- (void)setExplanationHistorySliderValue:(int)value
{
    self.explanationLabel.attributedText = self.explanationHistoryArray[value];
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
