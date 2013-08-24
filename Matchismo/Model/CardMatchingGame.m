//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jose on 14/08/13.
//  Copyright (c) 2013 jearias. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *lastAction;

@end

@implementation CardMatchingGame

#define MATCH_BONUS_2 4
#define MATCH_BONUS_3 8
#define MISMATCH_PENALTY -2
#define FLIP_COST 1

#define TWO_MODE_SCORE_SUIT_MATCH 1
#define TWO_MODE_SCORE_RANK_MATCH 4
#define THREE_MODE_SCORE_SUIT_MATCH 2
#define THREE_MODE_SCORE_RANK_MATCH 8

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for ( int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self= nil;
            } else {
                self.cards[i]= card;
            }
        }
    }
    
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void) flipCardAtIndex:(NSUInteger)index {
    NSMutableArray *cardArray = [[NSMutableArray alloc]init];
    Card *card = [self cardAtIndex:index];
    NSLog(@"card: %@", card.contents);
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.lastAction = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardArray addObject:otherCard];
                    NSLog(@"card added: %@", otherCard.contents);
                    if ([self isTwoCardMode]) {
                        [self doMatch:card :cardArray];
                        break;
                    } else if ([cardArray count] == 2) {
                        [self doMatch:card :cardArray];
                        break;
                    }
                }
            }
            self.score -= FLIP_COST;
            NSLog(@"flip cost");
        }
        card.faceUp = !card.isFaceUp;
    }
}



- (void) doMatch:(Card *)card :(NSArray *)cardArray {
    int matchScore = [card match:cardArray];
    NSLog(@"matchScore: %d", matchScore);
    card.unplayable = matchScore > 0 ? YES : NO;
    for (Card *otherCard in cardArray) {
        otherCard.unplayable = matchScore > 0 ? YES : NO;
        otherCard.faceUp = matchScore > 0 ? YES : NO;
    }
    self.score += [self getMatchBonus:[self isTwoCardMode] : matchScore];
    self.lastAction = [self getLastAction:card :cardArray :matchScore];
}



- (int) getMatchBonus:(BOOL)mode :(int)matchScore {
    if (matchScore>0) {
        if (mode) {
            return matchScore * MATCH_BONUS_2;
        } else {
            return matchScore * MATCH_BONUS_3;
        }
    } else {
        return MISMATCH_PENALTY;
    }
}



- (NSString *) getLastAction:(Card *)card :(NSArray *)array :(int)matchScore {
    NSString *result;
    if (matchScore>0) {
        if ([array count]==1) {
            result = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, ((Card *)[array firstObject]).contents, matchScore];
        } else {
            result = [NSString stringWithFormat:@"Matched %@, %@ & %@ for %d points", card.contents, ((Card *)[array firstObject]).contents, ((Card *)[array lastObject]).contents, matchScore];
        }
    } else {
        if ([array count]==1) {
            result = [NSString stringWithFormat:@"%@ & %@ don't match! %d points penalty", card.contents, ((Card *)[array firstObject]).contents, MISMATCH_PENALTY];
            
        } else {
            result = [NSString stringWithFormat:@"%@, %@ & %@ don't match! %d points penalty", card.contents, ((Card *)[array firstObject]).contents,((Card *)[array lastObject]).contents, MISMATCH_PENALTY];
        }
    }
    return result;
}

@end
