//
//  SetPlayingCardView.h
//  Matchismo
//
//  Created by Dulio Denis on 3/5/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SetPlayingCardView : UIView

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shade;
@property (strong, nonatomic) NSString *color;

@property (nonatomic) BOOL faceUp;

@end