//
//  CBAData.m
//  ColorBattle
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CBAData.h"

@implementation CBAData

+(CBAData *)mainData
{
    static dispatch_once_t create;
    static CBAData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[CBAData alloc]init];
    });
    return singleton;
}

-(void)setBlueScore:(NSInteger)blueScore
{
    _blueScore = blueScore;
    NSLog(@"blue score is %d", _blueScore);
    [self totalScore];
}

-(void)setRedScore:(NSInteger)redScore
{
    _redScore = redScore;
    NSLog(@"red score is %d", _redScore);
    [self totalScore];
}

-(NSInteger)totalScore
{
    NSLog(@"Total score is: %d",(_blueScore + _redScore));
    return _blueScore + _redScore;
}

@end
