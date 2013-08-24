//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jose on 14/08/13.
//  Copyright (c) 2013 jearias. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@end

@implementation PlayingCard

- (int) match:(NSArray *)otherCards {
    int score= 0;
    
    for (PlayingCard *card in otherCards) {
        if (card.rank == self.rank) {
            score= 4;
        } else {
            score = 0;
            break;
        }
    }
    if (!score) {
        for (PlayingCard *card in otherCards) {
            if ([card.suit isEqualToString:self.suit]) {
                score= 1;
            } else {
                score=0;
                break;
            }
        }
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings ];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit= _suit; //because we provide getter and setter

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit=suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank<=[PlayingCard maxRank]) {
        _rank=rank;
    }
}

@end
