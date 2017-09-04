//
//  PNKRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKRequest.h"
#import "NSURLSession+PinKit.h"
#import "NSURL+PinKit.h"

@implementation PNKRequest

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.format = @"json";
    }
    return self;
}

- (PNKHTTPMethod)HTTPMethod
{
    return PNKHTTPMethodGET;
}

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"format"] = self.format;
    if(self.authenticationToken)
    {
        parameters[@"auth_token"] = self.authenticationToken;
    }
    return [NSDictionary dictionaryWithDictionary:parameters];
}

- (void)handleCompletionWithJSONObject:(nullable id)object response:(NSHTTPURLResponse *)response error:(nullable NSError *)error
{
    // implemented by the subclass
}

- (NSURLRequest *)URLRequestRelativeToURL:(NSURL *)baseURL
{
    NSParameterAssert(baseURL);
    
    NSString *method = self.HTTPMethod;
    NSURL *URL = [[NSURL URLWithString:self.endpoint relativeToURL:baseURL]
                  pnk_URLByAppendingQueryItems:[self parametersAsURLQueryItems]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = method;
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return [request copy];
}

- (NSArray<NSURLQueryItem *> *)parametersAsURLQueryItems
{
    NSDictionary *parameters = self.parameters;
    __block NSMutableArray *items = [NSMutableArray new];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *value = [NSString stringWithFormat:@"%@", obj];
        NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:key value:value];
        [items addObject:item];
    }];
    
    return [NSArray arrayWithArray:items];
}

@end
