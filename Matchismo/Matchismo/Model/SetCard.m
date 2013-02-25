//
//  SetCard.m
//  Matchismo
//
//  Created by gabriel on 05/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"■"];
}

- (NSString *)contents
{
    NSString *string = @"";
    string = [string stringByPaddingToLength:self.number
                             withString:self.symbol startingAtIndex:0];
    return string;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if (otherCards.count == 2)
    {
        SetCard *card2 = otherCards[0];
        SetCard *card3 = otherCards[1];
        
        if (
            (
             (self.number == card2.number && self.number == card3.number)
             ||
             (self.number != card2.number && self.number != card3.number &&
              card2.number != card3.number)
            )
            &&
            (
             (self.symbol == card2.symbol && self.symbol == card3.symbol)
             ||
             (self.symbol != card2.symbol && self.symbol != card3.symbol &&
              card2.symbol != card3.symbol)
            )
            &&
            (
             (self.shading == card2.shading && self.shading == card3.shading)
             ||
             (self.shading != card2.shading && self.shading != card3.shading &&
              card2.shading != card3.shading)
            )
            &&
            (
             (self.color == card2.color && self.color == card3.color)
             ||
             (self.color != card2.color && self.color != card3.color &&
              card2.color != card3.color)
            )
           )
        {
            score = 1;
        }
    }
    
    return score;
}


@end
