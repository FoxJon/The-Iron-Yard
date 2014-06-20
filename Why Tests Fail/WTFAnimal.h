//
//  WTFAnimal.h
//  Why Tests Fail
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTFAnimal : NSObject

@property (nonatomic) int amountOfLegs;
@property (nonatomic, getter = isCrawling) BOOL crawling;
@property (nonatomic, getter = isHairy) BOOL hairy;
@property (nonatomic) NSMutableArray * foodsItWillEat;

@end
