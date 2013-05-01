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
@property (nonatomic) NSString *lastFlipText;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck usingGameMode:(NSUInteger)matchMode
{
    self = [super init];
    self.matchMode = matchMode;
    
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
//    Card *card = [self cardAtIndex:index];
//    self.lastFlipText = [NSString stringWithFormat:@"Flipped %@",  card.contents];
//    if (!card.isUnplayable) { //not already matched
//        
//        if (!card.isFaceUp) {
//            //see if flipping the card creates a match
//            for (Card *otherCard in self.cards) {
//                if (otherCard.isFaceUp && !otherCard.isUnplayable) { //if the card to be matched is face up and not already matched
//                    int matchScore = [card match:@[otherCard]]; //@creates the array
//                    if(matchScore) {
//                        otherCard.unplayable = YES;
//                        card.unplayable = YES;
//                  
//                        self.score += matchScore * MATCH_BONUS;
//                        self.lastFlipText = [NSString stringWithFormat:@"Matched %@ with %@ for %d points", card.contents, otherCard.contents, self.score];
//                        
//                    } else {
//                        otherCard.faceUP = NO;
//                        self.lastFlipText = [NSString stringWithFormat:@" %@ and %@ no matchy! :(", card.contents, otherCard.contents];
//                        self.score -= MISMATCH_PENALTY;      
//
//                    }
//                    break;
//                }
//            }
//            self.score -= FLIP_COST;
//        }
//        card.faceUP = !card.isFaceUp;
//    }


        Card *card = [self cardAtIndex:index];
        NSMutableArray *cardsFacingUp = [[NSMutableArray alloc] init];
        
        
        if (card && !card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardsFacingUp addObject:otherCard];
                }
            }
            
            if ([cardsFacingUp count] == self.matchMode) {
                int matchScore = [card match:cardsFacingUp];
                
                if (matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in cardsFacingUp) {
                        otherCard.unplayable = YES;
                    }
                    
                    self.score += matchScore * MATCH_BONUS;
                    self.lastFlipText =[NSString stringWithFormat:@"Matched %@ and %@ for %d points!",[cardsFacingUp componentsJoinedByString:@", "],card.contents, matchScore * MATCH_BONUS];
                    NSLog(@"lastfliptext:%@ ", self.lastFlipText);
                } else {
                    
                    for (Card *otherCard in cardsFacingUp) {
                        otherCard.faceUP= NO;
                    }
                    
                    self.score -= MISMATCH_PENALTY;
                    self.lastFlipText = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!",[cardsFacingUp componentsJoinedByString:@", "],card.contents,MISMATCH_PENALTY];
                }
            } else {
                self.lastFlipText = [NSString stringWithFormat:@"Flipped up %@",card.contents];
            }
            
            self.score -= FLIP_COST;
            
        }
        
        card.faceUP = !card.faceUP;
        
    }

@end
