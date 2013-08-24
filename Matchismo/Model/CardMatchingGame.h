//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jose on 14/08/13.
//  Copyright (c) 2013 jearias. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id) initWithCardCount:(NSUInteger) cardCount usingDeck:(Deck *) deck;

- (void) flipCardAtIndex:(NSUInteger) index;

- (Card *) cardAtIndex:(NSUInteger) index;

@property (nonatomic, getter=isTwoCardMode) BOOL twoCardMode;
@property (readonly, nonatomic) int score;
@property (readonly, strong, nonatomic) NSString *lastAction;

@end
