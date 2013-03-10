//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Dulio Denis on 2/8/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card

@property (nonatomic) NSUInteger number;          // 1, 2, or 3
/* Eventually refactor to use just ints
@property (nonatomic) NSInteger symbol;
@property (nonatomic) NSInteger shade;
@property (nonatomic) NSInteger color;
*/

@property (strong, nonatomic) NSString *symbol; // triangle, circle, square
@property (strong, nonatomic) NSString *shade;  // solid, striped, or open
@property (strong, nonatomic) NSString *color;  // red, green, or purple
+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSUInteger)maxRank;
@end
