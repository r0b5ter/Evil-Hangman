//
//  Words.m
//  Hangman
//
//  Created by Rob Kunst on 15/09/14.
//  Copyright (c) 2014 Rob Kunst. All rights reserved.
//

#import "Words.h"

@implementation Words

-(id)init{
    self = [super init];
    self.words = [[NSMutableArray alloc] init];
    
    // Find out the path of recipes.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    self.words = [NSMutableArray arrayWithContentsOfFile:path];
    return self;
}

-(void)filterWordsOfLength:(NSInteger)length{
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *string, NSDictionary *bindings) {
        return [string length] == length;
    }];
    NSArray *filteredWords = [self.words filteredArrayUsingPredicate:predicate];
    self.words = [filteredWords mutableCopy];
}

-(NSInteger)numberOfWords{
    return self.words.count;
}

@end
