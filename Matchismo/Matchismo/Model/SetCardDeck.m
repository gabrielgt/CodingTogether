//
//  SetCardDeck.m
//  Matchismo
//
//  Created by gabriel on 05/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self)
    {
        for (NSUInteger i = 1 ; i<=3 ; i++)
        {
            for (NSString *eachSymbol in [SetCard validSymbols])
            {
                for (enum ShadingType eachShading = 0 ; eachShading < ShadingTypeCount;
                     eachShading++)
                {
                    for (enum ColorType eachColor = 0 ; eachColor < ColorTypeCount ;
                         eachColor++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = i;
                        card.symbol = eachSymbol;
                        card.shading = eachShading;
                        card.color = eachColor;
                        [self addCard:card atTop:true];
                    }
                }
            }
        }
        
    }
    
    return self;
}

@end
