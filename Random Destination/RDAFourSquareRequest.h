//
//  RDAFourSquareRequest.h
//  Random Destination
//
//  Created by Jonathan Fox on 6/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDAFourSquareRequest : NSObject

+ (NSArray *)getVenuesWithLat:(double)latitude andLong:(double)longitude;

@end
