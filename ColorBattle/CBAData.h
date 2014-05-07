//
//  CBAData.h
//  ColorBattle
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBAData : NSObject

+(CBAData *)mainData;

@property (nonatomic) NSInteger redScore;
@property (nonatomic) NSInteger blueScore;

@end
