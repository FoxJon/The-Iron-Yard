//
//  SFAData.m
//  SFASmileyFace
//
//  Created by Jonathan Fox on 5/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SFAData.h"

@implementation SFAData

+(SFAData *)mainData
{
    static dispatch_once_t create;
    static SFAData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[SFAData alloc]init];
    });
    
    return singleton;
}

@end
