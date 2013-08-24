//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jose on 14/08/13.
//  Copyright (c) 2013 jearias. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;


@end
