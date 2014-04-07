//
//  TDLGitHubRequest.m
//  ToDo
//
//  Created by Jonathan Fox on 4/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "TDLGitHubRequest.h"

@implementation TDLGitHubRequest

+ (NSDictionary *)getUserWithUserName:(NSString *)username{

    NSMutableDictionary * userInfo = [@{} mutableCopy];
    
    NSString * gitHub = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
    
    NSURL *url = [NSURL URLWithString:gitHub];             //allocating a class method
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];          //allocating a class method
    
//    NSOperationQueue * queue = [[NSOperationQueue alloc] init];

//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        if (connectionError == nil) {
//            
//        } else{
//            NSLog(@"%@", connectionError);
//        }
//    }];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSError * jsonError = nil;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //sendSynchronousRequest returns NSData even though it is an NSURLConnection
    //The & will give respone and error values
    
    NSDictionary * githubProfile = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
    
    //for (NSString *key in [githubProfile allKeys]) {

    NSLog(@"%@", githubProfile);
    
//  if (githubProfile[@"name"] !=nil)[userInfo setObject:githubProfile[@"name"] forKey:@"name"];
    
    if(githubProfile[@"name"] != nil) userInfo[@"name"] = githubProfile[@"name"];
    if(githubProfile[@"avatar_url"] != nil) userInfo[@"image"] = githubProfile[@"avatar_url"];
    if(githubProfile[@"html_url"] != nil) userInfo[@"github"] = githubProfile[@"html_url"];
    if(githubProfile[@"location"] != nil) userInfo[@"location"] = githubProfile[@"location"];

//    userInfo = @{
//                 @"name": githubProfile[@"name"],
//                 @"image": githubProfile[@"avatar_url"],
//                 @"github": githubProfile[@"html_url"],
//                 @"location": githubProfile[@"location"]};

    return userInfo;
}


@end
