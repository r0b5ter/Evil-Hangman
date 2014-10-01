//
//  Game.m
//  Hangman
//
//  Created by Rob Kunst on 23/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "Game.h"
#import "Words.h"

@implementation Game

//Custom initializer
-(id)initWithWordLength:(NSUInteger)wordLength andNumberOfGuesses:(NSUInteger)numberOfGuesses{
    self = [super init];
    self.gameOver = NO;
    
    self.wordLength = wordLength;
    self.numberOfGuesses = numberOfGuesses;

    self.words = [[Words alloc] init];
    [self.words filterWordsOfLength:self.wordLength];
    return self;
}

//takes a letter and creates all the equivalence classes from the list of words.
-(void)playLetter:(char)letter{
    NSMutableDictionary *equivalenceClasses = [[NSMutableDictionary alloc] init];
    NSMutableArray *largestClasses = [[NSMutableArray alloc] init];
    int largestClassCount = 0;
    
    //loop through every word in the word list to see if a letter has been guessed correctly.
    //creates a new string with the guessed letter on the right spot and _'s elsewhere.
    for(NSString *word in self.words.words){
        NSMutableString *partialWord = [[NSMutableString alloc] init];
        for(int index = 0; index < word.length; index++){
            char character = [word characterAtIndex:index];
            if(character == letter){
                [partialWord appendString:[NSString stringWithFormat:@"%c",character]];
            }
            else{
                [partialWord appendString:@"_"];
            }
        }

        NSMutableArray *equivalenceClass = [equivalenceClasses objectForKey:partialWord];
        //check if the equivalence class already exists and if not, create a new one.
        if (equivalenceClass){
            [equivalenceClass addObject:word];
        } else{
            equivalenceClass = [[NSMutableArray alloc] init];
            [equivalenceClass addObject:word];
            [equivalenceClasses setObject:equivalenceClass forKey:partialWord];
        }

        if(equivalenceClass.count > largestClassCount){
            if(equivalenceClass.count == largestClassCount) {
                [largestClasses addObject:equivalenceClass];
            }else{
                [largestClasses removeAllObjects];
                [largestClasses addObject:equivalenceClass];
                largestClassCount = (int)equivalenceClass.count;
            }
        }
    }

    //Pick a random equivalence class from the array that contains all the largest equivalence classes.
    NSUInteger randomIndex = arc4random() % [largestClasses count];
    self.words.words = [largestClasses objectAtIndex:randomIndex];
    
    //Check if the guess is correct and update the state of the game.
    NSString *partialWord = [[equivalenceClasses allKeysForObject:[largestClasses firstObject]] firstObject];
    self.guessedLetters = partialWord;
    if(!([partialWord containsString:[NSString stringWithFormat:@"%c", letter]])){
        self.numberOfGuesses--;
        if(self.numberOfGuesses < 1){
            self.gameOver = YES;
        }
    }
}


@end
