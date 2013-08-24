//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jose on 14/08/13.
//  Copyright (c) 2013 jearias. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UISegmentedControl *switchMode;

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (nonatomic) BOOL twoCardMode;
@property (nonatomic, getter = isFirstFlip) BOOL firstFlip;

@end

@implementation CardGameViewController


- (CardMatchingGame *) game {
    if (!_game) {
        _game= [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
        _game.twoCardMode=YES;
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons= cardButtons;
    [self updateUI];
    
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastActionLabel.text = self.game.lastAction;
}

- (void) setFlipCount:(int)flipCount {
    _flipCount=flipCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips update to %d", self.flipCount);
}

- (void) flipDownCards {
    for (UIButton *cardButton in self.cardButtons) {
        cardButton.selected=NO;
        cardButton.enabled=YES;
        cardButton.alpha=1;
    }
}

- (IBAction)flipCard:(UIButton *)sender {
    if (![self isFirstFlip]) {
        self.switchMode.enabled=NO;
        self.firstFlip=YES;
    }
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)playAgain:(UIButton *)sender {
    self.flipCount=0;
    BOOL tempMode = [self.game isTwoCardMode];
    self.game=nil;
    self.game.twoCardMode= tempMode;
    self.switchMode.enabled=YES;
    self.firstFlip=NO;
    [self flipDownCards];
    [self updateUI];
}

- (IBAction)changePlayMode:(UISegmentedControl *)sender {
    NSUInteger selected = sender.selectedSegmentIndex;
    NSLog(@"Change to %@", [sender titleForSegmentAtIndex:selected]);
    [self playAgain:nil];
    self.game.twoCardMode = !selected;
    
}

@end
