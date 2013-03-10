//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Dulio Denis on 2/11/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatching Game.h"
#import "GameResult.h"
#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"
#import "SetCardView.h"
#import "SetPlayingCardCollectionViewCell.h"

@interface CardGameViewController()
-(void)updateUI;
-(void)setFlipCount:(int)flipCount;
@end

@interface SetCardGameViewController ()
// @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CardButtons;
@property (strong, nonatomic) CardMatching_Game *game;
@property (nonatomic) int matchMode;
@property (weak, nonatomic) IBOutlet UICollectionView *setCollectionView;

// - (NSString *)makeSetCardFace:(Card *)card;

@end

@implementation SetCardGameViewController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtindex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

#pragma mark - Concrete Classes

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // concrete
    if ([cell isKindOfClass:[SetPlayingCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetPlayingCardCollectionViewCell *)cell).setCardView;
        
        if ([card isKindOfClass:[SetPlayingCard class]]) {
            SetPlayingCard *playingCard = (SetPlayingCard *)card;
            setCardView.number = playingCard.number;
            [self cardSetter:setCardView usingPlayingCard:playingCard];
        }
    }
}

- (void)cardSetter:(SetCardView *)setCard usingPlayingCard:(SetPlayingCard *)playingCard
{
    if ([playingCard.color isEqualToString:@"red"]) setCard.color = RED;
    if ([playingCard.color isEqualToString:@"purple"]) setCard.color = PURPLE;
    if ([playingCard.color isEqualToString:@"green"]) setCard.color = GREEN;
    
    if ([playingCard.shade isEqualToString:@"solid"]) setCard.shading = SOLID;
    if ([playingCard.shade isEqualToString:@"stripped"]) setCard.shading = STRIPE;
    if ([playingCard.shade isEqualToString:@"open"]) setCard.shading = OPEN;
    
    if ([playingCard.symbol isEqualToString:@"▲"]) setCard.shape = DIAMOND;
    if ([playingCard.symbol isEqualToString:@"●"]) setCard.shape = OVAL;
    if ([playingCard.symbol isEqualToString:@"■"]) setCard.shape = SQUIGGLE;
}


- (Deck *)createDeck
{
    return [[SetPlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return 12;
}

- (CardMatching_Game *)game
{
    if (!_game) _game = [[CardMatching_Game alloc] initWithCardCount:self.startingCardCount
                                                           usingDeck:[[SetPlayingCardDeck alloc] init]];
    if (!self.matchMode) self.matchMode = 3;
    return _game;
}

- (NSString *)makeSetCardFace:(Card *)card
{
    return card.contents;
}

-(void)updateUI
{
    [super updateUI];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

@end
