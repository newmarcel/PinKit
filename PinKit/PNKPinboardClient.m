//
//  PNKPinboardClient.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKPinboardClient.h"
#import "PinKitMacros.h"
#import "NSURLSession+PinKit.h"
#import "NSError+PinKit.h"
#import "PNKRequest.h"
#import "PNKAuthenticationRequest.h"

static inline NSURL *PNKPinboardBaseURL(void);

@interface PNKPinboardClient ()
@property (copy, nonatomic, readwrite, nullable) NSString *username;
@property (copy, nonatomic, readwrite, nullable) NSString *token;

@property (nonatomic, readwrite) NSURLSession *session;
@end

@implementation PNKPinboardClient

#pragma mark - Life Cycle

- (instancetype)initWithSession:(NSURLSession *)session
{
    NSParameterAssert(session);
    
    self = [super init];
    if(self)
    {
        self.session = session;
    }
    return self;
}

- (instancetype)init
{
    NSURLSession *session = NSURLSession.pinboardURLSession;
    return [self initWithSession:session];
}

- (void)dealloc
{
    [self.session invalidateAndCancel];
}

#pragma mark - Request

- (void)performRequest:(id<PNKRequest>)request
{
    NSParameterAssert(request);
    
    request.authenticationToken = [self authenticationToken];
    NSURLRequest *URLRequest = [request URLRequestRelativeToURL:PNKPinboardBaseURL()];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:URLRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *JSONError;
        NSDictionary *object;
        if(data)
        {
            object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
        }
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        
        if(error == nil && JSONError != nil)
        {
            error = JSONError;
        }
        
        if(error != nil)
        {
            [request handleCompletionWithJSONObject:object response:HTTPResponse error:error];
            return;
        }
        
        if(!PNKHTTPStatusCodeIsSuccess(HTTPResponse.statusCode))
        {
            NSError *error = [NSError pinKitErrorWithCode:HTTPResponse.statusCode];
            [request handleCompletionWithJSONObject:object response:HTTPResponse error:error];
            return;
        }
        
        [request handleCompletionWithJSONObject:object response:HTTPResponse error:error];
    }];
    [task resume];
}

#pragma mark - Authentication

- (void)setUsername:(NSString *)username token:(NSString *)token
{
    NSParameterAssert(username);
    NSParameterAssert(token);
    
    self.username = username;
    self.token = token;
}

- (BOOL)isAuthenticated
{
    return (self.username != nil && self.token != nil);
}

- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password
                      completion:(void(^_Nullable)(BOOL success, NSError * _Nullable error))completion
{
    NSParameterAssert(username);
    NSParameterAssert(password);
    
    self.username = username;
    
    PNKAuthenticationRequest *authRequest = [[PNKAuthenticationRequest alloc] initWithUsername:username password:password];
    authRequest.completionHandler = ^(NSString *token, NSError *error){
        if(error != nil || token == nil)
        {
            self.token = nil;
            self.username = nil;
            completion(NO, error);
            return;
        }
        self.token = token;
        completion(YES, error);
    };
    
    [self performRequest:authRequest];
}

- (nullable NSString *)authenticationToken
{
    if(![self isAuthenticated]) { return nil; }
    return [NSString stringWithFormat:@"%@:%@", self.username, self.token];
}

@end

static inline NSURL *PNKPinboardBaseURL()
{
    return [NSURL URLWithString:@"https://api.pinboard.in/"];
}
