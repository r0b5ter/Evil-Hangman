//
//  FlipsideViewController.h
//  Hangman
//
//  Created by Rob Kunst on 11/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property NSUserDefaults *userDefaults;

@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessLabel;

@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UISlider *guessesSlider;

- (IBAction)wordLengthSliderChanged:(UISlider *)sender;
- (IBAction)guessesSliderChanged:(UISlider *)sender;


@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
