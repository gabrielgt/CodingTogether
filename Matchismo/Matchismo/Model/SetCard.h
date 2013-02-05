//
//  SetCard.h
//  Matchismo
//
//  Created by gabriel on 05/02/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) enum ShadingType shading;
@property (nonatomic) enum ColorType color;

+ (NSArray *)validSymbols;

enum ShadingType
{
    Solid,
    Striped,
    Open,
    
    ShadingTypeCount
};

enum ColorType
{
    Red,
    Green,
    Purple,
    
    ColorTypeCount
};

@end

