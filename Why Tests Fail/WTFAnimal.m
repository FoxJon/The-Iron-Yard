//
//  WTFAnimal.m
//  Why Tests Fail
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "WTFAnimal.h"

@implementation WTFAnimal

-(void)setAmountOfLegs:(int)amountOfLegs
{
    _amountOfLegs = amountOfLegs;
    
    self.crawling = (amountOfLegs > 2);
    
    NSLog(@"SETTING LEGS \"%s\"", __PRETTY_FUNCTION__);
}

@end
