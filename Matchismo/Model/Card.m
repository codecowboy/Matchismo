//
//  Card.m
//  Matchismo
//
//  Created by Luke Mackenzie on 07/02/2013.
//  Copyright (c) 2013 Luke Mackenzie. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)othercards
{
    int score = 0;
    
    for (Card *card in othercards) {
        if([card.contents isEqualToString:self.contents]) {
            score=1;
        }
    }
    return score;
}

@end
