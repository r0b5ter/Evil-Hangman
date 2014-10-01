//
//  MainViewController.m
//  Hangman
//
//  Created by Rob Kunst on 11/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "MainViewController.h"
#import "Game.h"
#import "Words.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //create a new words object and start the game with those words.
    self.words = [[Words alloc] init];
    [self startNewGame];
}

-(void)startNewGame{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger wordLength = [defaults integerForKey:@"wordLength"];
    NSUInteger numberOfGuesses = [defaults integerForKey:@"numberOfGuesses"];
    self.game = [[Game alloc] initWithWordLength:wordLength andNumberOfGuesses:numberOfGuesses];
    NSMutableString *wordformat = [NSMutableString new];
    
    //The word to be guessed starts with an underscore for every letter in the word.
    for (int i = 1; i <= self.game.wordLength; i++) {
        [wordformat appendString:@"_"];
    }
    self.wordLabel.text = wordformat;
    
    //(Re)activate the keyboard buttons
    for (UIView* view in self.view.subviews)
    {
        if([view isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton*)view;
            button.enabled = YES;
        }
    }
    [self updateGuessLabel];
}

-(void)updateGuessLabel{
    self.guessRemainingLabel.text = [NSString stringWithFormat:@"Guesses left: %d", (int)self.game.numberOfGuesses];
}

//Updates the word own screen with the guessed letters.
-(void)updateWordLabel{
    NSString *letters = self.game.guessedLetters;
    NSString *currentWord = self.wordLabel.text;
    // iterate through word and replace the letters that are guessed correctly.
    for (int i=0; i<self.game.wordLength; i++) {
        char currentWordLetter = [currentWord characterAtIndex:i];
        char letter = [letters characterAtIndex:i];
        char underscore = '_';
        if(currentWordLetter == underscore){
            NSRange range = NSMakeRange(i, 1);
            currentWord = [currentWord stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",letter]];
        }
    }
    self.wordLabel.text = currentWord;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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


//If game is over, check if the player has won or lost and present an alertview to notify him/her.
-(void)gameOver{
    NSString *message = [NSString string];
    if(self.game.gameOver){
        message = @"You Lost!\n Restart?";
    } else{
        message = @"You Won!\n Press Cancel to see the word!";
    }
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Game Over"
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancel = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* restart = [UIAlertAction
                             actionWithTitle:@"Restart"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self startNewGame];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:cancel];
    [alert addAction:restart];
    
    [self presentViewController:alert animated:YES completion:nil];

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

- (IBAction)restartGame:(UIButton *)sender {
    [self startNewGame];
}

- (IBAction)keyboardButton:(UIButton *)sender {
    //Disable the key if it has been pressed.
    sender.enabled = NO;
    [self.game playLetter:[sender.titleLabel.text characterAtIndex:0]];
    [self updateWordLabel];
    [self updateGuessLabel];
    //If there are no more unguessed letters, the game is won.
    if(![self.wordLabel.text containsString:[NSString stringWithFormat:@"%c",'_']]){
        [self gameOver];
    }
    //If there are no more options left, the game is also over.
    if(self.game.gameOver){
        [self gameOver];
    }
}

@end
