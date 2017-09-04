//
//  PNKDeletePostRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 09.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKDeletePostRequest.h"
#import "PNKPinboardBool.h"
#import "NSDateFormatter+PNKPinboard.h"
#import "NSError+PinKit.h"

@interface PNKDeletePostRequest ()
@property (nonatomic, readwrite) PNKBookmark *bookmark;
@end

@implementation PNKDeletePostRequest

- (NSString *)endpoint
{
    return @"/v1/posts/delete";
}

#pragma mark - Life Cycle

- (instancetype)initWithBookmark:(PNKBookmark *)bookmark
{
    NSParameterAssert(bookmark);
    NSAssert(bookmark.URL != nil, @"The delete request requires a URL.");
    
    self = [super init];
    if(self)
    {
        self.bookmark = bookmark;
    }
    return self;
}

#pragma mark - Parameters

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super parameters]];
    parameters[@"url"] = self.bookmark.URL.absoluteString;
    
    return [NSDictionary dictionaryWithDictionary:parameters];
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    BOOL success = NO;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        NSString *resultCode = ((NSDictionary *)object)[@"result_code"];
        if(resultCode != nil)
        {
            if([resultCode.lowercaseString isEqualToString:@"done"])
            {
                success = YES;
            }
            else
            {
                NSError *unknownError = [NSError pinKitErrorWithCode:PNKErrorUnknown userInfo:@{@"reason": resultCode}];
                [self completeWithSuccess:success error:unknownError];
                return;
            }
        }
    }
    
    [self completeWithSuccess:success error:error];
}

- (void)completeWithSuccess:(BOOL)success error:(NSError *)error
{
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(success, error);
        });
    }
}

@end
