//
//  PNKGetRecentPostsRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 06.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <PinKit/PNKGetRecentPostsRequest.h>
#import "../../Extensions/NSArray+PNKMap.h"

@implementation PNKGetRecentPostsRequest

- (NSString *)endpoint
{
    return @"/v1/posts/recent";
}

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.resultsCount = 15;
    }
    return self;
}

#pragma mark - Parameters

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super parameters]];
    
    parameters[@"count"] = [NSString stringWithFormat:@"%@", @(self.resultsCount)];
    if(self.tags != nil)
    {
        parameters[@"tag"] = [self.tags componentsJoinedByString:@","];
    }
    
    return [NSDictionary dictionaryWithDictionary:parameters];
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSArray *bookmarks = nil;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary *)object;
        NSArray *objects = dict[@"posts"];
        bookmarks = [objects pnk_flatMap:^id _Nonnull(id  _Nonnull element) {
            return [[PNKBookmark alloc] initWithDictionary:element];
        }];
    }
    
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(bookmarks, error);
        });
    }
}

@end

