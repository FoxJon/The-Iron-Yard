//
//  TDLSingleton.m
//  ToDo
//
//  Created by Jonathan Fox on 5/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLSingleton.h"

@implementation TDLSingleton

+ (TDLSingleton *)sharedSingleton
{
    static dispatch_once_t singletonBlock;
    static TDLSingleton * singleton = nil;
    
    dispatch_once(&singletonBlock, ^{
        singleton = [[TDLSingleton alloc] init];
    });
    
    return singleton;
}

@end
