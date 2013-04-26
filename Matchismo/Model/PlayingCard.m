//
//  PlayingCard.m
//  Matchismo
//
//  Created by Luke Mackenzie on 07/02/2013.
//  Copyright (c) 2013 Luke Mackenzie. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // required as we are implementing getter AND setter

- (int)match:(NSArray *)otherCards //overrides Card's match method
{
    int score = 0;
    
    if (otherCards.count ==1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
        
    }
    return score;
    
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦", @"♠",@"♣"];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
    
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q",
@"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count -1; // self is ok here has we are calling from another class method
}

- (void)setRank:(NSUInteger)rank
{
    if ( rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
