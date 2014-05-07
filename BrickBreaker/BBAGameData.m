//
//  BBASingleton.m
//  BrickBreaker
//
//  Created by Jonathan Fox on 5/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BBAGameData.h"

@implementation BBAGameData

+ (BBAGameData *)mainData
{
    static dispatch_once_t create;
    static BBAGameData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[BBAGameData alloc] init];
    });
    
    return singleton;
}

-(void)setCurrentScore:(NSInteger)currentScore
{
    _currentScore = currentScore;
    
    if (currentScore > _highScore) _highScore = currentScore;
    
    NSLog(@"current score %d top score %d", currentScore, _highScore);
}

- (NSArray *)gameScores
{
    return @[];
}



@end
