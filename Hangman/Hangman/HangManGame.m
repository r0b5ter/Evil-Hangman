//
//  HangManGame.m
//  Hangman
//
//  Created by Rob Kunst on 23/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "HangManGame.h"
#import "Words.h"

@implementation HangManGame

-(id)init{
    self = [super init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.numberOfGuesses = [defaults integerForKey:@"numberOfGuesses"];
    self.wordLength = [defaults integerForKey:@"wordLength"];
    
    self.words = [[Words alloc] init];
    [self.words filterWordsOfLength:self.wordLength];
    return self;
}

-(void)playLetter:(char)letter{
    if(self.numberOfGuesses-- == 0){
        self.gameOver = YES;
    }
    NSMutableDictionary *equivalenceClasses = [[NSMutableDictionary alloc] init];
    NSMutableArray *largestClasses = [[NSMutableArray alloc] init];
    int largestClassCount = 0;
    
    for(NSString *word in self.words.words){
        //loop through every word in the word list to see if a letter has been guessed correctly.
        //creates a new string with the guessed letter on the right spot and _'s elsewhere.
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
        //NSLog(@"Partial word = %@", partialWord);
        
        NSMutableArray *equivalenceClass = [equivalenceClasses objectForKey:partialWord];
        //check if the equivalence class already exists and if not, create a new one.
        if (equivalenceClass){
            [equivalenceClass addObject:word];
        } else{
            equivalenceClass = [[NSMutableArray alloc] init];
            [equivalenceClass addObject:word];
            [equivalenceClasses setObject:equivalenceClass forKey:partialWord];
        }
//        NSLog(@"Eq class = %@ word = %@", partialWord, word);
        if(equivalenceClass.count > largestClassCount){
            if(equivalenceClass.count == largestClassCount) {
                [largestClasses addObject:equivalenceClass];
            }else{
                [largestClasses removeAllObjects];
                [largestClasses addObject:equivalenceClass];
                largestClassCount = equivalenceClass.count;
            }
        }
    }
    //TODO: should be random
    self.words.words = [largestClasses firstObject];
    NSLog(@"%@",[largestClasses firstObject]);
    NSString *partialWord = [[equivalenceClasses allKeysForObject:[largestClasses firstObject]] firstObject];
    //return partialWord;//NSLog(@"%@",partialWord); //logs the key of the equivalence class
    self.guessedLetters = partialWord;
}


@end
