//
//  FlipsideViewController.m
//  Hangman
//
//  Created by Rob Kunst on 11/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Words.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    Words *words = [[Words alloc] init];
    NSNumber *maxLength = [words.words valueForKeyPath: @"@max.length"];
    self.wordLengthSlider.maximumValue = [maxLength integerValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int wordLength = [defaults integerForKey:@"wordLength"];
    int numberOfGuesses = [defaults integerForKey:@"numberOfGuesses"];
 
    
    
    self.wordLengthSlider.value = wordLength;
    self.guessesSlider.value = numberOfGuesses;
    self.worldLengthLabel.text = [NSString stringWithFormat:@"Word Length: %d",wordLength];
    self.guessLabel.text = [NSString stringWithFormat:@"Number of guesses: %d",numberOfGuesses];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}



- (IBAction)wordLengthSliderChanged:(UISlider *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int value = (int)sender.value;
    self.worldLengthLabel.text = [NSString stringWithFormat:@"Word Length: %d",value];
    [defaults setInteger:value forKey:@"wordLength"];
}

- (IBAction)guessesSliderChanged:(UISlider *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int value = (int)sender.value;
    self.guessLabel.text = [NSString stringWithFormat:@"Number of guesses: %d",value];
    [defaults setInteger:value forKey:@"numberOfGuesses"];
}
@end
