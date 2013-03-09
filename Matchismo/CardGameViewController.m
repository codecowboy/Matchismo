//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Luke Mackenzie on 07/02/2013.
//  Copyright (c) 2013 Luke Mackenzie. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

//set private properties
@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) int flipCount;
@property(strong, nonatomic) PlayingCardDeck *deck;

@end

@implementation CardGameViewController

-(PlayingCardDeck *)deck
{
    if (!_deck){
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender

{
    if(!sender.isSelected) {
        [sender setTitle:[self.deck drawRandomCard].contents
                forState:UIControlStateSelected];
    }
    sender.selected = !sender.isSelected;
    self.flipCount++;

}


@end
