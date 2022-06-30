//
//  PNKGetTagsRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <PinKit/PNKGetTagsRequest.h>

@implementation PNKGetTagsRequest

- (NSString *)endpoint
{
    return @"/v1/tags/get";
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSDictionary *tagsAndCounts = nil;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        tagsAndCounts = (NSDictionary *)object;
    }
    
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(tagsAndCounts, error);
        });
    }
}

@end
