//
//  Quizlet.m
//  ios_quizlet_client
//
//  Created by Maxim Bilan on 8/17/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import "Quizlet.h"
#import "QuizletAuth.h"

@interface Quizlet ()

@property (nonatomic, strong, readwrite) NSString *clientID;
@property (nonatomic, strong, readwrite) NSString *secretKey;
@property (nonatomic, strong, readwrite) NSString *redirectURI;
@property (nonatomic, strong, readwrite) QuizletAuth *auth;

@end

@implementation Quizlet

+ (Quizlet *)sharedQuizlet
{
    static dispatch_once_t once_token;
    static Quizlet *quizlet = nil;
    dispatch_once(&once_token, ^{
        quizlet = [[self alloc] init];
    });
    
    return quizlet;
}

- (void)dealloc
{
    self.clientID = nil;
    self.secretKey = nil;
    self.redirectURI = nil;
    self.auth = nil;
}

- (void)startWithClientID:(NSString *)clientId withSecretKey:(NSString *)secretKey withRedirectURI:(NSString *)redirectURI
{
    self.clientID = clientId;
    self.secretKey = secretKey;
    self.redirectURI = redirectURI;
    self.auth = [[QuizletAuth alloc] init];
}

- (void)authorize
{
    [self.auth redirectToAuthServerWithClientID:self.clientID];
}

- (void)handleURL:(NSURL *)url
{
    NSString *res = [url resourceSpecifier];
    
    NSRange r = [res rangeOfString:@"?"];
    NSString *action = r.length ? [res substringToIndex:r.location] : res;
    NSString *paramsQuery = r.length ? [res substringFromIndex:r.location + 1] : nil;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSArray *keyVars = [paramsQuery componentsSeparatedByString:@"&"];
    for (NSString *keyVar in keyVars) {
        NSArray *a = [keyVar componentsSeparatedByString:@"="];
        if ([a count] == 2) {
            params[[a[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] =
            [a[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
#ifdef QUIZLET_LOG
    NSLog(@"URL detected:");
    NSLog(@"  action: %@", action);
    NSLog(@"  params: %@", params);
#endif
    
    if (params[@"code"]) {
        NSString *code = params[@"code"];
        if (code.length > 0) {
            [self.auth requestTokenFromAuthServerWithClientID:self.clientID
                                                withSecretKey:self.secretKey
                                                     withCode:code];
        }
    }
}

@end
