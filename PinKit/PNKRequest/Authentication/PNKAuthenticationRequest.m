//
//  PNKAuthenticationRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKAuthenticationRequest.h"
#import "PNKDefines.h"

@interface PNKAuthenticationRequest ()
@property (copy, nonatomic, readwrite) NSString *username;
@property (copy, nonatomic, readwrite) NSString *password;
@end

@implementation PNKAuthenticationRequest

- (NSString *)endpoint
{
    return @"/v1/user/api_token";
}

#pragma mark - Life Cycle

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password
{
    NSParameterAssert(username);
    NSParameterAssert(password);
    
    self = [super init];
    if(self)
    {
        self.username = username;
        self.password = password;
    }
    return self;
}

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super parameters]];
    [parameters removeObjectForKey:@"auth_token"];
    return [NSDictionary dictionaryWithDictionary:parameters];
}

- (void)handleCompletionWithJSONObject:(nullable id)dictionary response:(NSURLResponse *)response error:(nullable NSError *)error
{
    NSString *token = dictionary[@"result"];
    [self completeWithToken:token error:error];
}

- (void)completeWithToken:(NSString *)token error:(NSError *)error
{
    PNKAuthenticationRequestCompletionHandler completion = self.completionHandler;
    if(completion != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(token, error);
        });
    }
}

- (NSURLRequest *)URLRequestRelativeToURL:(NSURL *)baseURL
{
    NSMutableURLRequest *request = (NSMutableURLRequest *)[[super URLRequestRelativeToURL:baseURL] mutableCopy];
    
    // Add username and password components to the URL
    NSURLComponents *components = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:YES];
    components.user = self.username;
    components.password = self.password;
    
    request.URL = components.URL;
    return [request copy];
}

@end
