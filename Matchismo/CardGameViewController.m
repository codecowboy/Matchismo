//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Luke Mackenzie on 07/02/2013.
//  Copyright (c) 2013 Luke Mackenzie. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

//set private properties
@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
//@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlip;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;

@end

@implementation CardGameViewController

//-(Deck *)deck
//{
//    if (!_deck){
//        _deck = [[PlayingCardDeck alloc] init];
//    }
//    return _deck;
//}
- (IBAction)switchGameMode:(id)sender {
    self.game.matchMode = [sender selectedSegmentIndex] +2;
    NSLog(@"game mode: %d", self.game.matchMode);
}

- (IBAction)newDeal:(UIButton *)sender {

    self.game = nil; //runs the setter?
    self.flipCount = 0;
    [self updateUI];
    
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]
                         usingGameMode:self.gameMode.selectedSegmentIndex + 2 ] ;
    
    return _game;
}


-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
//    for(UIButton *cardButton in cardButtons) {
//        Card *card = [self.deck drawRandomCard];
//        [cardButton setTitle:card.contents
//                    forState:UIControlStateSelected];
//    }
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.2 :1.0;
 
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastFlip.text = self.game.lastFlipText;
    
}

- (IBAction)flipCard:(UIButton *)sender

{
//    if(!sender.isSelected) {
//        [sender setTitle:[self.deck drawRandomCard].contents
//                forState:UIControlStateSelected];
//    }
//    sender.selected = !sender.isSelected;
//    self.flipCount++;
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount ++;
    [self updateUI];

}


@end
