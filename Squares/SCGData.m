//
//  SCGData.m
//  Squares
//
//  Created by Jonathan Fox on 5/24/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SCGData.h"

@implementation SCGData

+(SCGData *)mainData
{
    static dispatch_once_t create;
    static SCGData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[SCGData alloc]init];
    });
    
    return singleton;
}

@end
