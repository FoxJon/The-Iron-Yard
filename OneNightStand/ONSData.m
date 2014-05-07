//
//  ONSData.m
//  OneNightStand
//
//  Created by Jonathan Fox on 5/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "ONSData.h"

@implementation ONSData

+(ONSData *)mainData
{
    static dispatch_once_t create;
    static ONSData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[ONSData alloc]init];
    });
    
    return singleton;
}


-(id)init
{
    self = [super init];
    if (self) {
        self.controllerName = @"NoController";
        
        NSLog(@"ONSData Created");
    }
    return self;
}


-(NSString *)controllerName
{
    NSLog(@"Getting Controller Name : %@", _controllerName);
    
    return _controllerName;
}

@end
