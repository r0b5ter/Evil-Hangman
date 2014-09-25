//
//  MainViewController.h
//  Hangman
//
//  Created by Rob Kunst on 11/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "FlipsideViewController.h"
#import "HangManGame.h"
#import "Words.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *playingFieldView;
@property (weak, nonatomic) IBOutlet UILabel *guessRemainingLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;


- (IBAction)restartGame:(UIButton *)sender;

- (IBAction)keyboardButton:(UIButton *)sender;

@property Words *words;
@property HangManGame *game;


@property NSArray *keys;

@end
