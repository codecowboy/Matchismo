//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Luke Mackenzie on 26/04/2013.
//  Copyright (c) 2013 Luke Mackenzie. All rights reserved.
//

#import "CardMatchingGame.h"

/* 
 The area for private properties is called a Class Extension. Remember the ()
 */

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) { //checks for failure return of nil from super class
        
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            //protection against adding nil to NSMutableArray (causes a crash)
            if (!card) { 
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        
        if (!card.isFaceUp) {
            //see if flipping the card creates a match
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]]; //@creates the array
                    if(matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                  
                        self.score += matchScore * MATCH_BONUS;
                        
                    } else {
                        otherCard.faceUP = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUP = !card.isFaceUp;
    }
}

@end
