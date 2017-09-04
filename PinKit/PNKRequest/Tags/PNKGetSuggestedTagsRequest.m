//
//  PNKGetSuggestedTagsRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKGetSuggestedTagsRequest.h"

@interface PNKGetSuggestedTagsRequest ()
@property (copy, nonatomic, readwrite) NSURL *URL;
@end

@implementation PNKGetSuggestedTagsRequest

- (NSString *)endpoint
{
    return @"/v1/posts/suggest";
}

#pragma mark - Life Cycle

- (instancetype)initWithURL:(NSURL *)URL
{
    NSParameterAssert(URL);
    
    self = [super init];
    if(self)
    {
        self.URL = URL;
    }
    return self;
}

#pragma mark - Parameters

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super parameters]];
    parameters[@"url"] = self.URL.absoluteString;
    
    return [NSDictionary dictionaryWithDictionary:parameters];
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSArray *popularTags = nil;
    NSArray *recommendedTags = nil;
    if(error == nil && [object isKindOfClass:[NSArray class]])
    {
        NSArray *objects = (NSArray *)object;
        for(NSDictionary *dict in objects)
        {
            if(dict[@"popular"])
            {
                popularTags = [NSArray arrayWithArray:dict[@"popular"]];
            }
            else if(dict[@"recommended"])
            {
                recommendedTags = [NSArray arrayWithArray:dict[@"recommended"]];
            }
        }
    }
    
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(popularTags, recommendedTags, error);
        });
    }
}

@end
