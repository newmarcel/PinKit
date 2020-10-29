//
//  PNKGetAllPostsRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKGetAllPostsRequest.h"
#import "PNKPinboardBool.h"
#import "NSArray+PNKMap.h"

@implementation PNKGetAllPostsRequest

- (NSString *)endpoint
{
    return @"/v1/posts/all";
}

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.offset = 0;
        self.resultsCount = 25;
//        self.fetchMetaDataEnabled = YES;
    }
    return self;
}

#pragma mark - Parameters

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super parameters]];
    
    parameters[@"start"] = [NSString stringWithFormat:@"%@", @(self.offset)];
    parameters[@"results"] = [NSString stringWithFormat:@"%@", @(self.resultsCount)];
//    parameters[@"meta"] = PNKPinboardBoolStringFromBool([self isFetchMetaDataEnabled]);
    
    if(self.tags && self.tags.count > 0)
    {
        parameters[@"tag"] = [self.tags componentsJoinedByString:@" "];
    }
    
    return [NSDictionary dictionaryWithDictionary:parameters];
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSArray *bookmarks = nil;
    if(error == nil && [object isKindOfClass:[NSArray class]])
    {
        NSArray *objects = (NSArray *)object;
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
