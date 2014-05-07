//
//  BBASingleton.h
//  BrickBreaker
//
//  Created by Jonathan Fox on 5/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBAGameData : NSObject

+ (BBAGameData *)mainData;

@property (nonatomic, readonly) NSInteger highScore;
@property (nonatomic) NSInteger currentScore;

- (NSArray *)gameScores;

@end
