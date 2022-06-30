//
//  PNKAddPostRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 08.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <PinKit/PNKAddPostRequest.h>
#import "../../Types/PNKPinboardBool.h"
#import "../../Extensions/NSDateFormatter+PNKPinboard.h"
#import <PinKit/NSError+PinKit.h>

@interface PNKAddPostRequest ()
@property (nonatomic, readwrite) PNKBookmark *bookmark;
@end

@implementation PNKAddPostRequest

- (NSString *)endpoint
{
    return @"/v1/posts/add";
}

#pragma mark - Life Cycle

- (instancetype)initWithBookmark:(PNKBookmark *)bookmark
{
    NSParameterAssert(bookmark);
    NSAssert(bookmark.URL != nil, @"The add request requires a URL.");
    NSAssert(bookmark.title != nil, @"The add request requires a title.");
    
    self = [super init];
    if(self)
    {
        self.bookmark = bookmark;
        self.shouldReplaceExisting = YES;
    }
    return self;
}

#pragma mark - Parameters

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super parameters]];
    
    parameters[@"url"] = self.bookmark.URL.absoluteString;
    parameters[@"description"] = self.bookmark.title;
    
    if(self.bookmark.descriptionText != nil)
    {
        parameters[@"extended"] = self.bookmark.descriptionText;
    }
    if(self.bookmark.tags.count > 0)
    {
        parameters[@"tags"] = [self.bookmark.tags componentsJoinedByString:@" "];
    }
    
    parameters[@"dt"] = [NSDateFormatter.pnk_UTCDateFormatter stringFromDate:self.bookmark.createdAt];
    parameters[@"replace"] = PNKPinboardBoolStringFromBool([self shouldReplaceExisting]);
    parameters[@"shared"] = PNKPinboardBoolStringFromBool([self.bookmark isShared]);
    parameters[@"toread"] = PNKPinboardBoolStringFromBool(![self.bookmark isRead]);
    
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
