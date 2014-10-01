//
//  Game.h
//  Hangman
//
//  Created by Rob Kunst on 23/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Words.h"

@interface Game : NSObject

@property NSInteger wordLength;
@property NSInteger numberOfGuesses;
@property NSString *guessedLetters;
@property Words *words;
@property BOOL gameOver;

-(void)playLetter:(char)letter;
-(id)initWithWordLength:(NSUInteger)wordLength andNumberOfGuesses:(NSUInteger)numberOfGuesses;

@end
