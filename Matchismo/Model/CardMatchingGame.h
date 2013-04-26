//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Luke Mackenzie on 26/04/2013.
//  Copyright (c) 2013 Luke Mackenzie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck *)deck;

- (void) flipCardAtIndex:(NSUInteger) index;

- (Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) int score; //no setter, only a getter

@end
