//
//  SetCardView.h
//  SetCard
//
//  Created by Dulio Denis on 3/7/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

// Shapes
#define DIAMOND 1
#define SQUIGGLE 2
#define OVAL 3

// Shades
#define STRIPE 1
#define SOLID 2
#define OPEN 3

// Colors
#define RED 1
#define PURPLE 2
#define GREEN 3

@property (nonatomic) NSInteger number;
@property (nonatomic) NSInteger shape;
@property (nonatomic) NSInteger color;
@property (nonatomic) NSInteger shading;
@property (nonatomic) BOOL faceUp;

@end
