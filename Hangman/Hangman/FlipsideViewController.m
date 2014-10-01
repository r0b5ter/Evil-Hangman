//
//  FlipsideViewController.m
//  Hangman
//
//  Created by Rob Kunst on 11/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Words.h"

@implementation FlipsideViewController

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create a words object to find out the longest word in the list.
    Words *words = [[Words alloc] init];
    NSNumber *maxLength = [words.words valueForKeyPath: @"@max.length"];
    //Make sure the length of the word to be guessed is not longer than the longest word.
    self.wordLengthSlider.maximumValue = [maxLength integerValue];
    
    //Get the standard user defaults to retrieve the slider values and update the labels.
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    int wordLength = (int)[self.userDefaults integerForKey:@"wordLength"];
    int numberOfGuesses = (int)[self.userDefaults integerForKey:@"numberOfGuesses"];
    self.wordLengthSlider.value = wordLength;
    self.guessesSlider.value = numberOfGuesses;
    self.wordLengthLabel.text = [NSString stringWithFormat:@"Word Length: %d",wordLength];
    self.guessLabel.text = [NSString stringWithFormat:@"Number of guesses: %d",numberOfGuesses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

//Actions to update the user preferences if the slider value has changed.
- (IBAction)wordLengthSliderChanged:(UISlider *)sender {
    int value = (int)sender.value;
    self.wordLengthLabel.text = [NSString stringWithFormat:@"Word Length: %d",value];
    [self.userDefaults setInteger:value forKey:@"wordLength"];
}

- (IBAction)guessesSliderChanged:(UISlider *)sender {
    int value = (int)sender.value;
    self.guessLabel.text = [NSString stringWithFormat:@"Number of guesses: %d",value];
    [self.userDefaults setInteger:value forKey:@"numberOfGuesses"];
}
@end
