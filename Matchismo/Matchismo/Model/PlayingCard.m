//
//  PlayingCard.m
//  Matchismo
//
//  Created by gabriel on 30/01/13.
//  Copyright (c) 2013 Zetalogic. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
}

@end
