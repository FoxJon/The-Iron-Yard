//
//  BBASingleton.m
//  BrickBreaker
//
//  Created by Jonathan Fox on 5/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BBASingleton.h"

@implementation BBASingleton

+ (BBASingleton *)sharedSingleton
{
    static dispatch_once_t singletonBlock;
    static BBASingleton * singleton = nil;
    
    dispatch_once(&singletonBlock, ^{
        singleton = [[BBASingleton alloc] init];
    });
    
    return singleton;
}

@end
