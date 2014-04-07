//
//  TDLGitHubRequest.h
//  ToDo
//
//  Created by Jonathan Fox on 4/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLGitHubRequest : NSObject

+ (NSDictionary *) getUserWithUserName:(NSString *)username;

@end
