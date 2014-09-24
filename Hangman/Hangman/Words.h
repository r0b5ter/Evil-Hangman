//
//  Words.h
//  Hangman
//
//  Created by Rob Kunst on 15/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Words : NSObject

@property NSMutableArray *words;

-(NSInteger)numberOfWords;
-(void)filterWordsOfLength:(NSInteger)length;

@end
