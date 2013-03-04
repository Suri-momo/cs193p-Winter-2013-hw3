//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dulio Denis on 1/25/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//
// Tap through all the cards in the deck.

#import "CardGameViewController.h"
#import "CardMatching Game.h"
#import "GameResult.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatching_Game *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mode;
@property (nonatomic) int matchMode;
@property (strong, nonatomic) GameResult *gameResult;
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@end

@implementation CardGameViewController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount; // ask game how many cards are in play
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtindex:indexPath.item];
    
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // abstract
}

- (void)setPlayingCardView:(PlayingCardView *)playingCardView
{
    _playingCardView = playingCardView;
    // playingCardView.rank = 13; // K
    // playingCardView.suit = @"♥";
//    [self drawRandomPlayingCard];
    [playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:playingCardView action:@selector(pinch:)]];
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (IBAction)mode:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)     {
        NSLog(@"Value Changed to 2-Card Mode"); self.matchMode = 2;
    } else     { NSLog(@"Value Changed to 3-Card Mode"); self.matchMode = 3; }
}

- (IBAction)deal
{    
    // realloc game
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    self.mode.enabled = TRUE;
    // repaint UI
    [self updateUI];
}

// based on the tab title use either the Match Game or the Set Game
- (CardMatching_Game *)game
{
    if (!_game) {
        _game = [[CardMatching_Game alloc] initWithCardCount:self.startingCardCount
                                                   usingDeck:[self createDeck]];
    }
    if (!self.matchMode) self.matchMode = 2; // default to 2 card mode at first
    return _game;
}

- (Deck *)createDeck { return nil; } // abstract

                 
-(void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtindex:indexPath.item];
        [self updateCell:cell usingCard:card]; // #winning
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score = %d", self.game.score];
    self.resultsLabel.text = self.game.flipResult;
}


-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Picked: %d", self.flipCount];
    NSLog(@"FlipCount =%d", self.flipCount);
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexpath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexpath) {
        [self.game flipCardAtIndex:indexpath.item matchMode:2];
        self.flipCount++;
        // disable UISegmentControl
        self.mode.enabled = FALSE;
        self.gameResult.score = self.game.score;
        [self updateUI];
    }
}

@end
