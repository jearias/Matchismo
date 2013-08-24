//
//  Card.m
//  Matchismo
//
//  Created by Jose on 14/08/13.
//  Copyright (c) 2013 jearias. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score=0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score=1;
        }
    }
    return score;
}

@end
