//
//  SCGData.h
//  Squares
//
//  Created by Jonathan Fox on 5/24/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCGData : NSObject

+(SCGData *)mainData;

@property (nonatomic) int numberOfPlayers;
@property (nonatomic) int gridSize;

@end
