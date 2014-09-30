//
//  QuizletSearch.m
//  ios_quizlet_client
//
//  Created by Maxim Bilan on 8/19/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//
//  Latest code can be found on GitHub: https://github.com/maximbilan/ios_quizlet_client
//

#import "QuizletSearch.h"
#import "QuizletConfig.h"
#import "QuizletRequest.h"
#import "QuizletAuth.h"

@implementation QuizletSearch

- (void)searchSetsWithParameters:(NSDictionary *)dictionary
                        withAuth:(QuizletAuth *)auth
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/search/sets", QuizletAPIBaseUrl];
    QuizletRequest *request = [[QuizletRequest alloc] init];
    [request requestWithAuth:auth
                      method:QuizletHTTPMethodGET
                        type:QuizletRequestUserAuthenticated
                   urlString:urlString
                  parameters:dictionary
                     success:success
                     failure:failure];
}

- (void)searchDefinitionsWithParameters:(NSDictionary *)dictionary
                               withAuth:(QuizletAuth *)auth
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/search/definitions", QuizletAPIBaseUrl];
    QuizletRequest *request = [[QuizletRequest alloc] init];
    [request requestWithAuth:auth
                      method:QuizletHTTPMethodGET
                        type:QuizletRequestUserAuthenticated
                   urlString:urlString
                  parameters:dictionary
                     success:success
                     failure:failure];
}

- (void)searchGroupsWithParameters:(NSDictionary *)dictionary
                          withAuth:(QuizletAuth *)auth
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/search/groups", QuizletAPIBaseUrl];
    QuizletRequest *request = [[QuizletRequest alloc] init];
    [request requestWithAuth:auth
                      method:QuizletHTTPMethodGET
                        type:QuizletRequestUserAuthenticated
                   urlString:urlString
                  parameters:dictionary
                     success:success
                     failure:failure];
}

- (void)searchUniversalWithParameters:(NSDictionary *)dictionary
                             withAuth:(QuizletAuth *)auth
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/search/universal", QuizletAPIBaseUrl];
    QuizletRequest *request = [[QuizletRequest alloc] init];
    [request requestWithAuth:auth
                      method:QuizletHTTPMethodGET
                        type:QuizletRequestUserAuthenticated
                   urlString:urlString
                  parameters:dictionary
                     success:success
                     failure:failure];
}

@end
