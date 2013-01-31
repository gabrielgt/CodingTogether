//
//  PlayingCard.h
//  Matchismo
//
//  Created by gabriel on 30/01/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
