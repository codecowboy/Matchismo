//
//  Card.h
//  Matchismo
//
//  Created by Luke Mackenzie on 07/02/2013.
//  Copyright (c) 2013 Luke Mackenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUP;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

-(int)match:(NSArray *)otherCards;

@end
