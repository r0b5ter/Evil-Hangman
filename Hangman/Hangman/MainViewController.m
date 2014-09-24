//
//  MainViewController.m
//  Hangman
//
//  Created by Rob Kunst on 11/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "MainViewController.h"
#import "HangManGame.h"
#import "Words.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.words = [[Words alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self startNewGame];
}

-(void)updateGuessLabel{
    self.guessRemainingLabel.text = [NSString stringWithFormat:@"Guesses left: %d", self.game.numberOfGuesses];
}

-(void)startNewGame{
    self.game = [[HangManGame alloc] init];
    NSMutableString *wordformat = [NSMutableString new];
    
    // Change currentProgress into hyphens.
    for (int i = 1; i <= self.game.wordLength; i++) {
        [wordformat appendString:@"_"];
    }
    self.wordLabel.text = wordformat;
    
    //reactivate the keyboard buttons
    for (UIView* view in self.view.subviews)
    {
        if([view isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton*)view;
            button.enabled = YES;
        }
    }
    [self updateGuessLabel];
}

-(void)playLetter:(NSString*)key{
    NSLog(@"Played key: %@",key);
    return;
}

-(void)updateWordLabel{
    
    NSString *letters = self.game.guessedLetters;
    NSString *currentWord = self.wordLabel.text;
    // iterate through word
    for (int i=0; i<self.game.wordLength; i++) {
        NSLog(@"for loop");
        
        char currentWordLetter = [currentWord characterAtIndex:i];
        char letter = [letters characterAtIndex:i];
        char underscore = '_';
        
        if(currentWordLetter == underscore){
            NSLog(@"if loop");
            NSRange range = NSMakeRange(i, 1);
            currentWord = [currentWord stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",letter]];
        }
    }
    self.wordLabel.text = currentWord;
}

-(void)updateLabelWithLetters:(NSString*)letters{
    
    NSString *currentWord = self.wordLabel.text;
    // iterate through word
    for (int i=0; i<self.game.wordLength; i++) {
        NSLog(@"for loop");
        
        char currentWordLetter = [currentWord characterAtIndex:i];
        char letter = [letters characterAtIndex:i];
        char underscore = '_';
        
        if(currentWordLetter == underscore){
            NSLog(@"if loop");
            NSRange range = NSMakeRange(i, 1);
            currentWord = [currentWord stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",letter]];
        }
    }
    self.wordLabel.text = currentWord;
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (IBAction)startGame:(UIButton *)sender {
    NSLog(@"Number of words = %d", [self.game.words numberOfWords]);
}

- (IBAction)filterButtonPressed:(UIButton *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger wordLength = [defaults integerForKey:@"wordLength"];
}

- (IBAction)restartGame:(UIButton *)sender {
    [self startNewGame];
}

- (IBAction)keyboardButton:(UIButton *)sender {
    NSLog(@"Key pressed = %@",sender.titleLabel.text);
    [self.game playLetter:[sender.titleLabel.text characterAtIndex:0]];
    [self updateWordLabel];
//    [self updateLabelWithLetters:newLetters];
    [self updateGuessLabel];
//    NSLog(@"Newletters: %@", newLetters);
    //self.wordLabel.text = newLetters;
    sender.enabled = NO;
}

@end
