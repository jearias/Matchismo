//
//  Deck.h
//  Matchismo
//
//  Created by Jose on 14/08/13.
//  Copyright (c) 2013 jearias. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL) atTop;

- (Card *)drawRandomCard;

@end
